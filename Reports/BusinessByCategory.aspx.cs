using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BusinessByCategory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvGroup.DataBind();
    }
    private int Total = 0;
    protected void gvGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
            // if row type is DataRow
            Total += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Businesses"));
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[0].Text = "مجموع";
            e.Row.Cells[1].Text = String.Format("{0:N0}", Total);
        }
    }
    
}