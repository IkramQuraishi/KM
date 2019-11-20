using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class LicenseIssued : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        var now = PersianDateTime.Now;
        var today = now.ToString(PersianDateTimeFormat.Date);
        txtFrom.Attributes["onclick"] = "PersianDatePicker.Show(this,'" + today + "');";
        txtTo.Attributes["onclick"] = "PersianDatePicker.Show(this,'" + today + "');";
      
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    private float TotalL = 0;
    
    protected void gvGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // if row type is DataRow
            TotalL += Convert.ToSingle(DataBinder.Eval(e.Row.DataItem, "Licenses"));
           
        }

        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[0].Text = string.Format("{0}","مجموع تعداد جواز:");
            e.Row.Cells[1].Text = String.Format("{0:N0}", TotalL);
          
        }
    }

    void BindGrid()
    {
        string filter = "1=1 ";
     
        if (ddlDistrict.SelectedValue != "-1" && ddlDistrict.SelectedIndex != -1)
        {
            filter = filter + " and b.DistrictID=" + ddlDistrict.SelectedValue;
        }
        

        if (!string.IsNullOrEmpty(txtFrom.Value) && !string.IsNullOrEmpty(txtTo.Value))
        {
            
               
                    filter = filter + " and  bl.IssueDate between '" + PersianDate.ConvertDate.ToEn(txtFrom.Value).ToShortDateString() + "' and '" + PersianDate.ConvertDate.ToEn(txtTo.Value).ToShortDateString() + "'";
               
           
           
        }
        dsReport.SelectCommand = @"select d.Name_local as District, count(bl.ID) as Licenses from BusinessLicense bl inner join Business b on b.ID=bl.BusinessID inner join zDistrict d on d.ID=b.DistrictID
                                    where "+filter +
                                    " group by d.Name_Local";
       
        dsReport.DataBind();
        gvGroup.DataBind();
    }

    void ExportToExcel(GridView GridView1)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=revenue.xls");
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
       
    }
}