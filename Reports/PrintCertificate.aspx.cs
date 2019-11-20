using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.IO;

public partial class Reports_PrintCertificate : System.Web.UI.Page
{
    public string ID { get; set; }
    public string Code { get; set; }
    public string DistrictID { get; set; }
    public string Name { get; set; }
    public string FatherName { get; set; }
    public string Class { get; set; }
    public string Category { get; set; }
    public string ShopAddress { get; set; }
    public string IssueDate { get; set; }
    public string ExpiryDate { get; set; }
    public System.Drawing.Image Photo { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        GetBusinessInfo();
        Print();
    }
    public System.Drawing.Image ByteToImage(byte[] byteArrayIn)
    {
        using (MemoryStream mStream = new MemoryStream(byteArrayIn))
        {
            return System.Drawing.Image.FromStream(mStream);
        }
    }
    void GetBusinessInfo()
    {
        try
        {
            using (ConClass obj = new ConClass())
            {
                DataTable dt = obj.Selectdt(@"select b.ID,dbo.ToPersianDate(bl.IssueDate) as IssueDate,dbo.ToPersianDate(bl.ExpirationDate) as ExpiryDate,b.OwnerName,b.FatherName,c.Name_Local as Class,ct.Name_Local as Category,
b.street+' - ' +b.ShopNumber  as ShopAddress, d.Code as DistrictID,b.photo,b.Code from BusinessLicense bl inner join Business b on b.ID=bl.BusinessID 
inner join zDistrict d on d.ID=b.DistrictID inner join zBusinessClass c on c.ID=b.BusinessClassID inner join zBusinessCategory ct on ct.ID=b.BusinessCategoryID where bl.StatusID=1 and bl.ID=" + Session["LicenseID"].ToString());
                if (dt.Rows.Count > 0)
                {
                    ID = dt.Rows[0][0].ToString();
                    IssueDate = dt.Rows[0][1].ToString();
                    ExpiryDate = dt.Rows[0][2].ToString();
                    Name = dt.Rows[0][3].ToString();
                    FatherName = dt.Rows[0][4].ToString();
                    Class = dt.Rows[0][5].ToString();
                    Category = dt.Rows[0][6].ToString();
                    ShopAddress = dt.Rows[0][7].ToString();
                    DistrictID = dt.Rows[0][8].ToString();
                    //if (dt.Rows[0][9] != null)
                    //{
                    //    Photo = ByteToImage((Byte[])dt.Rows[0][9]);
                    //}
                    Code = dt.Rows[0][10].ToString();
                }
                dt.Dispose();

            }

        }
        catch (Exception)
        {


        }
    }
    void Print()
    {
        


        //creating a image object
        System.Drawing.Image bitmap = (System.Drawing.Image)Bitmap.FromFile(Server.MapPath("~/images/Final_KM_Certificate.jpg")); // set image 
        System.Drawing.Image Owner = (System.Drawing.Image)Bitmap.FromFile(Server.MapPath("~/images/ikram_1.jpg")); // set image 

        //draw the image object using a Graphics object
        Graphics graphicsImage = Graphics.FromImage(bitmap);

        //Set the alignment based on the coordinates   
        StringFormat stringformat = new StringFormat();
        stringformat.Alignment = StringAlignment.Far;
        stringformat.LineAlignment = StringAlignment.Far;

        StringFormat stringformat2 = new StringFormat();
        stringformat2.Alignment = StringAlignment.Center;
        stringformat2.LineAlignment = StringAlignment.Center;

        //Set the font color/format/size etc..  
        Color StringColor = System.Drawing.ColorTranslator.FromHtml("#000");//customise color adding
        Color StringColor2 = System.Drawing.ColorTranslator.FromHtml("#e80c88");//customise color adding
        //string DistrictID = "6";//Your Text On Image
        //string Name = "اکرام الله";//Your Text On Image
        //string FatherName = "اسد الله";//Your Text On Image
        //string Class = "بانک ها ی خصوصی ";//Your Text On Image
        //string Categegory = "اول";
        //string ShopNumber = "435";
        //string ID = "2546";//Your Text On Image
        //string IssueDate = "05/06/1395";//Your Text On Image
        //string ExpiryDate = "05/06/1396";//Your Text On Image

        //Get Business

        graphicsImage.DrawString(DistrictID, new Font("Arial", 17,
        FontStyle.Regular), new SolidBrush(StringColor), new Point(970, 200),
        stringformat); Response.ContentType = "image/jpeg";

        graphicsImage.DrawString(Code, new Font("Arial", 17,
       FontStyle.Regular), new SolidBrush(StringColor), new Point(1650, 290),
       stringformat); Response.ContentType = "image/jpeg";

        graphicsImage.DrawString(Name, new Font("B Nazanin", 18,
        FontStyle.Regular), new SolidBrush(StringColor), new Point(1740, 450),
        stringformat); Response.ContentType = "image/jpeg";

        graphicsImage.DrawString(FatherName, new Font("B Nazanin", 18,
       FontStyle.Regular), new SolidBrush(StringColor), new Point(1150, 460),
       stringformat); Response.ContentType = "image/jpeg";

        graphicsImage.DrawString(Class, new Font("B Nazanin", 18,
        FontStyle.Regular), new SolidBrush(StringColor), new Point(1730, 510),
        stringformat); Response.ContentType = "image/jpeg";

        graphicsImage.DrawString(Category, new Font("B Nazanin", 18,
      FontStyle.Regular), new SolidBrush(StringColor), new Point(1150, 510),
      stringformat); Response.ContentType = "image/jpeg";

        graphicsImage.DrawString(ShopAddress, new Font("B Nazanin", 18,
      FontStyle.Regular), new SolidBrush(StringColor), new Point(1460, 590),
      stringformat); Response.ContentType = "image/jpeg";

        graphicsImage.DrawString(IssueDate, new Font("B Nazanin", 18,
     FontStyle.Regular), new SolidBrush(StringColor), new Point(1645, 1200),
     stringformat); Response.ContentType = "image/jpeg";

        graphicsImage.DrawString(ExpiryDate, new Font("B Nazanin", 18,
    FontStyle.Regular), new SolidBrush(StringColor), new Point(1645, 1280),
    stringformat); Response.ContentType = "image/jpeg";

        if (Photo != null)
        {
            graphicsImage.DrawImage(Photo, 150, 280, 200, 220);
            Response.ContentType = "image/jpeg";
        }
        //graphicsImage.DrawString(Str_TextOnImage2, new Font("Edwardian Script ITC", 111,
        //FontStyle.Bold), new SolidBrush(StringColor2), new Point(145, 255),
        //stringformat2); Response.ContentType = "image/jpeg";
        int _ID = Convert.ToInt32(ID);
        graphicsImage.DrawImage(GetBarCode(_ID.ToString("000000")), 830, 1250);
        Response.ContentType = "image/jpeg";
       
        bitmap.Save(Response.OutputStream, ImageFormat.Jpeg);
    }

    public System.Drawing.Image GetBarCode(string barCode)
    {
        System.Drawing.Image img;
        System.Web.UI.WebControls.Image imgBarCode = new System.Web.UI.WebControls.Image();
        using (Bitmap bitMap = new Bitmap(barCode.Length * 30, 100))
        {
            using (Graphics graphics = Graphics.FromImage(bitMap))
            {
                Font oFont = new Font("IDAutomationHC39M Free Version", 20);
                PointF point = new PointF(2f, 2f);
                SolidBrush blackBrush = new SolidBrush(Color.Black);
                SolidBrush whiteBrush = new SolidBrush(Color.White);
                graphics.FillRectangle(whiteBrush, 0, 0, bitMap.Width, bitMap.Height);
                graphics.DrawString("*" + barCode + "*", oFont, blackBrush, point);
            }
            using (MemoryStream ms = new MemoryStream())
            {
                bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                byte[] byteImage = ms.ToArray();
                img=byteArrayToImage(byteImage);
                //Convert.ToBase64String(byteImage);
                //imgBarCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
            }
            //plBarCode.Controls.Add(imgBarCode);
            return img;
        }
    }

    public System.Drawing.Image byteArrayToImage(byte[] byteArrayIn)
    {
        MemoryStream ms = new MemoryStream(byteArrayIn);
        System.Drawing.Image returnImage = System.Drawing.Image.FromStream(ms);
        return returnImage;
    }
}