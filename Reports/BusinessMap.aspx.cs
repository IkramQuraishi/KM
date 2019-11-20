﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BusinessMap : System.Web.UI.Page
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
            rptMarkers.DataSource = obj.Selectdt(@";with Bpayment as (select BusinessID, 1 as PaymentStatus from payment where YearID="+ GetYear()+@")
Select top 5000 ID, Latitude, longitude, Address as Description, BusinessName as title, Street as Name, isnull(p.PaymentStatus, 0) as PaymentStatus
from business left join Bpayment p on p.BusinessID = business.ID
 where latitude is not null and " + GetFilter());
            rptMarkers.DataBind();
        }
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
            filter = filter + " and code = '" + txtCode.Text + "'";
        }
        return filter;
    }
    string GetYear()
    {
        string filter = "substring(dbo.ToPersianDate(getdate()), 1,4)";
       
        if (!string.IsNullOrEmpty(txtYear.Text))
        {
            filter = txtYear.Text;
        }
        return filter;
    }
}