using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BusinessLicense : System.Web.UI.Page
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
            txtIssueDate.Attributes["onclick"] = "PersianDatePicker.Show(this,'" + today + "');";
            //txtExpiryDate.Attributes["onclick"] = "PersianDatePicker.Show(this,'" + today + "');";
            Session["BusinessIDForLicense"] = "";
            if (Request.QueryString.Count > 0 && !string.IsNullOrEmpty(Request.QueryString["BusinessID"].ToString()))
            {
                BindGrid(Request.QueryString["BusinessID"].ToString());
            }
            else
            {
                BindGrid("");
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (null != Session["BusinessIDForLicense"])
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
        string INSERT = @"Insert into BusinessLicense(IssueDate,ExpirationDate,StatusID,BusinessID,IssuedBy) values (@IssueDate,@ExpirationDate,@StatusID,@BusinessID,@IssuedBy)";
        try
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
            {
                sqlConnection.Open();

                using (SqlCommand sqlCommand = new SqlCommand(INSERT, sqlConnection))
                {
                    sqlCommand.Parameters.Add("@BusinessID", SqlDbType.VarChar).Value = Session["BusinessIDForLicense"];
                    //sqlCommand.Parameters.Add("@StatusID", SqlDbType.VarChar).Value = ddlStatus.SelectedValue;
                    sqlCommand.Parameters.Add("@StatusID", SqlDbType.VarChar).Value = "1";
                    sqlCommand.Parameters.Add("@IssuedBy", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name;
                    sqlCommand.Parameters.Add("@IssueDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtIssueDate.Value);
                    //sqlCommand.Parameters.Add("@ExpirationDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtExpiryDate.Value);
                    sqlCommand.Parameters.Add("@ExpirationDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtIssueDate.Value).AddYears(5);
                    sqlCommand.ExecuteNonQuery();
                    

                }
                sqlConnection.Close();
            }
        }
        catch (Exception)
        {

           
        }    
        
    }
    void GetPayment(string ID)
    {
        using (ConClass obj=new ConClass())
        {
            DataTable dt = obj.Selectdt("select dbo.topersianDate(IssueDate) as IssueDate,dbo.topersianDate(ExpirationDate) as ExpiryDate,StatusID from BusinessLicense where ID=" + ID);
            if (dt.Rows.Count > 0)
            {
                txtIssueDate.Value = dt.Rows[0][0].ToString();
                //txtExpiryDate.Value = dt.Rows[0][1].ToString();
                //ddlStatus.SelectedValue = dt.Rows[0][2].ToString();
                
                dt.Dispose();
            }
        }
       
         
    }
    void Clear()
    {

        txtIssueDate.Value = "";
        //txtExpiryDate.Value = "";
        //ddlStatus.DataBind();
                lblID.Text = "";

    }
  
    void Edit()
    {

        string Edit = "update BusinessLicense set IssueDate=@IssueDate,ExpirationDate=@ExpirationDate,StatusID=@StatusID where ID=@ID";

        using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            sqlConnection.Open();

            using (SqlCommand sqlCommand = new SqlCommand(Edit, sqlConnection))
            {
                //sqlCommand.Parameters.Add("@StatusID", SqlDbType.VarChar).Value = ddlStatus.SelectedValue;
                sqlCommand.Parameters.Add("@StatusID", SqlDbType.VarChar).Value = "1";
                sqlCommand.Parameters.Add("@IssuedBy", SqlDbType.VarChar).Value = HttpContext.Current.User.Identity.Name;
                sqlCommand.Parameters.Add("@IssueDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtIssueDate.Value);
                //sqlCommand.Parameters.Add("@ExpirationDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtExpiryDate.Value);
                sqlCommand.Parameters.Add("@ExpirationDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtIssueDate.Value).AddYears(5);
               
                sqlCommand.Parameters.Add("@ID", SqlDbType.Int).Value = lblID.Text;
                sqlCommand.ExecuteNonQuery();
            }
            sqlConnection.Close();
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

                obj.execNonQuery("Delete from BusinessLicense where ID=" + e.CommandArgument.ToString());
                gvPayment.DataBind();
            }
        }
        else  if (e.CommandName == "print")
        {
            Session["LicenseID"] = e.CommandArgument.ToString();
            Response.Redirect("~/Reports/PrintCertificate.aspx");
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid(""); 
    }
    protected void BindGrid(string BusinessID)
    {
        string filter = "1<1";
        if (!string.IsNullOrEmpty(txtCode.Value))
        {
            filter = " b.code=N'" + txtCode.Value + "'";
        }
        if (!string.IsNullOrEmpty(txtName.Value))
        {
            filter = " b.BusinessName=N'" + txtName.Value + "'";
        }
        if (!string.IsNullOrEmpty(BusinessID))
        {
            filter = " b.ID="+BusinessID;
        }

        if (!string.IsNullOrEmpty(filter))
        {
//            dsPaymentCategory.SelectCommand = @"select b.ID, b.Code,b.BusinessName,b.OwnerName,b.fathername,d.name_local as District,c.Name_local as Class,b.phone,ct.Name_Local as Category from business b left outer join zBusinessClass c on c.ID=b.BusinessClassID
//left outer join zDistrict d on d.ID=b.DistrictID left outer join zBusinessCategory ct on ct.ID=b.BusinessCategoryID where b.ID in (select BusinessID from payment where yearID=left(dbo.topersianDate(getdate()),4)) and " + filter;

            dsPaymentCategory.SelectCommand = @"select b.ID, b.Code,b.BusinessName,b.OwnerName,b.fathername,d.name_local as District,c.Name_local as Class,b.phone,ct.Name_Local as Category from business b left outer join zBusinessClass c on c.ID=b.BusinessClassID
            left outer join zDistrict d on d.ID=b.DistrictID left outer join zBusinessCategory ct on ct.ID=b.BusinessCategoryID where " + filter;
            //dsPaymentCategory.SelectParameters[0].DefaultValue= txtCode.Value;
            dsPaymentCategory.DataBind();
            gvGroup.DataBind();

            if (gvGroup.Rows.Count > 0)
            {
                using (ConClass obj = new ConClass())
                {

                    Session["BusinessIDForLicense"] = obj.Selectdt("Select b.ID from business b where " + filter).Rows[0][0].ToString();
                }

            }
            else
            {
                Session["BusinessIDForLicense"] = "";
            }
            gvPayment.DataBind();

        }
    }
    protected void gvPayment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (HttpContext.Current.User.IsInRole("Admin") || HttpContext.Current.User.IsInRole("License"))
        {
            //this.gvGroup.Columns[8].Visible = true;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //LinkButton lnked = (LinkButton)e.Row.FindControl("lnkEdit");
                //lnked.Visible = true;
                LinkButton lnkdel = (LinkButton)e.Row.FindControl("lnkDelete");
                if (HttpContext.Current.User.IsInRole("Admin"))
                {
                    lnkdel.Visible = true;
                }
                LinkButton lnkPrint = (LinkButton)e.Row.FindControl("lnkPrint");
                lnkPrint.Visible = true;
              
            }
        }
    }

  [WebMethod]
    public static List<string> GetAutoCompleteData(string Code)
    {
        List<string>result = new List<string>();
 
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select DISTINCT BusinessName as Name from Business where BusinessName LIKE N''+@SearchText+'%'", con))
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