
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VerifyBusiness : System.Web.UI.Page
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
            LoadForm();
        }
    }
   
   
    protected void btnCancel_Click(object sender, EventArgs e)
    {
      
       
    }
   
    void LoadForm()
    {

        try
        {
            using (ConClass obj = new ConClass())
            {
                DataTable dt = obj.Selectdt(@"select b.*,g.name_local as BusinessGroup,c.Name_local as Class,ct.Name_local as Category,p.Name_Local as Province,d.Name_local as District,
                                               dbo.ToPersianDate(isnull(b.assessmentDate,'')) as AssessmentDate1,dbo.ToPersianDate(b.ApplicationDate) as ApplicationDate1,
                                                a.Name_local as ApprovalStatus,gn.Name_local as Gender1 from business b 
                                                left outer join zBusinessGroup g on g.ID=b.GroupID
                                                left outer join zBusinessClass c on c.ID=b.BusinessClassID
                                                left outer join zBusinessCategory ct on ct.ID=b.BusinessCategoryID
                                                left outer join zGender gn on gn.ID=b.Gender
                                                left outer join zProvince p on p.ID=b.ProvinceID
                                                left outer join zDistrict d on d.id=b.DistrictID
                                                left outer join zApprovalStatus a on a.id=b.ApprovalStatusID where b.ID=" + Session["BusinessID"].ToString());
                if (dt.Rows.Count > 0)
                {
                    lblCode.Text = dt.Rows[0]["Code"].ToString();
                    lblBusinessName.Text = dt.Rows[0]["BusinessName"].ToString();
                    lblOwnername.Text = dt.Rows[0]["Ownername"].ToString();
                    lblFatherName.Text = dt.Rows[0]["FatherName"].ToString();
                    lblGender.Text = dt.Rows[0]["Gender1"].ToString();
                    lblTazkira.Text = dt.Rows[0]["Tazkira"].ToString();
                    lblApplicationDate.Text = dt.Rows[0]["ApplicationDate1"].ToString();
                    if(!string.IsNullOrEmpty(dt.Rows[0]["Photo"].ToString()))
                    {
                        byte[] bytes = (byte[])dt.Rows[0]["Photo"];
                        string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                        Image1.ImageUrl = "data:image/jpg;base64," + base64String;
                    }
                    else
                    {
                        Image1.ImageUrl = @"~/images/no_photo.jpg";
                    }
                   
                    lblGroup.Text = dt.Rows[0]["BusinessGroup"].ToString();
                    lblClass.Text = dt.Rows[0]["Class"].ToString();
                    lblCategory.Text = dt.Rows[0]["Category"].ToString();
                    lblProvince.Text = dt.Rows[0]["Province"].ToString();
                    lblDistrict.Text = dt.Rows[0]["District"].ToString();
                    lblStreet.Text = dt.Rows[0]["Street"].ToString();
                    lblPhone.Text = dt.Rows[0]["Phone"].ToString();
                    lblAddress.Text = dt.Rows[0]["Address"].ToString();
                    lblEmail.Text = dt.Rows[0]["Email"].ToString();
                    lblShopNumber.Text = dt.Rows[0]["ShopNumber"].ToString();
                    lblWebsite.Text = dt.Rows[0]["Website"].ToString();
                    lblAssessmentDate.Text = dt.Rows[0]["AssessmentDate1"].ToString();
                    lblApprovalStatus.Text = dt.Rows[0]["ApprovalStatus"].ToString();
                    lblRemarks.Text = dt.Rows[0]["ApprovalRemarks"].ToString();
                    lblApprovedBy.Text=dt.Rows[0]["ApprovedBy"].ToString();
                    lblCapital.Text=dt.Rows[0]["Capital"].ToString();
                    lblAnnualSales.Text=dt.Rows[0]["AnnualSales"].ToString();
                    lblMale.Text = dt.Rows[0]["EmployeeMale"].ToString();
                    lblFemale.Text = dt.Rows[0]["EmployeeFemale"].ToString();
                    lblX.Text = dt.Rows[0]["Latitude"].ToString();
                    lblY.Text = dt.Rows[0]["Longitude"].ToString();

                    
                }
                dt.Dispose();

            }

        }
        catch (Exception ex)
        {


        }
    }



    protected void btnVerify_Click(object sender, EventArgs e)
    {
        using (ConClass obj = new ConClass())
        {
            obj.execNonQuery("update business set IsVerified=1 where ID=" + Session["BusinessID"].ToString());
        }
        Response.Redirect("BusinessToVerify.aspx");
    }
}