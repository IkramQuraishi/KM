
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

public partial class ViewCart : System.Web.UI.Page
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
                DataTable dt = obj.Selectdt(@"select b.*,p.Name_Local as Province,d.Name_local as District,
                                               dbo.ToPersianDate(b.ApplicationDate) as ApplicationDate1,
                                               gn.Name_local as Gender1 from Cart b                                               
                                                left outer join zGender gn on gn.ID=b.Gender
                                                left outer join zProvince p on p.ID=b.ProvinceID
                                                left outer join zDistrict d on d.id=b.DistrictID
                                                where b.ID=" + Session["CartID"].ToString());
                if (dt.Rows.Count > 0)
                {
                    lblCode.Text = dt.Rows[0]["Code"].ToString();
                    lblBusinessName.Text = dt.Rows[0]["BusinessName"].ToString();
                    lblOwnername.Text = dt.Rows[0]["Ownername"].ToString();
                    lblFatherName.Text = dt.Rows[0]["FatherName"].ToString();
                    lblGender.Text = dt.Rows[0]["Gender1"].ToString();
                    lblTazkira.Text = dt.Rows[0]["Tazkira"].ToString();
                    lblApplicationDate.Text = dt.Rows[0]["ApplicationDate1"].ToString();
                    if (!string.IsNullOrEmpty(dt.Rows[0]["Photo"].ToString()))
                    {
                        byte[] bytes = (byte[])dt.Rows[0]["Photo"];
                        string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                        Image1.ImageUrl = "data:image/jpg;base64," + base64String;
                    }
                                   
                    lblProvince.Text = dt.Rows[0]["Province"].ToString();
                    lblDistrict.Text = dt.Rows[0]["District"].ToString();
                    lblStreet.Text = dt.Rows[0]["Street"].ToString();
                    lblPhone.Text = dt.Rows[0]["Phone"].ToString();
                    lblAddress.Text = dt.Rows[0]["Address"].ToString();
                   
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

  
   
}