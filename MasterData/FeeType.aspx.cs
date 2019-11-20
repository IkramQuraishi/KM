using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public partial class FeeType : System.Web.UI.Page
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
        txtName_Local.Value = "";
        txtName.Value = "";
        lblID.Text = "";

    }
    void Save()
    {

        string INSERT = "INSERT INTO zFeeType (Name, name_local) VALUES (@Name, @name_local)";

        using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            sqlConnection.Open();

            using (SqlCommand sqlCommand = new SqlCommand(INSERT, sqlConnection))
            {
                sqlCommand.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtName.Value;
                sqlCommand.Parameters.Add("@name_local", SqlDbType.NVarChar).Value = txtName_Local.Value;
                sqlCommand.ExecuteNonQuery();
            }
        }
    }
    void Edit()
    {

        string Edit = "update zFeeType set Name=@Name, name_local=@name_local where ID=@ID";

        using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            sqlConnection.Open();

            using (SqlCommand sqlCommand = new SqlCommand(Edit, sqlConnection))
            {
                sqlCommand.Parameters.Add("@Name", SqlDbType.NVarChar).Value = txtName.Value;
                sqlCommand.Parameters.Add("@name_local", SqlDbType.NVarChar).Value = txtName_Local.Value;
                sqlCommand.Parameters.Add("@ID", SqlDbType.Int).Value = lblID.Text;
                sqlCommand.ExecuteNonQuery();
            }
        }
    }
    void GetGroup(string ID)
    {
        DataTable dt = obj.Selectdt("select ID,Name,Name_Local from zFeeType where ID=" + ID);
        if (dt.Rows.Count > 0)
        {
            txtName_Local.Value = dt.Rows[0]["Name_local"].ToString();
            txtName.Value = dt.Rows[0]["Name"].ToString();
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

            obj.execNonQuery("Delete from zFeeType where ID=" + e.CommandArgument.ToString());
            gvGroup.DataBind();
        }
    }
}