using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Tarufa3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString.Count > 0)
            {
                //if (IsPaid(Request.QueryString[0].ToString()))
                //{
                //    dsTarufa.SelectCommand = @"";
                //    ListView2.Visible = false;
                //    dsTarufa1.SelectCommand = @"";
                   
                //}
                //else
                //{
                    dsTarufa.SelectCommand = @"select b.ID,b.Code,b.OwnerName,b.FatherName,b.Tazkira,c.name_local as Class,ct.Name_Local as Category,d.Name_Local as District, b.Address,d.Code, isnull(b.EmployeeMale,0)+isnull(b.EmployeeFemale,0) as TotalEmp,
b.annualSales,b.phone,p.amount as LicenseFee,p.YearID from business b inner join payment p on p.BusinessID=b.ID inner join zBusinessClass c on c.ID=b.BusinessClassID inner join zBusinessCategory ct on ct.ID=b.BusinessCategoryID
inner join zDistrict d on d.ID=b.DistrictID where p.ID=" + Request.QueryString[0].ToString();
                    dsTarufa1.SelectCommand = @"select b.ID,b.Code,b.OwnerName,b.FatherName,b.Tazkira,c.name_local as Class,ct.Name_Local as Category,d.Name_Local as District, b.Address,d.Code, isnull(b.EmployeeMale,0)+isnull(b.EmployeeFemale,0) as TotalEmp,
b.annualSales,b.phone,p.amount as LicenseFee,p.YearID from business b inner join payment p on p.BusinessID=b.ID inner join zBusinessClass c on c.ID=b.BusinessClassID inner join zBusinessCategory ct on ct.ID=b.BusinessCategoryID
inner join zDistrict d on d.ID=b.DistrictID where p.ID=" + Request.QueryString[0].ToString();
               // }
            }
          
        }
    }
    bool IsPaid(string ID)
    {
        bool returnVal = false;
        using (ConClass obj = new ConClass())
        {
            //System.Windows.Forms.MessageBox.Show(GetFilter());
           SqlDataReader rd = obj.Selectdr(@"select ID from payment where ID="+ID + " and YearID=substring(dbo.ToPersianDate(getdate()),1,4) and paymentStatusID=2" );
            if(rd.HasRows)
            {
                returnVal = true;

            }

            return returnVal;

        }
    }


    
}