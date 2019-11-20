using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BusinessMap2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
    }




    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //using (ConClass obj=new ConClass())
        //{
        //    rptMarkers.DataSource = obj.Selectdt("Select top 100 ID,Latitude,longitude,BusinessName as Description, Street as Name from business where latitude is not null " + GetFilter());
        //    rptMarkers.DataBind();
        //}
    }
    string GetFilter()
    {
        string filter = "1=1";
        if (ddlClass.SelectedValue != "-1")
        {
            filter = filter + " and businessClassID=" + ddlClass.SelectedValue;
        }
        if (ddlDistrict.SelectedValue != "-1")
        {
            filter = filter + " and DistrictID=" + ddlDistrict.SelectedValue;
        }
        if (!string.IsNullOrEmpty(txtCode.Text))
        {
            filter = filter + " and code like '%" + txtCode.Text + "%'";
        }
        return filter;
    }
    public string ConvertDataTabletoString()
    {
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select TOP 5000 title=BusinessName,lat=latitude,lng=longitude from business where "+GetFilter(), con))
            {
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
                Dictionary<string, object> row;
                foreach (DataRow dr in dt.Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dt.Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
                return serializer.Serialize(rows);
            }
        }
    }
}