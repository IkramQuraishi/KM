using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BusinessToVerify : System.Web.UI.Page
{
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    void BindGrid()
    {
        string filter = "1=1 and b.isverified=0";
        if (ddlClass.SelectedValue != "-1" && ddlClass.SelectedIndex!=-1)
        {
            filter = filter + " and b.BusinessClassID=" + ddlClass.SelectedValue;
        }
        if (ddlDistrict.SelectedValue != "-1" && ddlDistrict.SelectedIndex != -1)
        {
            filter = filter + " and b.DistrictID=" + ddlDistrict.SelectedValue;
        }
        if (!string.IsNullOrEmpty(txtCode.Value))
        {
            filter = filter + " and b.code like '%" + txtCode.Value + "%'";
        }
        string sql = @"select b.ID, b.Code,b.BusinessName,b.OwnerName,b.fathername,d.name_local as District,c.Name_local as Class,b.phone from business b left outer join zBusinessClass c on c.ID=b.BusinessClassID
left outer join zDistrict d on d.ID=b.DistrictID where " + filter;
        dsPaymentCategory.SelectCommand = sql;
        gvGroup.DataBind();
    }
    protected void gvGroup_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        lblID.Text = e.CommandArgument.ToString();
        if (e.CommandName == "Ed")
        {
            Session["BusinessID"] = lblID.Text;
            Response.Redirect("Create.aspx");
        }

        else if (e.CommandName == "Del")
        {
            using (ConClass obj=new ConClass())
            {
             
            //obj.execNonQuery("Delete from PaymentCategory where ID=" + e.CommandArgument.ToString());
            //gvGroup.DataBind();   
            }
        }
        else if (e.CommandName == "View")
        {
            Session["BusinessID"] = lblID.Text;
            Response.Redirect("VerifyBusiness.aspx");
        }
    }
   
    protected void gvGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if(!HttpContext.Current.User.IsInRole("Entry"))
        //{
        //    //this.gvGroup.Columns[8].Visible = true;
        //    if (e.Row.RowType == DataControlRowType.DataRow)
        //    {
        //        LinkButton lnked = (LinkButton)e.Row.FindControl("lnkEdit");
        //        lnked.Visible = true;
        //        LinkButton lnkdel = (LinkButton)e.Row.FindControl("lnkDelete");
        //        lnkdel.Visible = true;
        //        LinkButton lnkView = (LinkButton)e.Row.FindControl("lnkView");
        //        lnkView.Visible = true;
        //    }
        //}
    }
    
}