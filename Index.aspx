<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Index.aspx.cs" Inherits="Index" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register Assembly="MSCaptcha" Namespace="MSCaptcha" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/bootstrap.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Navigation" Runat="Server">
        
     <script src="js/jquery.js" type="text/javascript"></script>
    <script src="js/bootstrap.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Content" Runat="Server">
    
   
    
    <br />
    <div class="row">
        <div class="col-md-4">
           <div class="panel panel-warning">
       <div class="panel-heading"> در باره دیتابیس برای ثبت اصناف</div>
        <div class="panel-body">
            <a href="Files/user_manual.pdf" >رهنمود دیتابیس</a>
            </div></div>
        </div>
         <div class="col-md-4">
              <div class="panel panel-warning">
       <div class="panel-heading">فورمه های درخواستی</div>
        <div class="panel-body">
            <ol>
                <li><a href="Files/طرزالعمل پرداخت بل فیس سالانه جواز صنفی.pdf"> طرزالعمل پرداخت بل فیس سالانه جواز صنفی</a></li>
                <li><a href="Files/طرزالعمل تبدیلی جواز صنفی قبلی به سند اجازه فعالیت جدید.pdf">طرزالعمل تبدیلی جواز صنفی قبلی به سند اجازه فعالیت جدید</a> </li>
                <li><a href="Files/طرزالعمل صدور اجازه فعالیت صنفی.pdf"> طرزالعمل صدور اجازه فعالیت صنفی</a></li>
                <li><a href="Files/فورم شماره 1- درخواستی اجازه فعالیت صنفی.pdf">فورم شماره 1- درخواستی اجازه فعالیت صنفی</a></li>
                <li><a href="Files/فورم شماره 2- تبدیلی جواز صنفی قبلی  به سند اجازه فعالیت صنفی جدید.pdf">فورم شماره 2- تبدیلی جواز صنفی قبلی  به سند اجازه فعالیت صنفی جدید</a></li>
               
              
              
            </ol>
            </div></div>
        </div>
        <div class="col-md-4">
             <div class="panel panel-warning">
       <div class="panel-heading">شکایات شما</div>
        <div class="panel-body">
           <div class="row">
              
               <div class="col-md-12"><input runat="server"  id="txtName" class="form-control" placeholder="اسم" autocomplete="off" /></div>
               
           </div>
             <div class="row">
              
               <div class="col-md-12"><input runat="server" id="txtPhone" class="form-control" placeholder="شماره تماس" autocomplete="off" /></div>
               
           </div>
            <div class="row">
                <div class="col-md-12">
                   <textarea id="txtmessage" runat="server" class="form-control" placeholder="شکایت خود را بنویسید"></textarea></div>
            </div>

            <div class="row">
                <div class="col-md-12">
                    <cc1:CaptchaControl ID="Captcha1" runat="server"
                         CaptchaBackgroundNoise="Low" CaptchaLength="5"
                         CaptchaHeight="60" CaptchaWidth="200"
                         CaptchaLineNoise="None" CaptchaMinTimeout="5"
                         CaptchaMaxTimeout="240" FontColor = "#529E00" />
                </div>
            </div>

            <div class="row">
                 <div class="col-md-12">
                     <input runat="server" id="txtcaptcha" class="form-control" placeholder="تایید کردن" autocomplete="off" />

                 </div>
            </div>
             <div class="row">
                <div class="col-md-12">
                   <asp:Button ID="btnSubmit" runat="server" CssClass="btn btn-warning" Text="ارسال نماید" OnClick="btnSubmit_Click" /></div>
            </div>
            </div></div>
        </div>

    </div>

    <div class="row">
        <div class="col-md-4">
            <div class="panel panel-warning">
       <div class="panel-heading"> معلومات مفید برای اصناف</div>
        <div class="panel-body">
                <ol>
                    <li><a href="Files/Business License cost based on category and location.docx" target="_blank">قیمت جواز صنفی به اساس کتگوری </a></li>
                    <li><a href="Chart.aspx">نگاه به ارقام اصناف </a></li>
                   <li><a href="Reports/BusinessByClass.aspx">راپور اصناف به اساس صنف </a></li> 
                    <li><a href="Reports/BusinessByCategory.aspx">راپور اصناف به اساس کتگوری</a></li>  
                    <li><a href="Reports/BusinessByDistrict.aspx"> راپور اصناف به اساس ناحیه</a></li>  
                   
                    <li><a href="Reports/BusinessMap.aspx"> نقشه اصناف</a></li> 
                   
                </ol>
            </div></div>
        </div>
         <div class="col-md-4">
              <div class="panel panel-warning">
       <div class="panel-heading">اعلانات</div>
        <div class="panel-body">
            <ol>
               <li><a href="Files/About DI in Pamir.pdf" target="_blank">  دستاورد های DI/Pamir </a> </li>
            </ol>
            </div></div>
        </div>
        <div class="col-md-4">
             <div class="panel panel-warning">
       <div class="panel-heading">تماس با ما</div>
        <div class="panel-body">
           <h4>155</h4>
            </div></div>
        </div>

    </div>

   
</asp:Content>

