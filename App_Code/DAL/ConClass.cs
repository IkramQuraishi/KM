using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;
using System.Web.Security;
using System.Globalization;
using System.Security.Cryptography;

public class ConClass: System.Web.UI.Page 
{
    const string passphrase = "password";
    private SqlConnection con;
    private SqlCommand cmd;
    private DataTable dt;
    private SqlDataReader dr;
	public ConClass()
	{
        con = new SqlConnection();
        con.ConnectionString = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;
        if (con.State != ConnectionState.Open)
        {
            con.Open();
        }
        try
        {

        }
        catch (Exception)
        {
            
            throw;
        }
	}
   
    public ConClass(string conString)
    {
        con = new SqlConnection(conString);
    }
    //public DataTable FillGrid()
    //{
    //}
    //public DataTable FillDDL()
    //{
    //}
    public SqlDataReader Selectdr(string q)
    {
        cmd = new SqlCommand();
        cmd.Connection = con;
        if (con.State != ConnectionState.Open)
            con.Open();
        cmd.CommandText = q;
        dr = cmd.ExecuteReader();
        return dr;
    }
    public DataTable Selectdt(string q)
    {
        dt = new DataTable();
        if (con.State != ConnectionState.Open)
            con.Open();
        cmd = new SqlCommand(q, con);
        cmd.CommandTimeout = 0;
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(dt);
        con.Close();
        return dt;
    }
    public object Selectobj(string q)
    {
        object r;
        cmd = new SqlCommand(q, con);
        if (con.State != ConnectionState.Open)
            con.Open();
        r = cmd.ExecuteScalar();
        con.Close();
        return r;
    }
    public void execNonQuery(string q)
    {
        cmd = new SqlCommand(q, con);
        if (con.State != ConnectionState.Open)
            con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public void exeSp(string spname, params SqlParameter[] par)
    {
        cmd = new SqlCommand();
        cmd.Connection = con;
        if (con.State != ConnectionState.Open)
            con.Open();
        foreach (SqlParameter p in par)
        {
            cmd.Parameters.Add(p);
        }
        cmd.CommandText = spname;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.ExecuteNonQuery();
        con.Close();
    }
    public DataTable SelectBySp(string spname, params SqlParameter[] par)
    {
        cmd = new SqlCommand();
        cmd.Connection = con;
        if (con.State != ConnectionState.Open)
            con.Open();
        foreach (SqlParameter p in par)
        {
            cmd.Parameters.Add(p);
        }
        cmd.CommandText = spname;
        cmd.CommandType = CommandType.StoredProcedure;
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(dt);
        return dt;
    }
  

    public static void fillDropdownlist(string textfield, string valuefield, DropDownList ddlList, DataTable dt)
    {
        
            ddlList.DataSource =dt;
            ddlList.DataTextField = textfield;
            ddlList.DataValueField = valuefield;
            ddlList.DataBind();
        
    }

   

  
    public static string EncryptData(string Message)
    {
        byte[] Results;
        System.Text.UTF8Encoding UTF8 = new System.Text.UTF8Encoding();
        MD5CryptoServiceProvider HashProvider = new MD5CryptoServiceProvider();
        byte[] TDESKey = HashProvider.ComputeHash(UTF8.GetBytes(passphrase));
        TripleDESCryptoServiceProvider TDESAlgorithm = new TripleDESCryptoServiceProvider();
        TDESAlgorithm.Key = TDESKey;
        TDESAlgorithm.Mode = CipherMode.ECB;
        TDESAlgorithm.Padding = PaddingMode.PKCS7;
        byte[] DataToEncrypt = UTF8.GetBytes(Message);
        try
        {
            ICryptoTransform Encryptor = TDESAlgorithm.CreateEncryptor();
            Results = Encryptor.TransformFinalBlock(DataToEncrypt, 0, DataToEncrypt.Length);
        }
        finally
        {
            TDESAlgorithm.Clear();
            HashProvider.Clear();
        }
        return Convert.ToBase64String(Results);
    }
    public static string DecryptString(string Message)
    {
        byte[] Results;
        System.Text.UTF8Encoding UTF8 = new System.Text.UTF8Encoding();
        MD5CryptoServiceProvider HashProvider = new MD5CryptoServiceProvider();
        byte[] TDESKey = HashProvider.ComputeHash(UTF8.GetBytes(passphrase));
        TripleDESCryptoServiceProvider TDESAlgorithm = new TripleDESCryptoServiceProvider();
        TDESAlgorithm.Key = TDESKey;
        TDESAlgorithm.Mode = CipherMode.ECB;
        TDESAlgorithm.Padding = PaddingMode.PKCS7;
        byte[] DataToDecrypt = Convert.FromBase64String(Message);
        try
        {
            ICryptoTransform Decryptor = TDESAlgorithm.CreateDecryptor();
            Results = Decryptor.TransformFinalBlock(DataToDecrypt, 0, DataToDecrypt.Length);
        }
        finally
        {
            TDESAlgorithm.Clear();
            HashProvider.Clear();
        }
        return UTF8.GetString(Results);
    }
}