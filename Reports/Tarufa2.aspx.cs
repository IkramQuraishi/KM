using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Tarufa2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString.Count > 0)
            {
                dsTarufa.SelectCommand = @"select b.ID,b.OwnerName,b.FatherName,b.Tazkira,c.name_local as Class,ct.Name_Local as Category,d.Name_Local as District, b.Address,d.Code, isnull(b.EmployeeMale,0)+isnull(b.EmployeeFemale,0) as TotalEmp,
b.annualSales,b.phone,dbo.funLicenseFee(c.ID,ct.ID) as LicenseFee from business b inner join zBusinessClass c on c.ID=b.BusinessClassID inner join zBusinessCategory ct on ct.ID=b.BusinessCategoryID
inner join zDistrict d on d.ID=b.DistrictID where b.ID="+Request.QueryString[0].ToString();
                dsTarufa1.SelectCommand = @"select b.ID,b.OwnerName,b.FatherName,b.Tazkira,c.name_local as Class,ct.Name_Local as Category,d.Name_Local as District, b.Address,d.Code, isnull(b.EmployeeMale,0)+isnull(b.EmployeeFemale,0) as TotalEmp,
b.annualSales,b.phone,dbo.funLicenseFee(c.ID,ct.ID) as LicenseFee from business b inner join zBusinessClass c on c.ID=b.BusinessClassID inner join zBusinessCategory ct on ct.ID=b.BusinessCategoryID
inner join zDistrict d on d.ID=b.DistrictID where b.ID=" + Request.QueryString[0].ToString();
            }
            else
            {
                dsTarufa.SelectCommand = @"select b.ID,b.OwnerName,b.FatherName,b.Tazkira,c.name_local as Class,ct.Name_Local as Category,d.Name_Local as District, b.Address, isnull(b.EmployeeMale,0)+isnull(b.EmployeeFemale,0) as TotalEmp,
b.annualSales,b.phone,dbo.funLicenseFee(c.ID,ct.ID) as LicenseFee from business b inner join zBusinessClass c on c.ID=b.BusinessClassID inner join zBusinessCategory ct on ct.ID=b.BusinessCategoryID
inner join zDistrict d on d.ID=b.DistrictID
where b.ID  in (select business.ID
 from business left outer join zBusinessClass c on business.BusinessClassID=c.ID left outer join 
 (select businessID,case when FeeTypeID=2 then amount else 0 end as LicenseFee
 from  Payment where YearID="+Session["year"]+ @" ) p on p.BusinessID=Business.ID 
 left outer join zBusinessCategory ct on ct.ID=business.BusinessCategoryID left outer join zDistrict d on d.ID=business.DistrictID where isnull(p.LicenseFee,0)=0 )";
                dsTarufa1.SelectCommand = @"select b.ID,b.OwnerName,b.FatherName,b.Tazkira,c.name_local as Class,ct.Name_Local as Category,d.Name_Local as District, b.Address, isnull(b.EmployeeMale,0)+isnull(b.EmployeeFemale,0) as TotalEmp,
b.annualSales,b.phone,dbo.funLicenseFee(c.ID,ct.ID) as LicenseFee from business b inner join zBusinessClass c on c.ID=b.BusinessClassID inner join zBusinessCategory ct on ct.ID=b.BusinessCategoryID
inner join zDistrict d on d.ID=b.DistrictID
where b.ID  in (select business.ID
 from business left outer join zBusinessClass c on business.BusinessClassID=c.ID left outer join 
 (select businessID,case when FeeTypeID=2 then amount else 0 end as LicenseFee
 from  Payment where YearID=" + Session["year"] + @" ) p on p.BusinessID=Business.ID 
 left outer join zBusinessCategory ct on ct.ID=business.BusinessCategoryID left outer join zDistrict d on d.ID=business.DistrictID where isnull(p.LicenseFee,0)=0 )";
            }
        }
    }
}