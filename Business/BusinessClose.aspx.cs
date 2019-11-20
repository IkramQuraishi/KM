using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BusinessClose : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.IsAuthenticated && !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
            {
                // This is an unauthorized, authenticated request...
                Response.Redirect("~/UnAuthorize.aspx");
            }
            var now = PersianDateTime.Now;
            var today = now.ToString(PersianDateTimeFormat.Date);
            txtApplicationDate.Attributes["onclick"] = "PersianDatePicker.Show(this,'" + today + "');";
        
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Edit();
        BindGrid();
        pnl.Visible = false;
    }
   
   
  
    void Edit()
    {

        string Edit = "update Business set BusinessStatusID=2,BusinessCloseDate=@CloseDate,BusinessCloseReason=@BusinessCloseReason where ID=@ID";

        using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            sqlConnection.Open();

            using (SqlCommand sqlCommand = new SqlCommand(Edit, sqlConnection))
            {
               
                sqlCommand.Parameters.Add("@BusinessCloseReason", SqlDbType.NVarChar).Value = txtReceipt.Value;

                sqlCommand.Parameters.Add("@CloseDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtApplicationDate.Value);
                sqlCommand.Parameters.Add("@ID", SqlDbType.Int).Value = Session["ID"];
                sqlCommand.ExecuteNonQuery();
            }
            sqlConnection.Close();
        }
    }
    protected void gvPayment_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        
    }
    void BindGridPage()
    {
        string filter = "1>1";
        if (ddlSearch.SelectedValue == "1" && !string.IsNullOrEmpty(txtSearch.Value))
        {
            filter = " b.code='" + txtSearch.Value + "'";
        }
        if (ddlSearch.SelectedValue == "2" && !string.IsNullOrEmpty(txtSearch.Value))
        {
            filter = " b.tazkira=N'" + txtSearch.Value + "'";
        }
        if (ddlSearch.SelectedValue == "3" && !string.IsNullOrEmpty(txtSearch.Value))
        {
            filter = " b.BusinessName like N'%" + txtSearch.Value.Trim() + "%'";
        }

        dsPaymentCategory.SelectCommand = @"select b.ID, b.Code,b.BusinessName,b.OwnerName,b.fathername,d.name_local as District,c.Name_local as Class,dbo.ToPersianDate(isnull(b.BusinessCloseDate,'')) as CloseDate,b.BusinessCloseReason as CloseReason,b.phone,ct.Name_Local as Category,c.ID as ClassID,ct.ID as CatID from business b left outer join zBusinessClass c on c.ID=b.BusinessClassID
left outer join zDistrict d on d.ID=b.DistrictID left outer join zBusinessStatus ct on ct.ID=b.BusinessStatusID where " + filter;

        dsPaymentCategory.DataBind();
        gvGroup.DataBind();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGridPage();
           
      
    }

    void BindGrid()
    {
        dsPaymentCategory.SelectCommand = @"select b.ID, b.Code,b.BusinessName,b.OwnerName,b.fathername,d.name_local as District,c.Name_local as Class,dbo.ToPersianDate(isnull(b.BusinessCloseDate,'')) as CloseDate,b.BusinessCloseReason as CloseReason,b.phone,ct.Name_Local as Category,c.ID as ClassID,ct.ID as CatID from business b left outer join zBusinessClass c on c.ID=b.BusinessClassID
left outer join zDistrict d on d.ID=b.DistrictID left outer join zBusinessStatus ct on ct.ID=b.BusinessStatusID where b.ID=" + Session["ID"];

        dsPaymentCategory.DataBind();
        gvGroup.DataBind();
    }
  
    protected void gvGroup_RowCommand(object sender, GridViewCommandEventArgs e)
    {
       

       if (e.CommandName == "Del")
        {
            GridViewRow row = (GridViewRow)((LinkButton)e.CommandSource).NamingContainer;             
            string[] arg = new string[2];
            arg = e.CommandArgument.ToString().Split(';');
            Session["ID"] = arg[0];
            Session["StatusID"] = arg[1];
            if (arg[1] == "1")
            {
                pnl.Visible = true;
               
                //row.BackColor = System.Drawing.Color.Aqua;

            }
               
           
        }
    }
    protected void gvGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[9].Text == "1278/10/11")
            {
                e.Row.Cells[9].Text = "";
            }
        }
    }

    protected void gvGroup_PageIndexChanged(object sender, EventArgs e)
    {
        BindGridPage();
    }

    protected void lnkDelete_Click(object sender, EventArgs e)
    {
        LinkButton btn = (LinkButton)sender;
        GridViewRow gvr = (GridViewRow)btn.NamingContainer;
        int rowindex = gvr.RowIndex;
        gvGroup.Rows[rowindex].BackColor = System.Drawing.Color.Aqua;
    }
}