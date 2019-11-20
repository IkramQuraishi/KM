using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Reports_Tarufa : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString.Count > 0)
            {
                if (IsPaid(Request.QueryString[0].ToString()))
                {
                    dsTarufa.SelectCommand = @"";
                    ListView2.Visible = false;
                    dsTarufa1.SelectCommand = @"";
                    btnSave.Visible = false;
                }
                else
                {
                    dsTarufa.SelectCommand = @"select b.ID,b.Code,b.OwnerName,b.FatherName,b.Tazkira,c.name_local as Class,ct.Name_Local as Category,d.Name_Local as District, b.Address,d.Code, isnull(b.EmployeeMale,0)+isnull(b.EmployeeFemale,0) as TotalEmp,
b.annualSales,b.phone,dbo.funLicenseFeeByID(b.ID) as LicenseFee from business b inner join zBusinessClass c on c.ID=b.BusinessClassID inner join zBusinessCategory ct on ct.ID=b.BusinessCategoryID
inner join zDistrict d on d.ID=b.DistrictID where b.ID=" + Request.QueryString[0].ToString();
                    dsTarufa1.SelectCommand = @"select b.ID,b.Code,b.OwnerName,b.FatherName,b.Tazkira,c.name_local as Class,ct.Name_Local as Category,d.Name_Local as District, b.Address,d.Code, isnull(b.EmployeeMale,0)+isnull(b.EmployeeFemale,0) as TotalEmp,
b.annualSales,b.phone,dbo.funLicenseFeeByID(b.ID) as LicenseFee from business b inner join zBusinessClass c on c.ID=b.BusinessClassID inner join zBusinessCategory ct on ct.ID=b.BusinessCategoryID
inner join zDistrict d on d.ID=b.DistrictID where b.ID=" + Request.QueryString[0].ToString();
                }
            }
            else
            {
                dsTarufa.SelectCommand = @"select b.ID,b.Code,b.OwnerName,b.FatherName,b.Tazkira,c.name_local as Class,ct.Name_Local as Category,d.Name_Local as District, b.Address, isnull(b.EmployeeMale,0)+isnull(b.EmployeeFemale,0) as TotalEmp,
b.annualSales,b.phone,dbo.funLicenseFeeBbyID(b.ID) as LicenseFee from business b inner join zBusinessClass c on c.ID=b.BusinessClassID inner join zBusinessCategory ct on ct.ID=b.BusinessCategoryID
inner join zDistrict d on d.ID=b.DistrictID
where b.ID  in (select business.ID
 from business left outer join zBusinessClass c on business.BusinessClassID=c.ID left outer join 
 (select businessID,case when FeeTypeID=1 then amount else 0 end as LicenseFee
 from  Payment where YearID="+Session["year"]+ @" ) p on p.BusinessID=Business.ID 
 left outer join zBusinessCategory ct on ct.ID=business.BusinessCategoryID left outer join zDistrict d on d.ID=business.DistrictID where isnull(p.LicenseFee,0)=0 )";
                dsTarufa1.SelectCommand = @"select b.ID,b.Code,b.OwnerName,b.FatherName,b.Tazkira,c.name_local as Class,ct.Name_Local as Category,d.Name_Local as District, b.Address, isnull(b.EmployeeMale,0)+isnull(b.EmployeeFemale,0) as TotalEmp,
b.annualSales,b.phone,dbo.funLicenseFee(c.ID,ct.ID) as LicenseFee from business b inner join zBusinessClass c on c.ID=b.BusinessClassID inner join zBusinessCategory ct on ct.ID=b.BusinessCategoryID
inner join zDistrict d on d.ID=b.DistrictID
where b.ID  in (select business.ID
 from business left outer join zBusinessClass c on business.BusinessClassID=c.ID left outer join 
 (select businessID,case when FeeTypeID=1 then amount else 0 end as LicenseFee
 from  Payment where YearID=" + Session["year"] + @" ) p on p.BusinessID=Business.ID 
 left outer join zBusinessCategory ct on ct.ID=business.BusinessCategoryID left outer join zDistrict d on d.ID=business.DistrictID where isnull(p.LicenseFee,0)=0 )";
            }
        }
    }
    bool IsPaid(string ID)
    {
        bool returnVal = false;
        using (ConClass obj = new ConClass())
        {
            //System.Windows.Forms.MessageBox.Show(GetFilter());
           SqlDataReader rd = obj.Selectdr(@"select ID from payment where businessID="+ID + " and YearID=substring(dbo.ToPersianDate(getdate()),1,4)" );
            if(rd.HasRows)
            {
                returnVal = true;

            }

            return returnVal;

        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string sql = @"if not exists(select ID from payment where businessID=@BusinessID and YearID=substring(dbo.ToPersianDate(getdate()),1,4))" +
            "Insert into payment (BusinessID, FeeTypeID, Amount, YearID,paymentStatusID,TarufaDate) select @BusinessID,1, dbo.FunLicenseFeeByID(@BusinessID),substring(dbo.ToPersianDate(getdate()),1,4),1,getdate()";
        try
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
            {
                sqlConnection.Open();

                using (SqlCommand sqlCommand = new SqlCommand(sql, sqlConnection))
                {
                    sqlCommand.Parameters.Add("@BusinessID", SqlDbType.VarChar).Value = Request.QueryString[0].ToString();
                  
                    sqlCommand.ExecuteNonQuery();
                }
                sqlConnection.Close();
            }
        }
        catch (Exception ex)
        {


        }

    }

    
}