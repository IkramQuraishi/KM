using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Business_Create : System.Web.UI.Page
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
         btnPrint.Enabled = true;
    }
    protected void btnContinue_Click(object sender, EventArgs e)
    {
        //Save();
        Response.Redirect("Assessment.aspx");
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Index.aspx");
    }
   
    void LoadForm(string code)
    {

        try
        {
            using (ConClass obj = new ConClass())
            {
                DataTable dt = obj.Selectdt(@"select BusinessName,OwnerName,FatherName,Gender,Tazkira, dbo.topersianDate(ApplicationDate) as ApplicationDate,GroupID,BusinessClassID,BusinessCategoryID,
                ProvinceID,DistrictID,Street,Address,Phone,Email,ShopNumber,Website,Photo,Code,LessThan6 from business where ID=" +code);
                if (dt.Rows.Count > 0)
                {
                    txtCode.Value = dt.Rows[0]["Code"].ToString();
                    txtID.Value = code;
                    Session["BusinessID"] = code;
                    txtEName.Value = dt.Rows[0]["BusinessName"].ToString();
                    txtOwnerName.Value = dt.Rows[0]["OwnerName"].ToString();
                    txtFatherName.Value = dt.Rows[0]["FatherName"].ToString();
                    ddlGender.SelectedValue = dt.Rows[0]["Gender"].ToString();
                    txtNID.Value = dt.Rows[0]["Tazkira"].ToString();
                    txtApplicationDate.Value = dt.Rows[0]["ApplicationDate"].ToString();
                    ddlGroup.SelectedValue = dt.Rows[0]["GroupID"].ToString();
                    BindGroupDDL(dt.Rows[0]["GroupID"].ToString());
                    ddlClass.SelectedValue = dt.Rows[0]["BusinessClassID"].ToString();
                    ddlCategory.SelectedValue = dt.Rows[0]["BusinessCategoryID"].ToString();
                    ddlProvince.SelectedValue = dt.Rows[0]["ProvinceID"].ToString();
                    BindDistrict();
                    ddlDistrict.SelectedValue = dt.Rows[0]["DistrictID"].ToString();
                    txtStreet.Value = dt.Rows[0]["Street"].ToString();
                    txtAddress.Value = dt.Rows[0]["Address"].ToString();
                    txtPhone.Value = dt.Rows[0]["Phone"].ToString();
                    txtEmail.Value = dt.Rows[0]["Email"].ToString();
                    txtShopNumber.Value = dt.Rows[0]["ShopNumber"].ToString();
                    txtWebsite.Value = dt.Rows[0]["Website"].ToString();
                    if(!string.IsNullOrEmpty(dt.Rows[0]["LessThan6"].ToString()))
                    {
                        if(dt.Rows[0]["LessThan6"].ToString()=="True")
                        {
                            chkLessThan6.Checked = true;
                        }
                        else
                        {
                            chkLessThan6.Checked = false;
                        }
                    }

                    
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
                    btnPrint.Enabled = true;
                }
               
                dt.Dispose();

            }

        }
        catch (Exception ex)
        {
            System.Windows.Forms.MessageBox.Show(ex.Message);

        }
    }
    void Save(string ID)
         {
        //this is only for editing the biz
       
                string INSERT = @"Update business set BusinessName=@BusinessName,OwnerName=@OwnerName,FatherName=@FatherName,Tazkira=@Tazkira,Gender=@Gender,GroupID=@GroupID,BusinessClassID=@BusinessClassID,
                BusinessCategoryID=@BusinessCategoryID,provinceID=@provinceID,DistrictID=@DistrictID,Street=@Street,address=@address,ShopNumber=@ShopNumber,phone=@phone,email=@email,
                website=@website,ApplicationDate=@ApplicationDate,photo=@photo,LessThan6=@LessThan6 where ID=@ID";
        
                        if (!fuPic.HasFile)
                        {
                            INSERT = @"Update business set BusinessName=@BusinessName,OwnerName=@OwnerName,FatherName=@FatherName,Tazkira=@Tazkira,Gender=@Gender,GroupID=@GroupID,BusinessClassID=@BusinessClassID,
                BusinessCategoryID=@BusinessCategoryID,provinceID=@provinceID,DistrictID=@DistrictID,Street=@Street,address=@address,ShopNumber=@ShopNumber,phone=@phone,email=@email,
                website=@website,ApplicationDate=@ApplicationDate,LessThan6=@LessThan6 where ID=@ID";
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
                    sqlCommand.Parameters.Add("@GroupID", SqlDbType.VarChar).Value = ddlGroup.SelectedValue;
                    sqlCommand.Parameters.Add("@BusinessClassID", SqlDbType.VarChar).Value = ddlClass.SelectedValue;
                    sqlCommand.Parameters.Add("@BusinessCategoryID", SqlDbType.VarChar).Value = ddlCategory.SelectedValue;
                    sqlCommand.Parameters.Add("@ProvinceID", SqlDbType.VarChar).Value = ddlProvince.SelectedValue;
                    sqlCommand.Parameters.Add("@DistrictID", SqlDbType.VarChar).Value = ddlDistrict.SelectedValue;
                    sqlCommand.Parameters.Add("@Street", SqlDbType.NVarChar).Value = txtStreet.Value;
                    sqlCommand.Parameters.Add("@address", SqlDbType.NVarChar).Value = txtAddress.Value;
                    sqlCommand.Parameters.Add("@ShopNumber", SqlDbType.NVarChar).Value = txtShopNumber.Value;
                    sqlCommand.Parameters.Add("@phone", SqlDbType.NVarChar).Value = txtPhone.Value;
                    sqlCommand.Parameters.Add("@email", SqlDbType.NVarChar).Value = txtEmail.Value;
                    sqlCommand.Parameters.Add("@website", SqlDbType.NVarChar).Value = txtWebsite.Value;
                    sqlCommand.Parameters.Add("@ApplicationDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtApplicationDate.Value);
                    sqlCommand.Parameters.Add("@DataEntryDate", SqlDbType.Date).Value = DateTime.Now.Date;
                    sqlCommand.Parameters.Add("@EnteredBy", SqlDbType.NVarChar).Value = HttpContext.Current.User.Identity.Name.ToString();
                    int Lessthan6 = 0;
                    if (chkLessThan6.Checked == true)
                    {
                        Lessthan6 = 1;
                    }
                    else
                    {
                        Lessthan6 = 0;
                    }
                    sqlCommand.Parameters.Add("@LessThan6", SqlDbType.Int).Value = Lessthan6;
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

        string INSERT = "CreateBiz";
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
                    sqlCommand.Parameters.Add("@GroupID", SqlDbType.VarChar).Value = ddlGroup.SelectedValue;
                    sqlCommand.Parameters.Add("@BusinessClassID", SqlDbType.VarChar).Value = ddlClass.SelectedValue;
                    sqlCommand.Parameters.Add("@BusinessCategoryID", SqlDbType.VarChar).Value = ddlCategory.SelectedValue;
                    sqlCommand.Parameters.Add("@ProvinceID", SqlDbType.VarChar).Value = ddlProvince.SelectedValue;
                    sqlCommand.Parameters.Add("@DistrictID", SqlDbType.VarChar).Value = ddlDistrict.SelectedValue;
                    sqlCommand.Parameters.Add("@Street", SqlDbType.NVarChar).Value = txtStreet.Value;
                    sqlCommand.Parameters.Add("@address", SqlDbType.NVarChar).Value = txtAddress.Value;
                    sqlCommand.Parameters.Add("@ShopNumber", SqlDbType.NVarChar).Value = txtShopNumber.Value;
                    sqlCommand.Parameters.Add("@phone", SqlDbType.NVarChar).Value = txtPhone.Value;
                    sqlCommand.Parameters.Add("@email", SqlDbType.NVarChar).Value = txtEmail.Value;
                    sqlCommand.Parameters.Add("@website", SqlDbType.NVarChar).Value = txtWebsite.Value;
                    sqlCommand.Parameters.Add("@ApplicationDate", SqlDbType.Date).Value = PersianDate.ConvertDate.ToEn(txtApplicationDate.Value);
                    sqlCommand.Parameters.Add("@EnteredBy", SqlDbType.NVarChar).Value = HttpContext.Current.User.Identity.Name.ToString();
                    int Lessthan6 = 0;
                    if (chkLessThan6.Checked==true)
                    {
                        Lessthan6 = 1;
                    }
                    else
                    {
                        Lessthan6 = 0;
                    }
                    sqlCommand.Parameters.Add("@LessThan6", SqlDbType.Int).Value = Lessthan6;
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
    void BindGroupDDL(string val)
    {
        dsClass.SelectCommand = "Select ID,Name_local from zBusinessClass where businessgroupID=" + val + " union select null,N'--انتخاب--' order by ID";
        ddlClass.DataBind();
    }

    void BindDistrict()
    {
        dsDistrict.SelectCommand = "Select ID,Name_local from zDistrict where ID=" + HttpContext.Current.Profile["DistrictID"].ToString() + " union select null,N'--انتخاب--' order by ID";
        ddlDistrict.DataBind();
    }
    
    protected void ddlGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGroupDDL(ddlGroup.SelectedValue.ToString());
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtApplicationDate.Value))
        {
            string year = "";
            year = txtApplicationDate.Value;
            year = year.Substring(0, 4);
            Session["Year"] = year;
            Response.Redirect(@"~/Reports/Tarufa.aspx?ID=" + txtID.Value);
        }
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        Response.Redirect(@"~/Business/BusinessLicense.aspx?BusinessID=" + Session["BusinessID"].ToString());
    }
}