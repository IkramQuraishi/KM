using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UsersForChangePassword : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!HttpContext.Current.User.IsInRole("Admin"))
        {

            Response.Redirect(string.Format("~/AuthenticateError.aspx?Path=Default.aspx"));
        }
        else
        {

            
        }
    }

    

    private void Page_PreRender()
    {
        
            gvUsers.DataSource = Membership.GetAllUsers();       
            gvUsers.DataBind();
        
    }


    protected void gvUsers_DataBound(object sender, EventArgs e)
    {

        if (gvUsers.Rows.Count > 0)
        {
            GridViewRow row = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal);

            for (int i = 0; i <= gvUsers.Columns.Count - 1; i++)
            {
                TableHeaderCell cell = new TableHeaderCell();
                TextBox txtSearch = new TextBox();
                txtSearch.Attributes["placeholder"] = gvUsers.Columns[i].HeaderText;
                if (gvUsers.Columns[i].HeaderText == string.Empty)
                {
                    txtSearch.CssClass = "search_textbox";
                    txtSearch.Width = 0;
                    txtSearch.Enabled = false;
                    txtSearch.BackColor = System.Drawing.Color.Transparent;
                    txtSearch.BorderStyle = BorderStyle.None;
                    //txtSearch.Visible = false;
                }
                else
                {
                    txtSearch.CssClass = "search_textbox";
                }

                cell.Controls.Add(txtSearch);
                row.Controls.Add(cell);
            }
            gvUsers.HeaderRow.Parent.Controls.AddAt(1, row);
            row = new GridViewRow(0, 0, DataControlRowType.DataRow, DataControlRowState.Normal);
            TableCell cel = new TableCell();
            for (int i = 0; i <= gvUsers.Columns.Count - 1; i++)
            {
                row.Controls.Add(cel);
            }
        }


    }
}
