using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
    {
        if (!Membership.ValidateUser(Login1.UserName, Login1.Password))
        {
           
            dvError.Visible = true;
            e.Authenticated = false;
        }
        else
        {
            e.Authenticated = true;
            
            dvError.Visible = false;
        }
 
    }
  
}