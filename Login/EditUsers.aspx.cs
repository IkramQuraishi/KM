using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class EditUsers : System.Web.UI.Page
{
    string username;
    MembershipUser user;
    ConClass obj = new ConClass();
    string userID;

    ProfileCommon userProfile;
    protected void Page_Load(object sender, EventArgs e)
    {
        username = Request.QueryString["username"];
        
        if (username == null || username == "")
        {
            Response.Redirect("users.aspx");
        }
        user = Membership.GetUser(username);
        userID = user.ProviderUserKey.ToString();
        UserUpdateMessage.Text = "";
        userProfile = Profile.GetProfile(username);
        
    }

    private void Page_PreRender()
    {
        // Load the User Roles into checkboxes.
        UserRoles.DataSource = Roles.GetAllRoles();
        
        UserRoles.DataBind();

        // Disable checkboxes if appropriate:
        if (UserInfo.CurrentMode != DetailsViewMode.Edit)
        {
            foreach (ListItem checkbox in UserRoles.Items)
            {
                checkbox.Enabled = false;
            }
           // DDLAgency.Enabled = false;
        }

        // Bind these checkboxes to the User's own set of roles.
        string[] userRoles = Roles.GetRolesForUser(username);
        foreach (string role in userRoles)
        {
            ListItem checkbox = UserRoles.Items.FindByValue(role);
            checkbox.Selected = true;
        }
           
        //bind Agency Dropdownlist
        int agencyID = Profile.DistrictID;
        //DDLAgency.SelectedValue = agencyID.ToString();
    }
    protected void UserInfo_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        //Need to handle the update manually because MembershipUser does not have a
        //parameterless constructor  

        user.Email = (string)e.NewValues[0];
     
        user.IsApproved = (bool)e.NewValues[1];
        
        try
        {
            // Update user info:
            Membership.UpdateUser(user);
            
           //update profile 
          
            UpdateAgency();
            UpdateLocation();
           //UpdateEmployee();
            // Update user roles:
            UpdateUserRoles();

            UserUpdateMessage.Text = "تغیر اجرا شد";

            e.Cancel = true;
            UserInfo.ChangeMode(DetailsViewMode.ReadOnly);
        }
        catch (Exception ex)
        {
            UserUpdateMessage.Text = "تغیر اجرا نشد: " + ex.Message;

            e.Cancel = true;
            UserInfo.ChangeMode(DetailsViewMode.ReadOnly);
        }
    }
   
    void UpdateAgency()
    {
        
        DropDownList ddl = (DropDownList)UserInfo.FindControl("DDLAgency");

        if (UserInfo.CurrentMode == DetailsViewMode.Edit)
        {
            if (!string.IsNullOrEmpty(ddl.SelectedValue.ToString()))
            {
                userProfile.DistrictID = Convert.ToInt32(ddl.SelectedValue.ToString());
            }
            else
            {
                userProfile.DistrictID = -1;
            }
            userProfile.Save();
        }
    }
    void UpdateLocation()
    {

        DropDownList ddl = (DropDownList)UserInfo.FindControl("ddlLocation");

        if (UserInfo.CurrentMode == DetailsViewMode.Edit)
        {
            if (!string.IsNullOrEmpty(ddl.SelectedValue.ToString()))
            {
                userProfile.ProvinceID = Convert.ToInt32(ddl.SelectedValue.ToString());
            }

            else
            {
                userProfile.ProvinceID = -1;
            }
            userProfile.Save();
        }
    }
   
    private void UpdateUserRoles()
    {
        
        foreach (ListItem rolebox in UserRoles.Items)
        {
            if (rolebox.Selected)
            {
                if (!Roles.IsUserInRole(username, rolebox.Text))
                {
                    Roles.AddUserToRole(username, rolebox.Text);
                }
            }
            else
            {
                if (Roles.IsUserInRole(username, rolebox.Text))
                {
                    Roles.RemoveUserFromRole(username, rolebox.Text);
                }
            }
        }
    }

    public void DeleteUser(object sender, EventArgs e)
    {
        //Membership.DeleteUser(username, false); // DC: My apps will NEVER delete the related data.
        Membership.DeleteUser(username, true); // DC: except during testing, of course!
        Response.Redirect("users.aspx");
    }

    public void UnlockUser(object sender, EventArgs e)
    {
        // Dan Clem, added 5/30/2007 pot-live upgrade.

        // Unlock the user.
        user.UnlockUser();

        // DataBind the GridView to reflect same.
        UserInfo.DataBind();
    }

    string ReturnProvince(int ID)
    {
        string province = "";
        try
        {
            SqlDataReader rd = obj.Selectdr("Select Name_Local as Name from zProvince where iD=" + ID);
            while (rd.Read())
            {
                province = rd.GetValue(0).ToString();
            }
            rd.Close();
        }
        catch (Exception)
        {
            
           
        }
        return province;
    }
    string ReturnDepartment(int ID)
    {
        string department = "";
        try
        {
            SqlDataReader rd = obj.Selectdr("Select name_local as Name from zdistrict where iD=" + ID);
            while (rd.Read())
            {
                department = rd.GetValue(0).ToString();
            }
            rd.Close();
        }
        catch (Exception)
        {


        }
        return department;
    }
   
    protected void UserInfo_DataBound(object sender, EventArgs e)
    {
        ProfileCommon userProfile = Profile.GetProfile(username);
         if (UserInfo.CurrentMode == DetailsViewMode.ReadOnly)
            {
                Label lbl = (Label)UserInfo.FindControl("lbAgency");
                Label lblEmployee = (Label)UserInfo.FindControl("lblLocation");
               
                lbl.Text = ReturnDepartment(userProfile.DistrictID);
                lblEmployee.Text = ReturnProvince(userProfile.ProvinceID);
                
               
            }
            if (UserInfo.CurrentMode == DetailsViewMode.Edit)
            {
                DropDownList ddlAg = (DropDownList)UserInfo.FindControl("DDLAgency");
                DropDownList ddlEmp = (DropDownList)UserInfo.FindControl("ddlLocation");
                if (!string.IsNullOrEmpty(userProfile.DistrictID.ToString()))
                {
                    ddlAg.SelectedValue = userProfile.DistrictID.ToString();
                }
                if (!string.IsNullOrEmpty(userProfile.ProvinceID.ToString()))
                {
                   // BindCombo("select ID,Name from staff union select null,'--Select--' order by ID", ddlEmp);
                    ddlEmp.SelectedValue = userProfile.ProvinceID.ToString();
                }
            }

            int commandRowIndex = UserInfo.Rows.Count - 1;
            if (commandRowIndex > 0)
            {
                DetailsViewRow commandRow = UserInfo.Rows[commandRowIndex];
                DataControlFieldCell cell = (DataControlFieldCell)commandRow.Controls[0];

                foreach (Control ctrl in cell.Controls)
                {
                    if (ctrl is Button)
                    {
                        Button ibt = (Button)ctrl;
                        if (ibt.CommandName == "Delete")
                        {
                            ibt.ToolTip = "Click here to Delete";
                            //ibt.CommandName = "Delete";
                            ibt.Attributes["onClick"] = "if (!confirm('آیا شما میخواهید این کاربر را حذف نماید؟')) return;";
                        }
                    }
                }
            }
    }
   
    void BindCombo(string sql, DropDownList ddl)
    {
        try
        {
            System.Data.DataTable dt = obj.Selectdt(sql);
            ddl.DataSource = dt;
            ddl.DataTextField = "Name";
            ddl.DataValueField = "ID";
            ddl.DataBind();
            
        }
        catch (Exception)
        {
            
            throw;
        }
            
    }
    protected void UserInfo_ItemCommand(object sender, DetailsViewCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            Membership.DeleteUser(username, true); // DC: except during testing, of course!
            Response.Redirect("users.aspx");
        }
    }
}
