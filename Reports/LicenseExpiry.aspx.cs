using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LicenseFeeDueReport : System.Web.UI.Page
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
    private int Total = 0;
    private int Total1 = 0;
    protected void gvGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //e.Row.Cells[9].BackColor = Color.Red;
                //e.Row.Cells[9].Text = "پرداخت نشده";
               // e.Row.Cells[9].ForeColor = Color.White;
           
           
           
            //lnked.Attributes["data-toggle"] = "modal";
            //lnked.Attributes["data-target"] = "#myModal";
            //Total += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "License"));
            //Total1 += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ClassFee"));
        }
            // if row type is DataRow
           
        //else if (e.Row.RowType == DataControlRowType.Footer)
        //{
        //    e.Row.Cells[5].Text = "مجموع";
        //    e.Row.Cells[6].Text = String.Format("{0:N0}", Total);
        //    e.Row.Cells[7].Text = String.Format("{0:N0}", Total1);
        //}
    }

    void BindGrid()
    {
        string filter = "1=1 and isverified=1 and business.BusinessStatusID=1";
      
        if (ddlDistrict.SelectedValue != "-1" && ddlDistrict.SelectedIndex != -1)
        {
            filter = filter + " and DistrictID=" + ddlDistrict.SelectedValue;
        }
        if (!string.IsNullOrEmpty(txtCode.Value))
        {
            filter = filter + " and business.code like '%" + txtCode.Value + "%'";
        }
        if (!string.IsNullOrEmpty(txtaddress.Value))
        {
            filter = filter + " and business.address like N'%" + txtaddress.Value + "%'";
        }
        dsReport.SelectCommand = @"
select business.ID,business.code,businessName,OwnerName, c.Name_Local as Class,FatherName,ct.Name_Local as Category,phone,address, d.Name_Local as District,
case when bl.ExpirationDate is not null then  dbo.topersianDate(isnull(bl.ExpirationDate,'')) end as License, case when bl.IssueDate is not null then dbo.topersianDate(bl.IssueDate) end as IssueDate
from business left outer join zBusinessClass c on business.BusinessClassID=c.ID left outer join zBusinessCategory ct on ct.ID=business.BusinessCategoryID
left outer join zDistrict d on d.ID=business.DistrictID inner join BusinessLicense bl on bl.BusinessID=business.ID where 1=1 --DATEDIFF(d,GETDATE(),bl.ExpirationDate)<30
 and 1=1 and isverified=1 and " + filter;
        //System.Windows.Forms.MessageBox.Show(dsReport.SelectCommand.ToString());
        dsReport.DataBind();
        gvGroup.DataBind();
        
    }

    void ExportToExcel(GridView GridView1)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=BusinessPayment.xls");
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
  

   
    
}