using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

public partial class Chart : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            
          
           
            BindChartLoan();
        }
    }

    
   
    void BindChartLoan()
    {
        ConClass obj = new ConClass();
        DataTable dt = obj.Selectdt(@"select g.Name_Local as BusinessGroup,count(b.ID) as Businesses from business b inner join zBusinessGroup g on g.ID=b.GroupID
 group by g.Name_Local");

        string[] x = new string[dt.Rows.Count];
        int[] y = new int[dt.Rows.Count];
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            x[i] = dt.Rows[i][0].ToString();
            y[i] = Convert.ToInt32(dt.Rows[i][1]);
            
        }
        chLoanSector.Series[0].Points.DataBindXY(x, y);
        chLoanSector.Series[0].ChartType = SeriesChartType.Pie;
        chLoanSector.ChartAreas["ChartArea1"].Area3DStyle.Enable3D = false;
       
        chLoanSector.Legends[0].Enabled = true;
        chLoanSector.Visible = true;
        //obj.Dispose();

    }
    }