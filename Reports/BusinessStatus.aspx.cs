﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BusinessStatus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var now = PersianDateTime.Now;
        var today = now.ToString(PersianDateTimeFormat.Date);
       
      
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    private int TotalMale = 0;
    private int TotalFemale = 0;
    private int TotalEmp = 0;
    private float TotalSales = 0;
    protected void gvGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    TotalMale += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "EmployeeMale"));
        //    TotalFemale += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "EmployeeFemale"));
        //    TotalEmp += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalEmployees"));
        //    TotalSales += Convert.ToSingle(DataBinder.Eval(e.Row.DataItem, "AnnualSales"));

        //}
        //else if (e.Row.RowType == DataControlRowType.Footer)
        //{
        //    e.Row.Cells[9].Text = "مجموع";
        //    e.Row.Cells[10].Text = String.Format("{0:N0}", TotalMale);
        //    e.Row.Cells[11].Text = String.Format("{0:N0}", TotalFemale);
        //    e.Row.Cells[12].Text = String.Format("{0:N0}", TotalEmp);
        //    e.Row.Cells[13].Text = String.Format("{0:N0}", TotalSales);
        //}
       
            
    }

    void BindGrid()
    {
        string filter = "1=1 and b.isverified=1 and b.BusinessStatusID=1";
        if (ddlClass.SelectedValue != "-1" && ddlClass.SelectedIndex != -1)
        {
            filter = filter + " and b.BusinessClassID=" + ddlClass.SelectedValue;
        }
        if (ddlDistrict.SelectedValue != "-1" && ddlDistrict.SelectedIndex != -1)
        {
            filter = filter + " and b.DistrictID=" + ddlDistrict.SelectedValue;
        }
        if (!string.IsNullOrEmpty(txtaddress.Value))
        {
            filter = filter + " and b.address like N'%" + txtaddress.Value +"%'";
        }

        //with Payment column
        //        dsReport.SelectCommand = @"
        //select b.ID, b.code,b.BusinessName,b.OwnerName,b.FatherName,b.Tazkira,b.Street,b.Address,b.ShopNumber,b.Phone,b.Email,
        //                                               c.Name_local as Class,ct.Name_local as Category,pr.Name_Local as Province,d.Name_local as District,
        //                                              gn.Name_local as Gender,
        // case when l.ID is null then N'نخیر' else N'بلی' end as BusinessLicense,case when count(p.ID) >0 then N'بلی' else N'نخیر' end as payment from Business b 
        //left outer join BusinessLicense l on b.ID=l.BusinessID left outer join Payment p on b.ID=p.BusinessID  left outer join zBusinessClass c on c.ID=b.BusinessClassID
        //                                                left outer join zBusinessCategory ct on ct.ID=b.BusinessCategoryID
        //                                                left outer join zGender gn on gn.ID=b.Gender
        //                                                left outer join zProvince pr on p.ID=b.ProvinceID
        //                                                left outer join zDistrict d on d.id=b.DistrictID where " + filter +
        //@" group by b.ID, b.code,b.BusinessName,b.OwnerName,b.FatherName,b.Tazkira,b.Street,b.Address,b.ShopNumber,b.Phone,b.Email,
        //                                               c.Name_local,ct.Name_Local, pr.Name_Local ,d.Name_local,                                              
        //                                                gn.Name_local,l.ID";

        //without payment column
        dsReport.SelectCommand = @"
select b.ID, b.code,b.BusinessName,b.OwnerName,b.FatherName,b.Tazkira,b.Street,b.Address,b.ShopNumber,b.Phone,b.Email,
                                               c.Name_local as Class,ct.Name_local as Category,pr.Name_Local as Province,d.Name_local as District,
                                              gn.Name_local as Gender,
 case when l.ID is null then N'نخیر' else N'بلی' end as BusinessLicense from Business b 
left outer join BusinessLicense l on b.ID=l.BusinessID left outer join zBusinessClass c on c.ID=b.BusinessClassID
                                                left outer join zBusinessCategory ct on ct.ID=b.BusinessCategoryID
                                                left outer join zGender gn on gn.ID=b.Gender
                                                left outer join zProvince pr on pr.ID=b.ProvinceID
                                                left outer join zDistrict d on d.id=b.DistrictID where " + filter +
@" group by b.ID, b.code,b.BusinessName,b.OwnerName,b.FatherName,b.Tazkira,b.Street,b.Address,b.ShopNumber,b.Phone,b.Email,
                                               c.Name_local,ct.Name_Local, pr.Name_Local ,d.Name_local,                                              
                                                gn.Name_local,l.ID";
        dsReport.DataBind();
        gvGroup.DataBind();
    }

    void ExportToExcel(GridView GridView1)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=BusinessDetail.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            //To Export all pages
            GridView1.AllowPaging = false;
            BindGrid();

            GridView1.HeaderRow.BackColor = Color.White;
            foreach (TableCell cell in GridView1.HeaderRow.Cells)
            {
                cell.BackColor = GridView1.HeaderStyle.BackColor;
            }
            foreach (GridViewRow row in GridView1.Rows)
            {
                row.BackColor = Color.White;
                foreach (TableCell cell in row.Cells)
                {
                    if (row.RowIndex % 2 == 0)
                    {
                        cell.BackColor = GridView1.AlternatingRowStyle.BackColor;
                    }
                    else
                    {
                        cell.BackColor = GridView1.RowStyle.BackColor;
                    }
                    cell.CssClass = "textmode";
                }
            }

            GridView1.RenderControl(hw);

            //style to format numbers to string
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

    protected void btnPrint_Click(object sender, EventArgs e)
    {
        ExportToExcel(gvGroup);
    }
  

    protected void gvGroup_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "show")
        {
            Session["BusinessID"] = e.CommandArgument.ToString();
            ScriptManager.RegisterStartupScript(Page, typeof(Page), "pop", "window.open('../Business/ViewBusiness.aspx');", true);
           
        }
    }
}