using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            
            BindChartAvgAge();
            BindChartBusiness();
            BindChartLoan();
        }
    }

    void BindChartBusiness()
    {
        ConClass obj = new ConClass();
        DataTable dt;
        if (Cache["data"] == null)
        {

            dt = obj.Selectdt(@"select N'اصناف' as Businesses, count(distinct case when datepart(q,applicationDate)=1 then ID else null end) Q1,
                                        count(distinct case when datepart(q,applicationDate)=2 then ID else null end) Q2,
                                        count(distinct case when datepart(q,applicationDate)=3 then ID else null end) Q3,
                                        count(distinct case when datepart(q,applicationDate)=4 then ID else null end) Q4
                                         from business where left(dbo.ToPersianDate(applicationDate),4)=left(dbo.ToPersianDate(getdate()),4)");
            Cache.Insert("data", dt, null, DateTime.MaxValue, TimeSpan.Zero);
        }
        else
        {
            dt = (DataTable)Cache["data"];
        }

        foreach (DataRow dr in dt.Rows)
        {
            Series series = new Series();
            for (int i = 1; i < dt.Columns.Count; i++)
            {

                int y = Convert.ToInt32(dr[i]);
                series.Points.AddXY(dt.Columns[i].ColumnName.ToString(), y);
                series.Points[i - 1].Label = dr[i].ToString();
                series.Points[i - 1].Font = new System.Drawing.Font("Trebuchet MS", 7.0F, System.Drawing.FontStyle.Regular);

            }
            chBusiness.Series.Add(series);


        }

        chBusiness.Series[0].LegendText = " تعداد اصناف ";
        chBusiness.Series[0].Color = Color.DeepPink;
        

        chBusiness.Visible = true;
        chBusiness.Legends[0].Enabled = true;
        chBusiness.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
        chBusiness.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
        chBusiness.ChartAreas["ChartArea1"].AxisY.LabelStyle.Font = new System.Drawing.Font("Trebuchet MS", 7.25F, System.Drawing.FontStyle.Regular);
        chBusiness.ChartAreas["ChartArea1"].AxisX.LabelStyle.Font = new System.Drawing.Font("Trebuchet MS", 7.25F, System.Drawing.FontStyle.Regular);
    }
    void BindChartAvgAge()
    {
        ConClass obj = new ConClass();
        DataTable dt = obj.Selectdt(@"select ft.Name_local as Indicator, isnull(sum(p.amount),0)/1000 as [عواید] from   zFeeType ft left outer join Payment p on ft.ID=p.FeeTypeID where ft.ID in (1,2)
group by ft.Name_Local");


        foreach (DataRow dr in dt.Rows)
        {
            Series series = new Series();
            for (int i = 1; i < dt.Columns.Count; i++)
            {

                int y = Convert.ToInt32(dr[i]);
                series.Points.AddXY(dt.Columns[i].ColumnName.ToString(), y);
                series.Points[i - 1].Label = dr[i].ToString();
                series.Points[i - 1].Font = new System.Drawing.Font("Trebuchet MS", 7.0F, System.Drawing.FontStyle.Regular);

            }
            chAvgAge.Series.Add(series);


        }


        chAvgAge.Series[0].LegendText = " (۰۰۰)فیس خدمات شهری";
        chAvgAge.Series[0].Color = Color.DeepPink;
        chAvgAge.Series[1].LegendText = "(۰۰۰)فیس لوحه";
        chAvgAge.Series[1].Color = Color.Green;

        chAvgAge.Visible = true;
        chAvgAge.Legends[0].Enabled = true;
        chAvgAge.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
        chAvgAge.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
        chAvgAge.ChartAreas["ChartArea1"].AxisY.LabelStyle.Font = new System.Drawing.Font("Trebuchet MS", 7.25F, System.Drawing.FontStyle.Regular);
        chAvgAge.ChartAreas["ChartArea1"].AxisX.LabelStyle.Font = new System.Drawing.Font("Trebuchet MS", 7.25F, System.Drawing.FontStyle.Regular);
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