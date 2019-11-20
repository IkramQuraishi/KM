using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BusinessFiles : System.Web.UI.Page
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

            if (null != Session["BusinessID"])
            {
                btnCreate.HRef = "Create.aspx?ID=" + Session["BusinessID"];
            }
        }
    }
    
    private void UploadFile()
    {
        string fileName, Description, BusinessID;
        byte[] data;
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString);
        using (SqlCommand comm = new SqlCommand("insert into BusinessFile(FileName,FileContent,Description,BusinessID) values(@FileName,@FileContent,@Description,@ID)", conn))
        {
            BusinessID = Session["BusinessID"].ToString();
            fileName = fuPic.FileName;//txtName.Value;
            Description = txtDescription.Value;
            data = fuPic.FileBytes;

            comm.Parameters.Add(new SqlParameter("ID", BusinessID));
            comm.Parameters.Add(new SqlParameter("FileName", fileName));
            comm.Parameters.Add(new SqlParameter("Description", Description));
            comm.Parameters.Add(new SqlParameter("FileContent", data));

            conn.Open();
            int ret = comm.ExecuteNonQuery();
            conn.Close();
        }
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (null != Session["BusinessID"] && gvGroup.Rows.Count > 0)
        {
            try
            {
                UploadFile();
                gvPayment.DataBind();
            }
            catch (Exception)
            {


            }

        }
        else
        {
            Clear();
        }
      

    }
   
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Clear();
    }
   
   
    void Clear()
    {
        txtDescription.Value = "";
        //txtName.Value = "";
        

    }
  
  
    protected void gvPayment_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        lblID.Text = e.CommandArgument.ToString();
        if (e.CommandName == "download")
        {
            Openfile(e.CommandArgument.ToString());
        }

        else if (e.CommandName == "Del")
        {
            using (ConClass obj = new ConClass())
            {

                obj.execNonQuery("Delete from BusinessFile where ID=" + e.CommandArgument.ToString());
                gvPayment.DataBind();
                Clear();
            }
        }
    }

    private void Openfile(string iFileId)
    {
        string strSql = null;
        SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString);

        if (connection.State == ConnectionState.Open)
        {
            connection.Close();
        }
        connection.Open();

        strSql = "Select FileContent,FileName from BusinessFile WHERE ID=" + iFileId;

        SqlCommand sqlCmd = new SqlCommand(strSql, connection);
        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = sqlCmd;
        DataTable dt = new DataTable();
        da.Fill(dt);

        byte[] fileData = (byte[])dt.Rows[0]["FileContent"];
        Response.Buffer = true;
        Response.Charset = "";
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.AddHeader("content-disposition", "attachment; filename=\"" + dt.Rows[0][1].ToString() + "\"");
        
        Response.ContentType = "application/";
        Response.BinaryWrite(fileData);
        Response.Flush();
        Response.End();

    }
  
}