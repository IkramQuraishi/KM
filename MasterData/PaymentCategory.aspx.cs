using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public partial class PaymentCategory : System.Web.UI.Page
{
    ConClass obj = new ConClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
           // LoadData();
        }

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
            // gvGroup.DataBind();
            LoadData();
        }
        catch (Exception)
        {
            
            throw;
        }
    }
    void Clear()
    {
        txtPrice.Value = "";
        lblID.Text = "";

    }
    void Save()
    {

        string INSERT = "INSERT INTO PaymentCategory (BusinessGroupID,LocationCategoryID, BusinessClassID,BusinessCategoryID,Payment) VALUES (@BusinessGroupID,@LocationCategoryID, @BusinessClassID,@BusinessCategoryID,@Payment)";

        using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            sqlConnection.Open();

            using (SqlCommand sqlCommand = new SqlCommand(INSERT, sqlConnection))
            {
                sqlCommand.Parameters.Add("@BusinessGroupID", SqlDbType.Int).Value = ddlGroup.SelectedValue;
                sqlCommand.Parameters.Add("@LocationCategoryID", SqlDbType.Int).Value = ddlLocationCategory.SelectedValue;
                sqlCommand.Parameters.Add("@BusinessClassID", SqlDbType.Int).Value = ddlClass.SelectedValue;
                sqlCommand.Parameters.Add("@BusinessCategoryID", SqlDbType.Int).Value = ddlCategory.SelectedValue;
                sqlCommand.Parameters.Add("@Payment", SqlDbType.Float).Value = txtPrice.Value;
                sqlCommand.ExecuteNonQuery();
            }
        }
    }
    void Edit()
    {

        string Edit = "update PaymentCategory set BusinessGroupID=@BusinessGroupID,LocationCategoryID=@LocationCategoryID, BusinessClassID=@BusinessClassID,BusinessCategoryID=@BusinessCategoryID,Payment=@Payment where ID=@ID";

        using (SqlConnection sqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            sqlConnection.Open();

            using (SqlCommand sqlCommand = new SqlCommand(Edit, sqlConnection))
            {
                sqlCommand.Parameters.Add("@BusinessGroupID", SqlDbType.Int).Value = ddlGroup.SelectedValue;
                sqlCommand.Parameters.Add("@LocationCategoryID", SqlDbType.Int).Value = ddlLocationCategory.SelectedValue;
                sqlCommand.Parameters.Add("@BusinessClassID", SqlDbType.Int).Value = ddlClass.SelectedValue;
                sqlCommand.Parameters.Add("@BusinessCategoryID", SqlDbType.Int).Value = ddlCategory.SelectedValue;
                sqlCommand.Parameters.Add("@Payment", SqlDbType.Float).Value = txtPrice.Value;
                sqlCommand.Parameters.Add("@ID", SqlDbType.Int).Value = lblID.Text;
                sqlCommand.ExecuteNonQuery();
            }
        }
    }
    void GetGroup(string ID)
    {
        DataTable dt = obj.Selectdt("select * from paymentCategory where ID=" + ID);
        if (dt.Rows.Count > 0)
        {
            if (!string.IsNullOrEmpty(ddlGroup.SelectedValue))
            {
                ddlGroup.SelectedValue = dt.Rows[0]["BusinessGroupID"].ToString();
                ddlClass.DataBind();
            }
            if (!string.IsNullOrEmpty(ddlClass.SelectedValue))
            {
                ddlClass.SelectedValue = dt.Rows[0]["BusinessClassID"].ToString();
            }
            if (!string.IsNullOrEmpty(ddlLocationCategory.SelectedValue))
            {
                ddlLocationCategory.SelectedValue = dt.Rows[0]["LocationCategoryID"].ToString();
            }
            if (!string.IsNullOrEmpty(ddlCategory.SelectedValue))
            {
                ddlCategory.SelectedValue = dt.Rows[0]["BusinessCategoryID"].ToString();
            }
            txtPrice.Value = dt.Rows[0]["Payment"].ToString();
            
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

            obj.execNonQuery("Delete from PaymentCategory where ID=" + e.CommandArgument.ToString());
            gvGroup.DataBind();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadData();
    }
    void LoadData()
    {
        string filter = "1=1";
        if (!string.IsNullOrEmpty(ddlGroup.SelectedValue))
        {
            filter = filter + " and g.ID=" + ddlGroup.SelectedValue;
        }
        if (!string.IsNullOrEmpty(ddlClass.SelectedValue))
        {
            filter = filter + " and cls.ID=" + ddlClass.SelectedValue;
        }
        if (!string.IsNullOrEmpty(ddlCategory.SelectedValue))
        {
            filter = filter + " and ct.ID=" + ddlCategory.SelectedValue;
        }
        if (!string.IsNullOrEmpty(ddlLocationCategory.SelectedValue))
        {
            filter = filter + " and lc.ID=" + ddlLocationCategory.SelectedValue;
        }
        string sql = @"select c.*,g.Name_local as [BusinessGroup],ct.Name_local as Category,lc.Name_Local as LocationCategory,cls.name_local as Class from PaymentCategory c
inner join zLocationCategory lc on lc.ID = c.LocationCategoryID inner join zBusinessClass cls on cls.ID = c.BusinessClassID inner join zBusinessCategory ct on ct.ID = c.BusinessCategoryID
inner join zBusinessGroup g on g.ID = cls.BusinessGroupID where " + filter;
        dsPaymentCategory.SelectCommand = sql;
        dsPaymentCategory.DataBind();
        //gvGroup.DataBind();
    }
}