<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ViewCart.aspx.cs" Inherits="ViewCart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../Scripts/PersianDatePicker.min.js"></script>
    <link type="text/css" rel="stylesheet" href="../Content/PersianDatePicker.min.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Navigation" Runat="Server">
        <asp:loginview id="loginview1" runat="server">
        <LoggedInTemplate>
            <asp:loginview id="loginview1" runat="server">
            <RoleGroups>
                <asp:RoleGroup Roles="Admin"><ContentTemplate>
             <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">تنظیم کاربری <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="../Login/Register.aspx">ایجاد کاربر جدید</a></li>
                  <li><a href="../Login/Users.aspx">تنظیم کاربران</a></li>
                  <li><a href="../Login/ChangePassword.aspx">تغیر رمز</a></li>
                  
                </ul>
              </li>
           
             
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">تنظیمات <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="../MasterData/BusinessClass.aspx">اصناف</a></li>
                  <li><a href="../MasterData/Category.aspx">کتگوری</a></li>
                  <li><a href="../MasterData/BusinessGroup.aspx">گروپ</a></li>
                  <li><a href="../MasterData/District.aspx">ناحیه</a></li>
                  <li><a href="../MasterData/FeeType.aspx">انوع پرداخت</a></li>
                  <li><a href="../MasterData/PaymentCategory.aspx">کتگوری پرداخت</a></li> <li><a href="../MasterData/DistrictTarget.aspx">هدف تحصیل عواید</a></li>
                     <li><a href="../MasterData/DistrictTarget.aspx">هدف تحصیل عواید</a></li>
                </ul>
              </li>
                    </ContentTemplate>
                    </asp:RoleGroup>
                </RoleGroups>
                </asp:loginview>
             <li><a href="../Reports/Default.aspx">راپور ها</a></li>
              <asp:loginview id="loginview5" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Admin,License,Market">
                                <ContentTemplate>
                                       <li><a href="BusinessPayment.aspx">پرداخت ها</a></li>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                        </asp:loginview>
         
            <li class="dropdown active">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">تنظیم اصناف <span class="caret"></span></a>
                <ul class="dropdown-menu">
                   <asp:loginview id="loginview2" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Admin,Verify,License">
                                <ContentTemplate>
                                       <li><a href="../Business/index.aspx">ثبت اصناف</a></li> 
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                        </asp:loginview>
                     <asp:loginview id="loginview4" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Cart">
                                <ContentTemplate>
                                         <li><a href="../Business/CartList.aspx">ثبت دست فروش</a></li>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                        </asp:loginview>
                   
                     <asp:loginview id="loginview3" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Admin,Verify,License"><ContentTemplate>
                                    <li><a href="../Business/BusinessToVerify.aspx">تایدی اصناف</a></li>
                                  <li><a href="../Business/BusinessClose.aspx">غیر فعال ساختن</a></li>
                             </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                        </asp:loginview>
                 
                
                </ul>
              </li>
          
            <li><a href="../Default.aspx">صفحه نخست</a></li>
        </LoggedInTemplate>
        
    </asp:loginview>
     <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="../js/bootstrap.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Content" Runat="Server">
   
   <h3 class="text-center">تفصیل دست فروش</h3>
     
        
    <div class="panel panel-warning">
       <div class="panel-heading"> مشخصات عمومی دست فروش</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-2">کود دست فروش: </div>
                <div class="col-md-4">
                    <asp:Literal ID="lblCode" runat="server" /></div>
                <div class="col-md-2">نام تجارتی دست فروش : </div>
                <div class="col-md-4"> <asp:Literal ID="lblBusinessName"  runat="server" />
                </div>
                <%--<div class="col-md-1"><span style="color:red; font-size:1.3em;">*</span></div>--%>
              </div>
            <div class="row">
                <div class="col-md-2">اسم متشبث: </div>
                <div class="col-md-4"> <asp:Literal ID="lblOwnername" runat="server" />
                </div>
                <div class="col-md-2">اسم پدر متشبث: </div>
                <div class="col-md-4"> <asp:Literal ID="lblFatherName" runat="server" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-2">جنسیت متشبث: </div>
                <div class="col-md-4"> <asp:Literal ID="lblGender" runat="server" />
                </div>
                <div class="col-md-2"> نمبر تذکره : </div>
                <div class="col-md-4"> <asp:Literal ID="lblTazkira" runat="server" />
                </div>
            </div>
            <div class="row">
                <div class="col-md-2">تاریخ راجستر: </div>
                <div class="col-md-4"> <asp:Literal ID="lblApplicationDate" runat="server" />
                </div>
                <div class="col-md-2">عکس متشبث:</div>
                <div class="col-md-4"> <asp:Image ID="Image1" runat="server" Width="150px" ImageUrl="~/images/no_photo.jpg" Height="150px"/></div>
            </div>
           </div>
        </div>
   
   
       
   
     <div class="panel panel-warning" >
       <div class="panel-heading"> آدرس </div>
        <div class="panel-body">
               <div class="row">
                <div class="col-md-2">ولایت: </div>
                <div class="col-md-4"> <asp:Literal ID="lblProvince" runat="server" /></div>
                <div class="col-md-2">ناحیه : </div>
                <div class="col-md-4"> <asp:Literal ID="lblDistrict" runat="server" /></div>
              </div>

             <div class="row">
                <div class="col-md-2">کوجه/سرک: </div>
                <div class="col-md-4"> <asp:Literal ID="lblStreet" runat="server" />
                </div>
                 <div class="col-md-2">ادرس مکمل: </div>
                <div class="col-md-4"> <asp:Literal ID="lblAddress" runat="server" /></div>
               
              </div>
             <div class="row">
                <div class="col-md-2">شماره تماس: </div>
                <div class="col-md-4"> <asp:Literal ID="lblPhone" runat="server" />
                </div>
               
               
              </div>
              <div class="row">
                <div class="col-md-2">کواردینات X: </div>
                <div class="col-md-4"><asp:Literal ID="lblX" runat="server" />
                </div>
                 <div class="col-md-2">کواردینات Y: </div>
                <div class="col-md-4"><asp:Literal ID="lblY" runat="server" /></div>
               
              </div>
           
        </div>
       </div>

    

    
       
    <div class="row">
                <div class="col-md-4"> <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-warning" PostBackUrl="~/Business/CartList.aspx"><span aria-hidden="true" class="glyphicon glyphicon-backward"><span style="font-family:Droid Arabic Naskh,sans-serif">   پس به لست دست فروشان  </span></span></asp:LinkButton>
                </div>
                
                
               
              </div>
    
</asp:Content>

