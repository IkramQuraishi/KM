<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ViewBusiness.aspx.cs" Inherits="ViewBusiness" %>
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
   
   <h3 class="text-center">تفصیل تشبث</h3>
     
        
    <div class="panel panel-warning">
       <div class="panel-heading"> مشخصات عمومی تشبث</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-2">کود تشبث: </div>
                <div class="col-md-4">
                    <asp:Literal ID="lblCode" runat="server" /></div>
                <div class="col-md-2">نام تجارتی تشبث : </div>
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
                <div class="col-md-2">تاریخ درخواستی: </div>
                <div class="col-md-4"> <asp:Literal ID="lblApplicationDate" runat="server" />
                </div>
                <div class="col-md-2">عکس متشبث:</div>
                <div class="col-md-4"> <asp:Image ID="Image1" runat="server" Width="150px" ImageUrl="~/images/no_photo.jpg" Height="150px"/></div>
            </div>
           </div>
        </div>
   
    <div class="panel panel-warning">
       <div class="panel-heading"> گروپ بندی تشبث</div>
        <div class="panel-body">
               <div class="row">
                <div class="col-md-2">گروپ: </div>
                <div class="col-md-4"> <asp:Literal ID="lblGroup" runat="server" />
                </div>
                <div class="col-md-2">صنف تشبث : </div>
                <div class="col-md-4"> <asp:Literal ID="lblClass" runat="server" />
                </div>
              </div>

             <div class="row">
                <div class="col-md-2">کتگوری: </div>
                <div class="col-md-4"> <asp:Literal ID="lblCategory" runat="server" />
                </div>
               
              </div>
        </div>
       </div>
       
   
     <div class="panel panel-warning" >
       <div class="panel-heading"> ادرس تشبث</div>
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
                 <div class="col-md-2">ایمیل آدرس: </div>
                <div class="col-md-4"> <asp:Literal ID="lblEmail" runat="server" /></div>
               
              </div>
             <div class="row">
                <div class="col-md-2">شماره دکان: </div>
                <div class="col-md-4"> <asp:Literal ID="lblShopNumber" runat="server" /></div>
                 <div class="col-md-2">ویب سابت: </div>
                <div class="col-md-4"> <asp:Literal ID="lblWebsite" runat="server" /></div>
               
              </div>
        </div>
       </div>

    <div class="panel panel-warning">
       <div class="panel-heading"> بررسی تشبث</div>
        <div class="panel-body">
               <div class="row">
                <div class="col-md-2">تاریخ بررسی: </div>
                <div class="col-md-4"><asp:Literal ID="lblAssessmentDate" runat="server" />
                </div>
                <div class="col-md-2">نتیجه بررسی : </div>
                <div class="col-md-4"><asp:Literal ID="lblApprovalStatus" runat="server" />
                </div>
              </div>

             <div class="row">
                <div class="col-md-2">ملاحظات: </div>
                <div class="col-md-4"><asp:Literal ID="lblRemarks" runat="server" />
                </div>
                 <div class="col-md-2">بررسی توسط: </div>
                <div class="col-md-4"><asp:Literal ID="lblApprovedBy" runat="server" />
                </div>
               
              </div> 
            <div class="row">
                <div class="col-md-2">سرمایه تشبث(افغانی): </div>
                <div class="col-md-4"><asp:Literal ID="lblCapital" runat="server" />
                </div>
                 <div class="col-md-2">عواید سالانه: </div>
                <div class="col-md-4"><asp:Literal ID="lblAnnualSales" runat="server" /></div>
               
              </div>
             <div class="row">
                <div class="col-md-2">نعداد کارمند ذکور: </div>
                <div class="col-md-4"><asp:Literal ID="lblMale" runat="server" />
                </div>
                 <div class="col-md-2">نعداد کارمند اناث: </div>
                <div class="col-md-4"><asp:Literal ID="lblFemale" runat="server" /></div>
               
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

    <div class="panel panel-warning">
       <div class="panel-heading"> پرداخت ها</div>
        <div class="panel-body">
            <asp:GridView runat="server" ID="gvPayment" AutoGenerateColumns="False" Width="99%" CssClass="table table-bordered table-hover"  DataSourceID="dsPayment" EmptyDataText="هیچ پرداخت موجود نیست" >
           
       <HeaderStyle Height="30px" HorizontalAlign="Center" BackColor="#eccdb0"  />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="شماره" />
                   <asp:TemplateField>
		            <HeaderTemplate>تاریخ پرداخت</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("PaymentDate1") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                 <asp:TemplateField>
		            <HeaderTemplate>نوع پرداخت</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("PaymentType") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                  <asp:TemplateField>
		            <HeaderTemplate>مبلغ پرداخت </HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("Amount") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                 <asp:TemplateField>
		            <HeaderTemplate>شماره رسید</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("Receipt") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
              
                   
            </Columns>

</asp:GridView>
            <asp:SqlDataSource runat="server" ID="dsPayment" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="select p.*,ft.Name_Local as PaymentType,dbo.ToPersianDate(p.paymentDate) as PaymentDate1 from payment p left outer join zFeeType ft on ft.ID=p.FeeTypeID where p.businessID=@BusinessID">
                 <SelectParameters>
                     <asp:SessionParameter SessionField="BusinessID" Name="BusinessID" />
                 </SelectParameters>
             </asp:SqlDataSource>
         
           </div>
        </div>
       
    <div class="row">
                <div class="col-md-4"> <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-warning" PostBackUrl="~/Business/index.aspx"><span aria-hidden="true" class="glyphicon glyphicon-backward"><span style="font-family:Droid Arabic Naskh,sans-serif">   پس به لست تشبسات  </span></span></asp:LinkButton>
                </div>
                
                
               
              </div>
    
</asp:Content>

