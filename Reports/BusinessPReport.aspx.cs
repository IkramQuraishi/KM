using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BusinessPaymentReport : System.Web.UI.Page
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
  
    protected void gvGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
          
            //if (e.Row.Cells[8].Text == "0")
            //{
            //    e.Row.Cells[8].BackColor = Color.Red;
            //    e.Row.Cells[8].Text = "پرداخت نشده";
            //    e.Row.Cells[8].ForeColor = Color.White;
            //}
           
            //lnked.Attributes["data-toggle"] = "modal";
            //lnked.Attributes["data-target"] = "#myModal";
            Total += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Payment"));
            
        }
            // if row type is DataRow
           
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[5].Text = "مجموع";
            e.Row.Cells[6].Text = String.Format("{0:N0}", Total);
       
        }
    }

    void BindGrid()
    {
        string filter = "1=1 and isverified=1 and BusinessStatusID=1";
        string yearFilter="1=1";
        
        if (ddlDistrict.SelectedValue != "-1" && ddlDistrict.SelectedIndex != -1)
        {
            filter = filter + " and DistrictID=" + ddlDistrict.SelectedValue;
        }
        if (!string.IsNullOrEmpty(txtCode.Value))
        {
            filter = filter + " and business.code like '%" + txtCode.Value + "%'";
        }
        if (!string.IsNullOrEmpty(txtName.Value))
        {
            filter = filter + " and business.BusinessName like N'%" + txtName.Value + "%'";
        }
        if (!string.IsNullOrEmpty(txtYear.Value) )
        {
            yearFilter = " yearID="+txtYear.Value;
        }
        dsReport.SelectCommand = @"
select business.ID,business.code,businessName,OwnerName, c.Name_Local as Class,ct.Name_Local as Category, d.Name_Local as District, isnull(pc.Payment,0) as Payment
 from business left outer join zBusinessClass c on business.BusinessClassID=c.ID left outer join 
 (select businessID,sum(case when FeeTypeID=1 then amount else 0 end )as LicenseFee,
sum(case when FeeTypeID=2 then amount else 0 end) as ClassFee from  Payment where " + yearFilter+ @" group by businessID) p on p.BusinessID=Business.ID 
 left outer join zBusinessCategory ct on ct.ID=business.BusinessCategoryID left outer join zDistrict d on d.ID=business.DistrictID  LEFT OUTER join PaymentCategory pc ON pc.BusinessClassID=business.BusinessClassID AND pc.BusinessGroupID=business.GroupID AND
 pc.BusinessCategoryID=business.BusinessCategoryID where " + filter;

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
  

    protected void gvGroup_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "show")
        {
            Session["BusinessID"] = e.CommandArgument.ToString();
            ScriptManager.RegisterStartupScript(Page, typeof(Page), "pop", "window.open('../Business/ViewBusiness.aspx');", true);
           
        }
    }
    protected void gvGroup_PageIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }
}