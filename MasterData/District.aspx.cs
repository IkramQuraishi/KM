using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public partial class District : System.Web.UI.Page
{
    ConClass obj = new ConClass();
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnCreate_Click(object sender, EventArgs e)
    {
        try
        {
            if (!string.IsNullOrEmpty(lblID.Text))
            {
                Edit();
            }
            else
            {
                Save();
            }
            Clear();
            gvGroup.DataBind();
        }
        catch (Exception)
        {
            
            throw;
        }
    }
    void Clear()
    {
        txtCode.Value = "";
        txtName_Local.Value = "";
        txtName.Value = "";
        lblID.Text = "";

    }
    void Save()
    {

        string INSERT = "INSERT INTO zDistrict (Code,Name, name_local,provinceID,locationCategoryID) VALUES (@Code,@Name, @name_local,@provinceID,@locationCategoryID)";

        using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            sqlConnection.Open();

            using (SqlCommand sqlCommand = new SqlCommand(INSERT, sqlConnection))
            {
                sqlCommand.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Value;
                sqlCommand.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtName.Value;
                sqlCommand.Parameters.Add("@name_local", SqlDbType.NVarChar).Value = txtName_Local.Value;
                sqlCommand.Parameters.Add("@provinceID", SqlDbType.Int).Value = ddlProvince.SelectedValue;
                sqlCommand.Parameters.Add("@locationCategoryID", SqlDbType.Int).Value = ddlLocationCategory.SelectedValue;
                sqlCommand.ExecuteNonQuery();
            }
        }
    }
    void Edit()
    {

        string Edit = "update zDistrict set Code=@Code,Name=@Name, name_local=@name_local,provinceID=@provinceID, LocationCategoryID=@locationCategoryID where ID=@ID";

        using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            sqlConnection.Open();

            using (SqlCommand sqlCommand = new SqlCommand(Edit, sqlConnection))
            {
                sqlCommand.Parameters.Add("@Code", SqlDbType.NVarChar).Value = txtCode.Value;
                sqlCommand.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtName.Value;
                sqlCommand.Parameters.Add("@name_local", SqlDbType.NVarChar).Value = txtName_Local.Value;
                sqlCommand.Parameters.Add("@provinceID", SqlDbType.Int).Value = ddlProvince.SelectedValue;
                sqlCommand.Parameters.Add("@locationCategoryID", SqlDbType.Int).Value = ddlLocationCategory.SelectedValue;
                sqlCommand.Parameters.Add("@ID", SqlDbType.Int).Value = lblID.Text;
                sqlCommand.ExecuteNonQuery();
            }
        }
    }
    void GetGroup(string ID)
    {
        DataTable dt = obj.Selectdt("select * from zDistrict where ID=" + ID);
        if (dt.Rows.Count > 0)
        {
            txtCode.Value = dt.Rows[0]["Code"].ToString();
            txtName_Local.Value = dt.Rows[0]["Name_local"].ToString();
            txtName.Value = dt.Rows[0]["Name"].ToString();
            if (!string.IsNullOrEmpty(dt.Rows[0]["ProvinceID"].ToString()))
            {
                ddlProvince.SelectedValue = dt.Rows[0]["ProvinceID"].ToString();
            }
            if (!string.IsNullOrEmpty(dt.Rows[0]["LocationCategoryID"].ToString()))
            {
                ddlLocationCategory.SelectedValue = dt.Rows[0]["LocationCategoryID"].ToString();
            }
        }
        dt.Dispose();
    }
    protected void gvGroup_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        lblID.Text= e.CommandArgument.ToString();
        if (e.CommandName == "Ed")
        {
            GetGroup(lblID.Text);
        }
       
        else if (e.CommandName == "Del")
        {

            obj.execNonQuery("Delete from zDistrict where ID=" + e.CommandArgument.ToString());
            gvGroup.DataBind();
        }
    }
}