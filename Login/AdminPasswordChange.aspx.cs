using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Text;
using System.Security.Cryptography;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Web.Security;
using System.Configuration;
using System.Data;

public partial class AdminPasswordChange : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (!HttpContext.Current.User.IsInRole("Admin"))
            {

                Response.Redirect(string.Format("~/AuthenticateError.aspx?Path=Default.aspx"));
            }
            else
            {
                // If querystring value is missing, send the user to ManageUsers.aspx
                string userName = Request.QueryString["user"];
                if (string.IsNullOrEmpty(userName))
                    Response.Redirect("UsersForChangePassword.aspx");


                // Get information about this user
                MembershipUser usr = Membership.GetUser(userName);
                if (usr == null)
                    Response.Redirect("UsersForChangePassword.aspx");

                UserNameLabel.Text = usr.UserName;
                CreationDateLabel.Text = usr.CreationDate.ToShortDateString();
                LastPasswordChangedDateLabel.Text = usr.LastPasswordChangedDate.ToShortDateString();
            }
        }
    }

    protected void CancelUpdate_Click(object sender, EventArgs e)
    {
        // Return the user to ManageUsers.aspx
        Response.Redirect("UsersForChangePassword.aspx");
    }

    protected void UpdateUser_Click(object sender, EventArgs e)
    {
        // Update the user information as needed...
        if (!Page.IsValid)
            return;

        string userName = Request.QueryString["user"];

        // Did the user supply a new password?
        if (NewPassword1.Text.Length > 0)
        {
            if (ValidPassword(NewPassword1.Text))
            {
                SqlMembershipProvider sqlProvider = Membership.Provider as SqlMembershipProvider;

                // Invoke the aspnet_Membership_SetPassword sproc
                using (SqlConnection myConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
                {
                    myConnection.Open();        // Open the connection

                    // Get the salt for this user
                    string salt = null;
                    SqlCommand myGetSaltCommand = new SqlCommand("aspnet_Membership_GetPasswordWithFormat", myConnection);
                    myGetSaltCommand.CommandType = CommandType.StoredProcedure;

                    // Add the in parameters
                    myGetSaltCommand.Parameters.AddWithValue("@ApplicationName", Membership.ApplicationName);
                    myGetSaltCommand.Parameters.AddWithValue("@UserName", userName);
                    myGetSaltCommand.Parameters.AddWithValue("@UpdateLastLoginActivityDate", false);
                    myGetSaltCommand.Parameters.AddWithValue("@CurrentTimeUtc", DateTime.UtcNow);

                    // Retrieve the salt
                    SqlDataReader mySaltReader = myGetSaltCommand.ExecuteReader(CommandBehavior.SingleRow);
                    if (mySaltReader.Read())
                        salt = mySaltReader.GetString(2);       // Read in the password salt
                    else
                        // No information for user account!
                        throw new ApplicationException("User account not found in Membership...");
                    mySaltReader.Close();

                    // Encode the password
                    object encodedPassword = EncodePassword(NewPassword1.Text, salt);


                    // Change the user's password
                    SqlCommand mySetPasswordCommand = new SqlCommand("aspnet_Membership_SetPassword", myConnection);
                    mySetPasswordCommand.CommandType = CommandType.StoredProcedure;

                    // Add the in parameters
                    mySetPasswordCommand.Parameters.AddWithValue("@ApplicationName", Membership.ApplicationName);
                    mySetPasswordCommand.Parameters.AddWithValue("@UserName", userName);
                    mySetPasswordCommand.Parameters.AddWithValue("@NewPassword", encodedPassword);
                    mySetPasswordCommand.Parameters.AddWithValue("@PasswordSalt", salt);
                    mySetPasswordCommand.Parameters.AddWithValue("@PasswordFormat", (int)sqlProvider.PasswordFormat);
                    mySetPasswordCommand.Parameters.AddWithValue("@CurrentTimeUtc", DateTime.UtcNow);

                    // Update the user's password
                    mySetPasswordCommand.ExecuteNonQuery();

                    StatusMessage.Text = "The password has been updated...";

                    myConnection.Close();   // Close the connection
                }
            }
        }
    }

    private bool ValidPassword(string password)
    {
        // Ensure that the password is not too long or too short
        if (password.Length > 128)
        {
            StatusMessage.Text = "The password cannot exceed 128 characters.";
            return false;
        }
        else if (password.Length < Membership.MinRequiredPasswordLength)
        {
            StatusMessage.Text = string.Format("The password must contain at least {0} characters.", Membership.MinRequiredPasswordLength);
            return false;
        }

        // Determine how many non-alphanumeric characters are in the password
        int nonAlphanumericCharacters = 0;
        for (int i = 0; i < password.Length; i++)
            if (!char.IsLetterOrDigit(password, i))
                nonAlphanumericCharacters++;

        if (nonAlphanumericCharacters < Membership.MinRequiredNonAlphanumericCharacters)
        {
            StatusMessage.Text = string.Format("The password must contain at least {0} non-alphanumeric characters.", Membership.MinRequiredNonAlphanumericCharacters);
            return false;
        }

        // Check the PasswordStrengthRegularExpression, if specified
        if (!string.IsNullOrEmpty(Membership.PasswordStrengthRegularExpression))
        {
            if (!Regex.IsMatch(password, Membership.PasswordStrengthRegularExpression))
            {
                StatusMessage.Text = "The password does not meet the necessary strength requirements.";
                return false;
            }
        }

        // If we get this far, the password is valid
        return true;
    }

    private object EncodePassword(string password, string salt)
    {
        // Determine how the password is to be formatted
        SqlMembershipProvider sqlProvider = Membership.Provider as SqlMembershipProvider;

        // If it's Clear, just return password
        if (sqlProvider.PasswordFormat == MembershipPasswordFormat.Clear)
            return password;

        // Create the byte arrays to hold the encoded passwords
        byte[] bytes = Encoding.Unicode.GetBytes(password);
        byte[] src = Convert.FromBase64String(salt);
        byte[] dst = new byte[src.Length + bytes.Length];

        // Copy the src and bytes arrays to the dst array
        System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
        System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

        if (sqlProvider.PasswordFormat == MembershipPasswordFormat.Hashed)
        {
            // We need to hash the password
            HashAlgorithm algorithm = HashAlgorithm.Create(Membership.HashAlgorithmType);
            return Convert.ToBase64String(algorithm.ComputeHash(dst));
        }
        else
        {
            // TODO: Handle encoded passwords
            throw new ApplicationException("TODO: Handle encoded passwords...");
        }
    }
}
