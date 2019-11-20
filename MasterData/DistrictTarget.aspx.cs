using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public partial class DistrictTarget : System.Web.UI.Page
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
       
        txtTarget.Value = "";
        txtYear.Value = "";
        lblID.Text = "";

    }
    void Save()
    {

        string INSERT = "INSERT INTO DistrictTarget ([year], DistrictID,Target) VALUES (@Year, @DistrictID,@Target)";

        using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            sqlConnection.Open();

            using (SqlCommand sqlCommand = new SqlCommand(INSERT, sqlConnection))
            {
                sqlCommand.Parameters.Add("@Year", SqlDbType.NVarChar).Value = txtYear.Value;
                sqlCommand.Parameters.Add("@DistrictID", SqlDbType.NVarChar).Value = ddlDistrictNew.SelectedValue;
                sqlCommand.Parameters.Add("@Target", SqlDbType.Int).Value = txtTarget.Value;
                sqlCommand.ExecuteNonQuery();
            }
        }
    }
    void Edit()
    {

        string Edit = "update DistrictTarget set [year]=@Year, DistrictID=@DistrictID,Target=@Target where ID=@ID";

        using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            sqlConnection.Open();

            using (SqlCommand sqlCommand = new SqlCommand(Edit, sqlConnection))
            {
                sqlCommand.Parameters.Add("@Year", SqlDbType.NVarChar).Value = txtYear.Value;
                sqlCommand.Parameters.Add("@DistrictID", SqlDbType.NVarChar).Value = ddlDistrictNew.SelectedValue;
                sqlCommand.Parameters.Add("@Target", SqlDbType.Int).Value = txtTarget.Value;
                sqlCommand.Parameters.Add("@ID", SqlDbType.Int).Value = lblID.Text;
                sqlCommand.ExecuteNonQuery();
            }
        }
    }
    void GetGroup(string ID)
    {
        DataTable dt = obj.Selectdt("select ID,[Year],Target,DistrictID from DistrictTarget where ID=" + ID);
        if (dt.Rows.Count > 0)
        {
            txtYear.Value = dt.Rows[0]["Year"].ToString();
            txtTarget.Value = dt.Rows[0]["Target"].ToString();
            ddlDistrictNew.SelectedValue = dt.Rows[0]["DistrictID"].ToString();
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
            obj.execNonQuery("Delete from DistrictTarget where ID=" + e.CommandArgument.ToString());
            gvGroup.DataBind();
        }
    }
    protected void BtnSearch_Click(object sender, EventArgs e)
    {
        string filter = "1<1";
        if (!string.IsNullOrEmpty(txtYearSrc.Value))
        {
            filter = " t.[Year]=" + txtYearSrc.Value ;
        }
        if (!string.IsNullOrEmpty(ddlDistrict.SelectedValue))
        {
            filter = filter + " and t.DistrictID=" + ddlDistrict.SelectedValue;//HttpContext.Current.Profile["DistrictID"].ToString();
        }
               
        if (!string.IsNullOrEmpty(filter))
        {
            dsDistrictTarget.SelectCommand = @"Select t.*,g.Name_local as District from Districttarget t left outer join zDistrict g on g.ID=t.DistrictID where " + filter;
            dsDistrictTarget.DataBind();
            gvGroup.DataBind();           

        }
    }
}