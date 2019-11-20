using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;


public partial class Index : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {


        }
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Captcha1.ValidateCaptcha(txtcaptcha.Value.Trim());
        if (Captcha1.UserValidated)
        {

            string sub = "شکابت" + " از طرف " + txtName.Value + "-" + txtPhone.Value;
            string body = txtmessage.Value;
            if (SendingMail("km.complaints@gmail.com", "km.complaints@gmail.com", sub, body))
            
            {
                System.Windows.Forms.MessageBox.Show("شکابت شما ارسال گردید");
                txtmessage.Value = "";
                txtName.Value = "";
                txtPhone.Value = "";
                txtcaptcha.Value = "";
            }

        }
        else
        {

            System.Windows.Forms.MessageBox.Show("شکابت شما ارسال نه گردید");

        }
    }
    public static Boolean SendingMail(string From, string To, string Subject, string Body)
    {

        try
        {
            
            

            MailMessage m = new MailMessage("km.complaints@gmail.com", To);
            
            m.Subject = Subject;
            m.Body = Body;
            m.IsBodyHtml = true;
            m.From = new MailAddress(From);

            m.To.Add(new MailAddress(To));
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.EnableSsl = true;
            smtp.UseDefaultCredentials = true;
            //smtp.Credentials = new System.Net.NetworkCredential("km.complaints@gmail.com", "KabulMuncipality@123");
          
            smtp.Credentials = new System.Net.NetworkCredential("km.complaints@gmail.com", "KabulMuncipality@123");
            smtp.Send(m);
            return true;
            
        }
        catch (Exception ex)
        {
            System.Windows.Forms.MessageBox.Show(ex.Message);
            return false;
        }
    }
}