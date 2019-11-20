using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BusinessPayment : System.Web.UI.Page
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
            Session["BusinessIDForPayment"] = "";
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (null != Session["BusinessIDForPayment"])
        {
            try
            {
                if (!string.IsNullOrEmpty(lblID.Text) && gvGroup.Rows.Count > 0)
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
                        Insert into payment(PaymentDate,FeetypeID,Amount,Receipt,CollectedBy,BusinessID,remarks,YearID,PaymentStatusID, tarufaDate) values (@PaymentDate,@FeetypeID,@Amount,@Receipt,@CollectedBy,@BusinessID,@remarks,@YearID,@PaymentStatusID,@TarufaDate)else 
                        RAISERROR ('Duplicate', 16,1);";
        //string INSERT = @"Insert into payment(PaymentDate,FeetypeID,Amount,Receipt,CollectedBy,BusinessID,remarks,YearID) values (@PaymentDate,@FeetypeID,@Amount,@Receipt,@CollectedBy,@BusinessID,@remarks,@YearID)";
        try
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
            {
                sqlConnection.Open();

                using (SqlCommand sqlCommand = new SqlCommand(INSERT, sqlConnection))
                {
                    sqlCommand.Parameters.Add("@BusinessID", SqlDbType.VarChar).Value = Session["BusinessIDForPayment"];
                    sqlCommand.Parameters.Add("@FeetypeID", SqlDbType.VarChar).Value = ddlApprovalStatus.SelectedValue;
                    sqlCommand.Parameters.Add("@Amount", SqlDbType.VarChar).Value = txtAmount.Value;
                    sqlCommand.Parameters.Add("@Receipt", SqlDbType.NVarChar).Value = txtReceipt.Value;
                    sqlCommand.Parameters.Add("@YearID", SqlDbType.NVarChar).Value = ddlYear.SelectedValue;
                    sqlCommand.Parameters.Add("@PaymentStatusID", SqlDbType.NVarChar).Value = ddlPaymentStatus.SelectedValue;
                    sqlCommand.Parameters.Add("@remarks", SqlDbType.NVarChar).Value = txtSignBoard.Value;
                    sqlCommand.Parameters.Add("@CollectedBy", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name;
                    //sqlCommand.Parameters.Add("@PaymentDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtApplicationDate.Value);
                    sqlCommand.Parameters.Add("@PaymentDate", SqlDbType.NVarChar).Value = (ddlPaymentStatus.SelectedValue == "2") ? PersianDate.ConvertDate.ToEn(txtApplicationDate.Value).ToShortDateString() : "";
                    sqlCommand.Parameters.Add("@TarufaDate", SqlDbType.NVarChar).Value = (ddlPaymentStatus.SelectedValue == "1") ? DateTime.Today.ToShortDateString() : "";
                    sqlCommand.ExecuteNonQuery();
                    dvError.Visible = false;
                    dvMessage.Visible = true;

                }
                sqlConnection.Close();
            }
        }
        catch (Exception ex)
        {

            //System.Windows.Forms.MessageBox.Show(ex.Message);
            dvError.Visible = true;
            dvMessage.Visible = false;
        }    
        
    }
    void GetPayment(string ID)
    {
        using (ConClass obj=new ConClass())
        {
            DataTable dt = obj.Selectdt("select case when paymentDate is not null then dbo.topersianDate(paymentDate) else null end as PaymentDate,FeetypeID,Amount,Receipt,remarks,yearID,paymentstatusID from payment where ID=" + ID);
            if (dt.Rows.Count > 0)
            {
                txtApplicationDate.Value = dt.Rows[0][0].ToString();
                ddlApprovalStatus.SelectedValue = dt.Rows[0][1].ToString();
                txtAmount.Value = dt.Rows[0][2].ToString();
                txtReceipt.Value = dt.Rows[0][3].ToString();
                txtSignBoard.Value = dt.Rows[0][4].ToString();
                if (dt.Rows[0][1].ToString() == "2")
                {
                    dvSpec.Visible = true;
                }
                if (!string.IsNullOrEmpty(dt.Rows[0][5].ToString()))
                {
                    ddlYear.SelectedValue = dt.Rows[0][5].ToString();
                }
                ddlPaymentStatus.SelectedValue = dt.Rows[0][6].ToString();
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
                txtSignBoard.Value = "";
                ddlPaymentStatus.DataBind();

    }
  
    void Edit()
    {

        string Edit = "update payment set paymentDate=@PaymentDate,FeetypeID=@FeetypeID,Amount=@Amount,Receipt=@Receipt,CollectedBy=@CollectedBy, remarks=@remarks,YearID=@YearID, PaymentStatusID=@PaymentStatusID where ID=@ID";
        try
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
            {
                sqlConnection.Open();

                using (SqlCommand sqlCommand = new SqlCommand(Edit, sqlConnection))
                {
                    sqlCommand.Parameters.Add("@FeetypeID", SqlDbType.VarChar).Value = ddlApprovalStatus.SelectedValue;
                    sqlCommand.Parameters.Add("@Amount", SqlDbType.VarChar).Value = txtAmount.Value;
                    sqlCommand.Parameters.Add("@Receipt", SqlDbType.NVarChar).Value = txtReceipt.Value;
                    sqlCommand.Parameters.Add("@YearID", SqlDbType.NVarChar).Value = ddlYear.SelectedValue;
                    sqlCommand.Parameters.Add("@PaymentStatusID", SqlDbType.NVarChar).Value = ddlPaymentStatus.SelectedValue;
                    sqlCommand.Parameters.Add("@remarks", SqlDbType.NVarChar).Value = txtSignBoard.Value;
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
        string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
        lblID.Text = commandArgs[0];
        string YearID = commandArgs[1];
       
        if (e.CommandName == "Ed")
        {
            GetPayment(lblID.Text);
        }

        else if (e.CommandName == "Del")
        {
            using (ConClass obj = new ConClass())
            {

                obj.execNonQuery("Delete from payment where ID=" + lblID.Text);
                gvPayment.DataBind();
            }
        }
        else if(e.CommandName=="Print")
        {        
           
            Response.Redirect(@"~/Reports/Tarufa3.aspx?ID=" + lblID.Text);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string filter = "1<1";
        if (!string.IsNullOrEmpty(txtCode.Value))
        {
            filter = " b.code=N'" + txtCode.Value+"'";
        }
        if (!HttpContext.Current.User.IsInRole("Admin"))
        {
            filter = filter + " and b.DistrictID=" + HttpContext.Current.Profile["DistrictID"].ToString();
        }

        if (!string.IsNullOrEmpty(txtBusinessName.Value))
        {
            filter = " b.BusinessName=N'" + txtBusinessName.Value + "'";
        }
        if (!string.IsNullOrEmpty(txtName.Value) && !string.IsNullOrEmpty(txtFName.Value))
        {
            filter = " b.OwnerName=N'" + txtName.Value + "' and b.FatherName=N'" + txtFName.Value + "'";
        }
        if (!string.IsNullOrEmpty(filter))
        {
            dsPaymentCategory.SelectCommand = @"select b.ID, b.Code,b.BusinessName,b.OwnerName,b.fathername,d.name_local as District,c.Name_local as Class,b.phone,ct.Name_Local as Category,c.ID as ClassID,ct.ID as CatID from business b left outer join zBusinessClass c on c.ID=b.BusinessClassID
left outer join zDistrict d on d.ID=b.DistrictID left outer join zBusinessCategory ct on ct.ID=b.BusinessCategoryID where "+filter;
            //dsPaymentCategory.SelectParameters[0].DefaultValue= txtCode.Value;
            dsPaymentCategory.DataBind();
            gvGroup.DataBind();
           
            if (gvGroup.Rows.Count > 0)
            {
                using (ConClass obj = new ConClass())
                {

                    Session["BusinessIDForPayment"] = obj.Selectdt("Select b.ID from business b where "+filter).Rows[0][0].ToString();

                }

            }
            else
            {
                Session["BusinessIDForPayment"] = "";
            }
            gvPayment.DataBind();
            
        }
    }
    protected void gvPayment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (HttpContext.Current.User.IsInRole("Admin")|| HttpContext.Current.User.IsInRole("License"))
        {
            //this.gvGroup.Columns[8].Visible = true;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton lnked = (LinkButton)e.Row.FindControl("lnkEdit");
                lnked.Visible = true;
                if (HttpContext.Current.User.IsInRole("Admin"))
                {
                    LinkButton lnkdel = (LinkButton)e.Row.FindControl("lnkDelete");
                    lnkdel.Visible = true;
                }
                LinkButton lnkPrint = (LinkButton)e.Row.FindControl("btnPrint");
                lnkPrint.Visible = true;
            }
        }
    }
    protected void ddlApprovalStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlApprovalStatus.SelectedValue == "1")
        {
            txtAmount.Disabled = true;
            GetAmount();
            dvSpec.Visible = false;
        }
        else if (ddlApprovalStatus.SelectedValue == "2")
        {
            txtAmount.Disabled = false;
            dvSpec.Visible = true;
            txtAmount.Value = "";
        }
        else
        {
            dvSpec.Visible = false;
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
                   
                    txtAmount.Value = obj.Selectdt("Select dbo.funLicenseFeeByID(" + Session["BusinessIDForPayment"].ToString()+ ")").Rows[0][0].ToString();
                }
            }
        }
        catch (Exception ex)
        {

            System.Windows.Forms.MessageBox.Show(ex.Message); 
        }
       
    }

    [WebMethod]
    public static List<string> GetAutoCompleteData(string Code)
    {
        List<string> result = new List<string>();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select top 10 Code as Name from Business where Code LIKE N''+@SearchText+'%'", con))
            {
                con.Open();
                cmd.Parameters.AddWithValue("@SearchText", Code);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    result.Add(dr["Name"].ToString());
                }
                return result;
            }
        }
    }

    [WebMethod]
    public static List<string> GetBusinessName(string Code)
    {
        List<string> result = new List<string>();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select top 10 BusinessName as Name from Business where BusinessName LIKE N''+@SearchText+'%'", con))
            {
                con.Open();
                cmd.Parameters.AddWithValue("@SearchText", Code);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    result.Add(dr["Name"].ToString());
                }
                return result;
            }
        }
    }

    [WebMethod]
    public static List<string> GetOwnerName(string Code)
    {
        List<string> result = new List<string>();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select top 10 OwnerName as Name from Business where OwnerName LIKE N''+@SearchText+'%'", con))
            {
                con.Open();
                cmd.Parameters.AddWithValue("@SearchText", Code);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    result.Add(dr["Name"].ToString());
                }
                return result;
            }
        }
    }
    [WebMethod]
    public static List<string> GetOwnerFatherName(string Code)
    {
        List<string> result = new List<string>();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select top 10 FatherName as Name from Business where FatherName LIKE N''+@SearchText+'%'", con))
            {
                con.Open();
                cmd.Parameters.AddWithValue("@SearchText", Code);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    result.Add(dr["Name"].ToString());
                }
                return result;
            }
        }
    }
}