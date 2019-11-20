using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TarufaDistList : System.Web.UI.Page
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
   
    protected void gvGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
    }

    void BindGrid()
    {
        string filter = "1=1 and isverified=1 and BusinessStatusID=1";
        string yearFilter="1=1";
        
        if (ddlDistrict.SelectedValue != "-1" && ddlDistrict.SelectedIndex != -1)
        {
            filter = filter + " and b.DistrictID=" + ddlDistrict.SelectedValue;
        }
        if (!string.IsNullOrEmpty(txtCode.Value))
        {
            filter = filter + " and b.code like '%" + txtCode.Value + "%'";
        }
        if (!string.IsNullOrEmpty(txtName.Value))
        {
            filter = filter + " and b.BusinessName like N'%" + txtName.Value + "%'";
        }
        if (!string.IsNullOrEmpty(txtYear.Value) )
        {
            yearFilter = " and b.yearID="+txtYear.Value;
        }
        dsReport.SelectCommand = @"
select b.Code,b.BusinessName, b.OwnerName, d.Name_Local as District, b.phone, p.amount as AmountDue,
case when p.TarufaDate is not null then dbo.ToPersianDate(p.tarufadate) end as TarufaDate, p.YearID from Business b inner join Payment p on p.BusinessID=b.ID
inner join zDistrict d on d.ID=b.DistrictID
where p.PaymentStatusID=1 and " + filter;
        //System.Windows.Forms.MessageBox.Show(dsReport.SelectCommand.ToString());
        dsReport.DataBind();
        gvGroup.DataBind();
    }

    void ExportToExcel(GridView GridView1)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content -disposition", "attachment;filename=BusinessPayment.xls");
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
    protected void gvGroup_PageIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }
}