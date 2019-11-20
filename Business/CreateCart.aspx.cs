using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CreateCart : System.Web.UI.Page
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
            Label lbl = (Label)Master.FindControl("lblTitle");
            lbl.Text = "برنامه مدیریت ثبت دست فروشان";
            var now = PersianDateTime.Now;
            var today = now.ToString(PersianDateTimeFormat.Date);
            txtApplicationDate.Attributes["onclick"] = "PersianDatePicker.Show(this,'" + today + "');";
            
            
            BindDistrict();
            //todo: check if it is update then load else new Form
           if(Request.QueryString.Count>0 &&!string.IsNullOrEmpty(Request.QueryString["ID"].ToString()))
            {
                
                LoadForm(Request.QueryString["ID"]);
                
            }
            
               

        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        //checks if it is update then execute save or Insert
        if (Request.QueryString.Count > 0 && !string.IsNullOrEmpty(Request.QueryString["ID"].ToString()))
        {

            Save(Request.QueryString["ID"].ToString());
        }
        else
        {
            string code = Insert();
            LoadForm(code);
            btnSave.Enabled = false;
        }
           
         dvMessage.Visible = true;
         dvError.Visible = false;
       
    }
   
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("CartList.aspx");
    }
   
    void LoadForm(string code)
    {

        try
        {
            using (ConClass obj = new ConClass())
            {
                DataTable dt = obj.Selectdt(@"select BusinessName,OwnerName,FatherName,Gender,Tazkira,dbo.topersianDate(ApplicationDate) as ApplicationDate,
                ProvinceID,DistrictID,Street,Address,Phone,Photo,Code,latitude,longitude,Verificationremarks from Cart where ID=" + code);
                if (dt.Rows.Count > 0)
                {
                    txtCode.Value = dt.Rows[0]["Code"].ToString();
                    txtID.Value = code;
                    Session["CartID"] = code;
                    txtEName.Value = dt.Rows[0]["BusinessName"].ToString();
                    txtOwnerName.Value = dt.Rows[0]["OwnerName"].ToString();
                    txtFatherName.Value = dt.Rows[0]["FatherName"].ToString();
                    ddlGender.SelectedValue = dt.Rows[0]["Gender"].ToString();
                    txtNID.Value = dt.Rows[0]["Tazkira"].ToString();
                    txtApplicationDate.Value = dt.Rows[0]["ApplicationDate"].ToString();       
                 
                   
                    ddlProvince.SelectedValue = dt.Rows[0]["ProvinceID"].ToString();
                    BindDistrict();
                    ddlDistrict.SelectedValue = dt.Rows[0]["DistrictID"].ToString();
                    txtStreet.Value = dt.Rows[0]["Street"].ToString();
                    txtAddress.Value = dt.Rows[0]["Address"].ToString();
                    txtPhone.Value = dt.Rows[0]["Phone"].ToString();
                    txtLatitude.Value= dt.Rows[0]["Latitude"].ToString();
                    txtLongnitude.Value= dt.Rows[0]["Longitude"].ToString();
                    txtRep.Value = dt.Rows[0]["Verificationremarks"].ToString();




                    if (!string.IsNullOrEmpty(dt.Rows[0]["Photo"].ToString()))// != null)
                    {
                        byte[] bytes = (byte[])dt.Rows[0]["Photo"];
                        string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                        Image1.ImageUrl = "data:image/jpg;base64," + base64String;
                        Image1.Visible = true;
                    }
                    //if (HttpContext.Current.User.IsInRole("Entry"))
                    //{
                    //    btnSave.Enabled = false;
                    //   // System.Windows.Forms.MessageBox.Show("Test");
                    //}
                  
                }
               
                dt.Dispose();

            }

        }
        catch (Exception ex)
        {
            //System.Windows.Forms.MessageBox.Show(ex.Message);

        }
    }
    void Save(string ID)
         {
        //this is only for editing the biz
       
                string INSERT = @"Update Cart set BusinessName=@BusinessName,OwnerName=@OwnerName,FatherName=@FatherName,Tazkira=@Tazkira,Gender=@Gender,
               provinceID=@provinceID,DistrictID=@DistrictID,Street=@Street,address=@address,phone=@phone,
               ApplicationDate=@ApplicationDate,photo=@photo,latitude=@latitude,longitude=@longitude,Verificationremarks=@Verificationremarks where ID=@ID";
        
                        if (!fuPic.HasFile)
                        {
                            INSERT = @"Update Cart set BusinessName=@BusinessName,OwnerName=@OwnerName,FatherName=@FatherName,Tazkira=@Tazkira,Gender=@Gender,
               provinceID=@provinceID,DistrictID=@DistrictID,Street=@Street,address=@address,phone=@phone,
              ApplicationDate=@ApplicationDate,latitude=@latitude,longitude=@longitude,Verificationremarks=@Verificationremarks where ID=@ID";
                       }
        try
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
            {
                sqlConnection.Open();

                using (SqlCommand sqlCommand = new SqlCommand(INSERT, sqlConnection))
                {
                    sqlCommand.Parameters.Add("@ID", SqlDbType.NVarChar).Value = ID;
                    sqlCommand.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Value;
                    sqlCommand.Parameters.Add("@BusinessName", SqlDbType.NVarChar).Value = txtEName.Value;
                    sqlCommand.Parameters.Add("@OwnerName", SqlDbType.NVarChar).Value = txtOwnerName.Value;
                    sqlCommand.Parameters.Add("@FatherName", SqlDbType.NVarChar).Value = txtFatherName.Value;
                    sqlCommand.Parameters.Add("@Tazkira", SqlDbType.NVarChar).Value = txtNID.Value;
                    sqlCommand.Parameters.Add("@Gender", SqlDbType.VarChar).Value = ddlGender.SelectedValue;
                   
                    sqlCommand.Parameters.Add("@ProvinceID", SqlDbType.VarChar).Value = ddlProvince.SelectedValue;
                    sqlCommand.Parameters.Add("@DistrictID", SqlDbType.VarChar).Value = ddlDistrict.SelectedValue;
                    sqlCommand.Parameters.Add("@Street", SqlDbType.NVarChar).Value = txtStreet.Value;
                    sqlCommand.Parameters.Add("@address", SqlDbType.NVarChar).Value = txtAddress.Value;
                   
                    sqlCommand.Parameters.Add("@phone", SqlDbType.NVarChar).Value = txtPhone.Value;
                    sqlCommand.Parameters.Add("@Latitude", SqlDbType.NVarChar).Value = txtLatitude.Value;
                    sqlCommand.Parameters.Add("@Longitude", SqlDbType.NVarChar).Value = txtLongnitude.Value;
                    sqlCommand.Parameters.Add("@Verificationremarks", SqlDbType.NVarChar).Value = txtRep.Value;

                    sqlCommand.Parameters.Add("@ApplicationDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtApplicationDate.Value);
                    sqlCommand.Parameters.Add("@DataEntryDate", SqlDbType.Date).Value = DateTime.Now.Date;
                    sqlCommand.Parameters.Add("@EnteredBy", SqlDbType.NVarChar).Value = HttpContext.Current.User.Identity.Name.ToString();
                    
                   
                    if (fuPic.HasFile)
                    {
                        sqlCommand.Parameters.Add("@photo", SqlDbType.VarBinary).Value = fuPic.FileBytes;
                    }
                    //else
                    //{
                    //    sqlCommand.Parameters.Add("@photo", SqlDbType.VarBinary).Value = DBNull.Value;
                    //}
                    sqlCommand.ExecuteNonQuery();
                    

                }
            }
        }
        catch (Exception ex)
        {

            dvMessage.Visible = false;
            dvError.Visible = true;
        }    
        
    }
    string Insert()
    {
        //this is only for Inserting new biz

        string INSERT = "CreateCart";
        string code = ""; 
       
        try
        {
            using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
            {
                sqlConnection.Open();

                using (SqlCommand sqlCommand = new SqlCommand(INSERT, sqlConnection))
                {
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.Add("@BusinessName", SqlDbType.NVarChar).Value = txtEName.Value;
                    sqlCommand.Parameters.Add("@OwnerName", SqlDbType.NVarChar).Value = txtOwnerName.Value;
                    sqlCommand.Parameters.Add("@FatherName", SqlDbType.NVarChar).Value = txtFatherName.Value;
                    sqlCommand.Parameters.Add("@Tazkira", SqlDbType.NVarChar).Value = txtNID.Value;
                    sqlCommand.Parameters.Add("@Gender", SqlDbType.VarChar).Value = ddlGender.SelectedValue;
                    sqlCommand.Parameters.Add("@ProvinceID", SqlDbType.VarChar).Value = ddlProvince.SelectedValue;
                    sqlCommand.Parameters.Add("@DistrictID", SqlDbType.VarChar).Value = ddlDistrict.SelectedValue;
                    sqlCommand.Parameters.Add("@Street", SqlDbType.NVarChar).Value = txtStreet.Value;
                    sqlCommand.Parameters.Add("@address", SqlDbType.NVarChar).Value = txtAddress.Value;                   
                    sqlCommand.Parameters.Add("@phone", SqlDbType.NVarChar).Value = txtPhone.Value;
                    sqlCommand.Parameters.Add("@Latitude", SqlDbType.NVarChar).Value = txtLatitude.Value;
                    sqlCommand.Parameters.Add("@Longitude", SqlDbType.NVarChar).Value = txtLongnitude.Value;
                    sqlCommand.Parameters.Add("@ApplicationDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtApplicationDate.Value);
                    sqlCommand.Parameters.Add("@EnteredBy", SqlDbType.NVarChar).Value = HttpContext.Current.User.Identity.Name.ToString();
                    sqlCommand.Parameters.Add("@Verificationremarks", SqlDbType.NVarChar).Value = txtRep.Value;
                    var returnParameter = sqlCommand.Parameters.Add("@Code", SqlDbType.NVarChar);
                    returnParameter.Direction = ParameterDirection.ReturnValue;
                    if (fuPic.HasFile)
                    {
                        sqlCommand.Parameters.Add("@photo", SqlDbType.VarBinary).Value = fuPic.FileBytes;
                    }
                    //else
                    //{
                    //    sqlCommand.Parameters.Add("@photo", SqlDbType.VarBinary).Value = DBNull.Value;
                    //}
                    sqlCommand.ExecuteNonQuery();
                    var result = returnParameter.Value;
                    code = result.ToString();

                }
            }
        }
        catch (Exception ex)
        {

            dvMessage.Visible = false;
            dvError.Visible = true;
        }
        return code;

    }
   

    void BindDistrict()
    {
        dsDistrict.SelectCommand = "Select ID,Name_local from zDistrict where ID=" + HttpContext.Current.Profile["DistrictID"].ToString() + " union select null,N'--انتخاب--' order by ID";
        ddlDistrict.DataBind();
    }





    protected void LinkButton2_Click(object sender, EventArgs e)
    {
       
            Response.Redirect(@"~/Business/CartLicense.aspx?CartID=" + Session["CartID"].ToString());
       
    }
}