using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TargetByDistrict : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
      
      
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid();
    }
    private float TotalL = 0;
    private float TotalS = 0;
    protected void gvGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
        //    // if row type is DataRow
        //    TotalL += Convert.ToSingle(DataBinder.Eval(e.Row.DataItem, "LicensePayment"));
        //    TotalS += Convert.ToSingle(DataBinder.Eval(e.Row.DataItem, "SignboardPayment"));
        //}

        //else if (e.Row.RowType == DataControlRowType.Footer)
        //{
        //    e.Row.Cells[0].Text = string.Format("{0} ({1})","مجموع عواید جمع آوری شده به افغانی:",TotalL+TotalS);
        //    e.Row.Cells[1].Text = String.Format("{0:N0}", TotalL);
        //    e.Row.Cells[2].Text = String.Format("{0:N0}", TotalS);
        //}
    }

    void BindGrid()
    {
       
        try
        {
            dsReport.SelectCommand = @";with DistrictRevenue as (
                                    select b.DistrictID, sum(p.Amount) as Revenue from Payment p inner join Business b on b.ID=p.BusinessID
                                    where p.YearID=@Year group by b.DistrictID)
                                    select @Year as [Year], d.Name_Local as District, dt.Target, dr.Revenue, (dr.Revenue/dt.Target)*100 as Achieved from DistrictRevenue dr
                                    inner join DistrictTarget dt on dt.DistrictID=dr.DistrictID inner join zDistrict d on d.ID=dr.DistrictID where dt.[Year]=@Year
                                    and d.ID= (case when @District<>-1 then @District else d.ID end)";
            dsReport.SelectParameters["District"].DefaultValue = ddlDistrict.SelectedValue;
            dsReport.SelectParameters["Year"].DefaultValue = txtYear.Value;

            dsReport.DataBind();
            gvGroup.DataBind();
        }
        catch (Exception)
        {

            System.Windows.Forms.MessageBox.Show("اشنباه");
        }
      
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