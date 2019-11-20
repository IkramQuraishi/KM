using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StreetVendorMap : System.Web.UI.Page
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
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        using (ConClass obj=new ConClass())
        {
            //System.Windows.Forms.MessageBox.Show(GetFilter());
            rptMarkers.DataSource = obj.Selectdt(@"Select top 5000 ID, Latitude, longitude, Address as Description, BusinessName as title, Street as Name
from cart 
 where latitude is not null and " + GetFilter());
            rptMarkers.DataBind();
        }
    }
    string GetFilter()
    {
        string filter = "1=1";
        
        if (ddlDistrict.SelectedValue != "-1")
        {
            filter = filter + " and DistrictID=" + ddlDistrict.SelectedValue;
        }
        if (!string.IsNullOrEmpty(txtCode.Text))
        {
            filter = filter + " and code = '" + txtCode.Text + "'";
        }
        return filter;
    }
    
}