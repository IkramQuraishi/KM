using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Assessment : System.Web.UI.Page
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
            LoadForm();
        }
    }
    void LoadForm()
    {
        
        try
        {
            using (ConClass obj = new ConClass())
            {
                DataTable dt = obj.Selectdt("select dbo.topersianDate(AssessmentDate) as AssessmentDate,ApprovalStatusID,ApprovalRemarks,ApprovedBy,Capital,AnnualSales,EmployeeMale,EmployeeFemale,latitude,longitude from business where ID=" + Session["BusinessID"].ToString());
                if (dt.Rows.Count > 0)
                {
                    txtApplicationDate.Value = dt.Rows[0][0].ToString();
                    ddlApprovalStatus.SelectedValue = dt.Rows[0][1].ToString();
                    txtRemarks.Value = dt.Rows[0][2].ToString();
                    txtApprovedBy.Value = dt.Rows[0][3].ToString();
                    txtCapital.Value = dt.Rows[0][4].ToString();
                    txtAnnualSales.Value = dt.Rows[0][5].ToString();
                    txtMale.Value = dt.Rows[0][6].ToString();
                    txtFemale.Value = dt.Rows[0][7].ToString();
                    txtLat.Value = dt.Rows[0][8].ToString();
                    txtLong.Value = dt.Rows[0][9].ToString();

                }
                
            }

        }
        catch (Exception)
        {
            
           
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (null != Session["BusinessID"] && gvGroup.Rows.Count>0)
        {
            Save();
            dvMessage.Visible = true;
            dvError.Visible = false;
        }
        else
        {
            dvMessage.Visible = false;
            dvError.Visible = true;
        }

    }
    protected void btnContinue_Click(object sender, EventArgs e)
    {
        if (null != Session["BusinessID"] && !string.IsNullOrEmpty(Session["BusinessID"].ToString()))
        {
            Save();
            Response.Redirect("Payment.aspx");
        }
      
        
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        
    }
    
    void Save()
    {
        string INSERT = @"update business set assessmentDate=@AssessmentDate,Employeemale=@Employeemale,EmployeeFemale=@EmployeeFemale,AnnualSales=@AnnualSales,
                            Capital=@Capital,ApprovedBy=@ApprovedBy,ApprovalStatusID=@ApprovalStatusID,Latitude=@Latitude,Longitude=@Longitude where ID=@ID";
        try
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
            {
                sqlConnection.Open();

                using (SqlCommand sqlCommand = new SqlCommand(INSERT, sqlConnection))
                {
                    sqlCommand.Parameters.Add("@ID", SqlDbType.VarChar).Value = Session["BusinessID"];
                    sqlCommand.Parameters.Add("@Employeemale", SqlDbType.VarChar).Value = txtMale.Value;
                    sqlCommand.Parameters.Add("@EmployeeFemale", SqlDbType.VarChar).Value = txtFemale.Value;
                    sqlCommand.Parameters.Add("@AnnualSales", SqlDbType.VarChar).Value = txtAnnualSales.Value;
                    sqlCommand.Parameters.Add("@Capital", SqlDbType.VarChar).Value = txtCapital.Value;
                    sqlCommand.Parameters.Add("@ApprovedBy", SqlDbType.NVarChar).Value = txtApprovedBy.Value;
                    sqlCommand.Parameters.Add("@ApprovalStatusID", SqlDbType.VarChar).Value = ddlApprovalStatus.SelectedValue;
                    sqlCommand.Parameters.Add("@Latitude", SqlDbType.VarChar).Value = txtLat.Value;
                    sqlCommand.Parameters.Add("@Longitude", SqlDbType.VarChar).Value = txtLong.Value;
                    sqlCommand.Parameters.Add("@AssessmentDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtApplicationDate.Value);
                   
                    sqlCommand.ExecuteNonQuery();
                    

                }
            }
        }
        catch (Exception)
        {

            dvMessage.Visible = false;
            dvError.Visible = true;
        }    
        
    }
    
}