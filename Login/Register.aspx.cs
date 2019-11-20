using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_Register : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        RegisterUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
        if (!Page.IsPostBack)
        {
            if (Request.IsAuthenticated && !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
            {
                // This is an unauthorized, authenticated request...
                Response.Redirect("~/UnAuthorize.aspx");
            }
            //DropDownList role = (DropDownList)RegisterUser.CreateUserStep.ContentTemplateContainer.FindControl("role");
            //if (role != null)
            //{
            //    //role.DataSource = Roles.GetAllRoles();

            //    //role.DataBind();
            //    string[] allRoles = Roles.GetAllRoles();
            //    foreach (string roles in allRoles)
            //    {
            //        role.Items.Add(new ListItem(roles));
            //    }
            //}
        }
    }

    protected void RegisterUser_CreatedUser(object sender, EventArgs e)
    {
        ProfileCommon p = (ProfileCommon)ProfileCommon.Create((sender as CreateUserWizard).UserName, true);
       
     
        //FormsAuthentication.SetAuthCookie(RegisterUser.UserName,false /* createPersistentCookie */);
        //string continueUrl = RegisterUser.ContinueDestinationPageUrl;
        //if (String.IsNullOrEmpty(continueUrl))
        //{
        //    continueUrl = "~/";
        //}
        //Response.Redirect(continueUrl);
    }


    protected void CompleteWizardStep1_Activate(object sender, EventArgs e)
    {
        Response.Redirect("Users.aspx");
    }
}
