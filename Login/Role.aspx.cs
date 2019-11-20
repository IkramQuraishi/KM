using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class Role : System.Web.UI.Page
{
    private bool createRoleSuccess = true;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            if (Request.IsAuthenticated && !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
            {
                // This is an unauthorized, authenticated request...
                Response.Redirect("~/UnAuthorize.aspx");
            }
        }
    }
    private void Page_PreRender()
    {
        // Create a DataTable and define its columns
        DataTable RoleList = new DataTable();
        RoleList.Columns.Add("Role Name");
        RoleList.Columns.Add("User Count");

        string[] allRoles = Roles.GetAllRoles();

        // Get the list of roles in the system and how many users belong to each role
        foreach (string roleName in allRoles)
        {
            int numberOfUsersInRole = Roles.GetUsersInRole(roleName).Length;
            string[] roleRow = { roleName, numberOfUsersInRole.ToString() };
            RoleList.Rows.Add(roleRow);
        }

        // Bind the DataTable to the GridView
        UserRoles.DataSource = RoleList;
        UserRoles.DataBind();

        if (createRoleSuccess)
        {
            // Clears form field after a role was successfully added. Alternative to redirect technique I often use.
            NewRole.Text = "";
        }
    }
    public void AddRole(object sender, EventArgs e)
    {
        try
        {
            Roles.CreateRole(NewRole.Text);
            ConfirmationMessage.InnerText = "";
            createRoleSuccess = true;
        }
        catch (Exception ex)
        {
            ConfirmationMessage.InnerText = ex.Message;
            createRoleSuccess = false;
        }
    }
    public void DeleteRole(object sender, CommandEventArgs e)
    {
        try
        {
            Roles.DeleteRole(e.CommandArgument.ToString());
            ConfirmationMessage.InnerText = "Role '" + e.CommandArgument.ToString() + "' was deleted.";
        }
        catch (Exception ex)
        {
            ConfirmationMessage.InnerText = ex.Message;
        }
    }
}
