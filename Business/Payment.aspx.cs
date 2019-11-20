using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Payment : System.Web.UI.Page
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
            if (null != Session["BusinessID"])
            {
                btnCreate.HRef = "Create.aspx?ID=" + Session["BusinessID"];
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (null != Session["BusinessID"] && gvGroup.Rows.Count > 0)
        {
            try
            {
                if (!string.IsNullOrEmpty(lblID.Text))
                {
                    Edit();
                }
                else
                {
                    Save();
                }
                gvPayment.DataBind();
                Clear();
            }
            catch (Exception)
            {


            }

        }
        else
        {
            Clear();
        }
      

    }
   
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Clear();
    }
   
    void Save()
    {
        string INSERT = @"if not exists(select ID from payment where BusinessID=@BusinessID and YearID=@YearID and FeeTypeID=@FeeTypeID)if not exists(select ID from payment where receipt=@Receipt) 
                        Insert into payment(PaymentDate,FeetypeID,Amount,Receipt,CollectedBy,BusinessID,remarks,YearID,PaymentStatusID,TarufaDate) values (@PaymentDate,@FeetypeID,@Amount,@Receipt,@CollectedBy,@BusinessID,@remarks,@YearID,@PaymentStatusID,@TarufaDate) else 
                        RAISERROR ('Duplicate', 16,1);";
        //string INSERT = @" if not exists(select ID from payment where BusinessID=@BusinessID and YearID=@YearID and receipt=@Receipt) Insert into payment(PaymentDate,FeetypeID,Amount,Receipt,CollectedBy,BusinessID,YearID) values (@PaymentDate,@FeetypeID,@Amount,@Receipt,@CollectedBy,@BusinessID,@YearID)";
        //string INSERT = @"Insert into payment(PaymentDate,FeetypeID,Amount,Receipt,CollectedBy,BusinessID,YearID) values (@PaymentDate,@FeetypeID,@Amount,@Receipt,@CollectedBy,@BusinessID,@YearID)";
        try
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
            {
                sqlConnection.Open();

                using (SqlCommand sqlCommand = new SqlCommand(INSERT, sqlConnection))
                {
                    sqlCommand.Parameters.Add("@BusinessID", SqlDbType.VarChar).Value = Session["BusinessID"];
                    sqlCommand.Parameters.Add("@FeetypeID", SqlDbType.VarChar).Value = ddlApprovalStatus.SelectedValue;
                    sqlCommand.Parameters.Add("@Amount", SqlDbType.VarChar).Value = txtAmount.Value;
                    sqlCommand.Parameters.Add("@Receipt", SqlDbType.VarChar).Value = txtReceipt.Value;
                    sqlCommand.Parameters.Add("@PaymentStatusID", SqlDbType.NVarChar).Value = ddlPaymentStatus.SelectedValue;
                    sqlCommand.Parameters.Add("@YearID", SqlDbType.VarChar).Value = ddlYear.SelectedValue;
                    sqlCommand.Parameters.Add("@CollectedBy", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name;
                    sqlCommand.Parameters.Add("@PaymentDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtApplicationDate.Value);
                    sqlCommand.Parameters.Add("@TarufaDate", SqlDbType.Date).Value = (ddlPaymentStatus.SelectedValue=="1") ? DateTime.Today.ToShortDateString():"";
                    sqlCommand.ExecuteNonQuery();
                    

                }
                sqlConnection.Close();
            }
        }
        catch (Exception ex)
        {

           
        }    
        
    }
    void GetPayment(string ID)
    {
        using (ConClass obj=new ConClass())
        {
            DataTable dt = obj.Selectdt("select case when paymentDate is not null then dbo.topersianDate(paymentDate) end as PaymentDate,FeetypeID,Amount,Receipt,PaymentStatusID,yearID from payment where ID=" + ID);
            if (dt.Rows.Count > 0)
            {
                txtApplicationDate.Value = dt.Rows[0][0].ToString();
                ddlApprovalStatus.SelectedValue = dt.Rows[0][1].ToString();
                txtAmount.Value = dt.Rows[0][2].ToString();
                txtReceipt.Value = dt.Rows[0][3].ToString();
                ddlPaymentStatus.SelectedValue = dt.Rows[0][4].ToString();
                ddlYear.SelectedValue = dt.Rows[0][5].ToString();
                dt.Dispose();
            }
        }
       
         
    }
    void Clear()
    {
                txtApplicationDate.Value ="";
                ddlApprovalStatus.DataBind();
                txtAmount.Value = "";
                txtReceipt.Value = "";
                lblID.Text = "";
        ddlPaymentStatus.DataBind();
        ddlYear.DataBind();

    }
  
    void Edit()
    {

        string Edit = "if not exists(select ID from payment where receipt=@Receipt)" +
            "update payment set paymentDate=@PaymentDate,FeetypeID=@FeetypeID,Amount=@Amount,Receipt=@Receipt,CollectedBy=@CollectedBy, PaymentStatusID=@PaymentStatusID,YearID=@YearID where ID=@ID";
        try
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
            {
                sqlConnection.Open();

                using (SqlCommand sqlCommand = new SqlCommand(Edit, sqlConnection))
                {
                    sqlCommand.Parameters.Add("@FeetypeID", SqlDbType.VarChar).Value = ddlApprovalStatus.SelectedValue;
                    sqlCommand.Parameters.Add("@Amount", SqlDbType.VarChar).Value = txtAmount.Value;
                    sqlCommand.Parameters.Add("@Receipt", SqlDbType.VarChar).Value = txtReceipt.Value;
                    sqlCommand.Parameters.Add("@PaymentStatusID", SqlDbType.NVarChar).Value = ddlPaymentStatus.SelectedValue;
                    sqlCommand.Parameters.Add("@YearID", SqlDbType.NVarChar).Value = ddlYear.SelectedValue;
                    sqlCommand.Parameters.Add("@CollectedBy", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name;
                    sqlCommand.Parameters.Add("@PaymentDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtApplicationDate.Value);
                    sqlCommand.Parameters.Add("@ID", SqlDbType.Int).Value = lblID.Text;
                    sqlCommand.ExecuteNonQuery();
                }
                sqlConnection.Close();
            }
        }
        catch (Exception ex)
        {

            
        }
      
    }
    protected void gvPayment_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        lblID.Text = e.CommandArgument.ToString();
        if (e.CommandName == "Ed")
        {
            GetPayment(lblID.Text);
        }

        else if (e.CommandName == "Del")
        {
            using (ConClass obj = new ConClass())
            {

                obj.execNonQuery("Delete from payment where ID=" + e.CommandArgument.ToString());
                gvPayment.DataBind();
            }
        }
    }
    protected void ddlApprovalStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlApprovalStatus.SelectedValue == "1")
        {
            txtAmount.Disabled = true;
            GetAmount();
           
        }
       
        else
        {
           
            txtAmount.Disabled = false;
            txtAmount.Value = "";

        }
    }
    void GetAmount()
    {

        try
        {
            using (ConClass obj = new ConClass())
            {
                if (gvGroup.Rows.Count > 0)
                {

                    txtAmount.Value = obj.Selectdt("Select dbo.funLicenseFeeByID(" + Session["BusinessID"].ToString() + ")").Rows[0][0].ToString();
                }
            }
        }
        catch (Exception ex)
        {

            System.Windows.Forms.MessageBox.Show(ex.Message);
        }

    }


    protected void gvPayment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
     
        if (HttpContext.Current.User.IsInRole("Admin") )
         {
            //this.gvGroup.Columns[8].Visible = true;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton lnked = (LinkButton)e.Row.FindControl("lnkEdit");
                lnked.Visible = true;
                LinkButton lnkdel = (LinkButton)e.Row.FindControl("lnkDelete");
                lnkdel.Visible = true;
              
            }
       
        }
   }
}