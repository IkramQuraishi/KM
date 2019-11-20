using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CartList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            BindDistrict();
            Label lbl = (Label)Master.FindControl("lblTitle");
            lbl.Text = "برنامه مدیریت ثبت دست فروشان";
        }
        
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        
        BindGrid();

    }
    void BindGrid()
    {


        string filter = "1=1 ";
       
        if (!HttpContext.Current.User.IsInRole("Admin"))
        {
            filter = filter + " and b.DistrictID=" + HttpContext.Current.Profile["DistrictID"].ToString();
        }

        if (ddlDistrict.SelectedValue != "-1" && ddlDistrict.SelectedIndex != 0)
        {
            if (HttpContext.Current.User.IsInRole("Admin"))
            {
                filter = filter + " and b.DistrictID=" + ddlDistrict.SelectedValue;
            }
            else
            {
                filter = filter + " and b.DistrictID=" +HttpContext.Current.Profile["DistrictID"].ToString();

            }

        }
        if (!string.IsNullOrEmpty(txtCode.Value))
        {
            filter = filter + " and b.code = '" + txtCode.Value + "'";
        }
        if (!string.IsNullOrEmpty(txtName.Value))
        {
            filter = filter + " and b.OwnerName like N'%" + txtName.Value + "%'";
        }
        if (!string.IsNullOrEmpty(txtBusinessName.Value))
        {
            filter = filter + " and b.BusinessName like N'%" + txtBusinessName.Value + "%'";
        }
        if (!string.IsNullOrEmpty(txtFName.Value))
        {
            filter = filter + " and b.FatherName like N'%" + txtFName.Value + "%'";
        }
        string sql = @"select b.ID, b.Code,b.BusinessName,b.OwnerName,b.fathername,d.name_local as District,b.phone from Cart b 
                       left outer join zDistrict d on d.ID=b.DistrictID where " + filter;
        //System.Windows.Forms.MessageBox.Show(filter);
        dsPaymentCategory.SelectCommand = sql;
        gvGroup.DataBind();
    }
    protected void gvGroup_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        lblID.Text = e.CommandArgument.ToString();
        if (e.CommandName == "Ed")
        {
            //Session["BusinessID"] = lblID.Text;
            Response.Redirect("CreateCart.aspx?ID="+ lblID.Text);
        }
        else if (e.CommandName == "Del")
        {
            using (ConClass obj=new ConClass())
            {

                obj.execNonQuery("delete from cart where ID=" + e.CommandArgument.ToString());
                gvGroup.DataBind();   
            }
        }
        else if (e.CommandName == "View")
        {
            Session["CartID"] = lblID.Text;
            Response.Redirect("ViewCart.aspx");
        }
    }
  
    protected void gvGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if(HttpContext.Current.User.IsInRole("Admin"))
        {
            //this.gvGroup.Columns[8].Visible = true;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton lnked = (LinkButton)e.Row.FindControl("lnkEdit");
                lnked.Visible = true;
                LinkButton lnkdel = (LinkButton)e.Row.FindControl("lnkDelete");
                lnkdel.Visible = true;
                LinkButton lnkView = (LinkButton)e.Row.FindControl("lnkView");
                lnkView.Visible = true;
            }
        }
    }


    void BindDistrict()
    {

        dsDistrict.SelectCommand = "Select ID,Name_local from zDistrict where ID=" + HttpContext.Current.Profile["DistrictID"].ToString() + " union select null,N'--انتخاب--' order by ID";
        ddlDistrict.DataBind();

    }
    protected void btnNew_Click(object sender, EventArgs e)
    {
       // NewBusinessID();
        Response.Redirect("CreateCart.aspx");
    }

    [WebMethod]
    public static List<string> GetAutoCompleteData(string Code)
    {
        List<string> result = new List<string>();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select top 10 BusinessName as Name from Cart where BusinessName LIKE N''+@SearchText+'%'", con))
            {
                con.Open();
                cmd.Parameters.AddWithValue("@SearchText", Code);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    result.Add(dr["Name"].ToString());
                }
                return result;
            }
        }
    }

    [WebMethod]
    public static List<string> GetOwnerName(string Code)
    {
        List<string> result = new List<string>();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select top 10 OwnerName as Name from Cart where OwnerName LIKE N''+@SearchText+'%'", con))
            {
                con.Open();
                cmd.Parameters.AddWithValue("@SearchText", Code);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    result.Add(dr["Name"].ToString());
                }
                return result;
            }
        }
    }
    [WebMethod]
    public static List<string> GetOwnerFatherName(string Code)
    {
        List<string> result = new List<string>();

        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Conn"].ConnectionString))
        {
            using (SqlCommand cmd = new SqlCommand("select top 10 FatherName as Name from Cart where FatherName LIKE N''+@SearchText+'%'", con))
            {
                con.Open();
                cmd.Parameters.AddWithValue("@SearchText", Code);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    result.Add(dr["Name"].ToString());
                }
                return result;
            }
        }
    }
    protected void gvGroup_PageIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }
  
}