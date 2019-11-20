using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CartDetail : System.Web.UI.Page
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
    private int Total = 0;
    protected void gvGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            LinkButton lnked = (LinkButton)e.Row.FindControl("lnk");
           
            //lnked.Attributes["data-toggle"] = "modal";
            //lnked.Attributes["data-target"] = "#myModal";
        }
            // if row type is DataRow
            //Total += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Businesses"));
        //else if (e.Row.RowType == DataControlRowType.Footer)
        //{
        //    e.Row.Cells[0].Text = "مجموع";
        //    e.Row.Cells[1].Text = String.Format("{0:N0}", Total);
        //}
    }

    void BindGrid()
    {
        string filter = "1=1 ";
       
        if (ddlDistrict.SelectedValue != "-1" && ddlDistrict.SelectedIndex != -1)
        {
            filter = filter + " and b.DistrictID=" + ddlDistrict.SelectedValue;
        }
       
        if (!string.IsNullOrEmpty(txtCode.Value))
        {
            filter = filter + " and b.code = '" + txtCode.Value + "'";
        }
        if (!string.IsNullOrEmpty(txtBusinessName.Value))
        {
            filter = filter + " and b.BusinessName like  N'%" + txtBusinessName.Value + "%'";
        }
        if (!string.IsNullOrEmpty(txtName.Value))
        {
            filter = filter + " and b.OwnerName like N'%" + txtName.Value + "%'";
        }
        if (!string.IsNullOrEmpty(txtFName.Value))
        {
            filter = filter + " and b.FatherName like '%" + txtFName.Value + "%'";
        }
        if (!string.IsNullOrEmpty(txtFrom.Value) && !string.IsNullOrEmpty(txtTo.Value))
        {
            filter = filter + " and b.ApplicationDate between '" + PersianDate.ConvertDate.ToEn(txtFrom.Value).ToShortDateString() + "' and '" + PersianDate.ConvertDate.ToEn(txtTo.Value).ToShortDateString() + "'";
        }
        dsReport.SelectCommand = @"select b.ID, b.code,b.BusinessName,b.OwnerName,b.FatherName,b.Tazkira,b.Street,b.Address,b.Phone,
                                               p.Name_Local as Province,d.Name_local as District,
                                               dbo.ToPersianDate(b.ApplicationDate) as ApplicationDate,
                                                gn.Name_local as Gender from Cart b 
                                                left outer join zGender gn on gn.ID=b.Gender
                                                left outer join zProvince p on p.ID=b.ProvinceID
                                                left outer join zDistrict d on d.id=b.DistrictID
                                               where " + filter;
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
            Session["CartID"] = e.CommandArgument.ToString();
            ScriptManager.RegisterStartupScript(Page, typeof(Page), "pop", "window.open('../Business/ViewCart.aspx');", true);
           
        }
    }
    protected void gvGroup_PageIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }
}