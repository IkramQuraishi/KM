<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Create.aspx.cs" Inherits="Business_Create" %>
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
  <script src="../js/jquery-3.1.1.min.js" type="text/javascript"></script>
    <script src="../js/bootstrap.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Content" Runat="Server">
    <script src="../js/Searchable.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        //$('#ddlGroup').searchable({
        //    maxListSize: 200, // if list size are less than maxListSize, show them all
        //    maxMultiMatch: 300, // how many matching entries should be displayed
        //    exactMatch: false, // Exact matching on search
        //    wildcards: true, // Support for wildcard characters (*, ?)
        //    ignoreCase: true, // Ignore case sensitivity
        //    latency: 200, // how many millis to wait until starting search
        //    warnMultiMatch: 'top {0} matches ...',
        //    warnNoMatch: 'no matches ...',
        //    zIndex: 'auto'
        //});


          String.prototype.toEnglishDigits = function () {
                var num_dic = {
                    '۰': '0',
                    '۱': '1',
                    '۲': '2',
                    '۳': '3',
                    '۴': '4',
                    '۵': '5',
                    '۶': '6',
                    '۷': '7',
                    '۸': '8',
                    '۹': '9',
                }

                return parseInt(this.replace(/[۰-۹]/g, function (w) {
                    return num_dic[w]
                }));
            }

       $('body').on('keyup', '#ctl00_Content_txtPhone,#ctl00_Content_txtNID', function (e) {
          
           
                this.value = this.value.replace(/[^0-9-۰-۹]/g, '');

                if (e.which != 9 && e.which != 8) {
                    var value = $(this).val()
                    if (value != "") {
                        $(this).val(value.toEnglishDigits())
                    }
                }
            })

    });

 </script>
   <script type="text/javascript">
      
       function Validate(sender, args) {
           if (document.getElementById(sender.controltovalidate).value != "") {
               args.IsValid = true;
           } else {
               args.IsValid = false;
               document.getElementById(sender.controltovalidate).style.borderColor = "red";
           }
       }

       function ValidateDDL(sender, args) {
           if (document.getElementById(sender.controltovalidate).value != "") {
               args.IsValid = true;
           } else {
               args.IsValid = false;
               document.getElementById(sender.controltovalidate).style.borderColor = "red";
           }
       }
      function SetTarget() {
            document.forms[0].target = "_blank";}

   </script>
   <h3 class="text-center"> ثبت تشبث </h3>
     <div class="alert alert-success" role="alert" runat="server" visible="false" id="dvMessage"> تشبث ثبت شد</div>
     <div class="alert alert-danger" role="alert" runat="server" visible="false" id="dvError">در اندراج ارقام اشتباه صورت گرفت  </div>
     <ul class="nav nav-pills">
      <li class="active"><asp:LinkButton runat="server" CausesValidation="true" PostBackUrl="#" >معلومات ابتدایی </asp:LinkButton></li>
      <li><asp:LinkButton runat="server" PostBackUrl="Assessment.aspx" CausesValidation="true">بررسی</asp:LinkButton></li>
      <li><asp:LinkButton runat="server" PostBackUrl="Payment.aspx" CausesValidation="true">پرداخت فیس اجازه فعالیت صنفی </asp:LinkButton></li>
       <li><asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="BusinessFiles.aspx" CausesValidation="true">فایل ها </asp:LinkButton></li>
           
    </ul>
        
    <div class="panel panel-warning">
       <div class="panel-heading"> مشخصات عمومی</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-2">کود : <span style="color:#f00; font-size:1em;">*</span></div>
                <div class="col-md-4"><input id="txtCode" runat="server" class="form-control input-sm" placeholder="کود" readonly="true" />
                    <input id="txtID" runat="server" type="hidden" />
                   
                </div>
                <div class="col-md-2">نام تجارتی : <span style="color:#f00; font-size:1em;">*</span> </div>
                <div class="col-md-4"><input id="txtEName" runat="server" class="form-control input-sm" placeholder="نام تجارتی " autocomplete="off"/>
                    <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="txtEName" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
                <%--<div class="col-md-1"><span style="color:red; font-size:1.3em;">*</span></div>--%>
              </div>
            <div class="row">
                <div class="col-md-2">اسم:<span style="color:#f00; font-size:1em;">*</span> </div>
                <div class="col-md-4"><input id="txtOwnerName" runat="server" class="form-control input-sm" placeholder="اسم " autocomplete="off" />
                    <asp:CustomValidator ID="CustomValidator3" runat="server" ControlToValidate="txtOwnerName" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
                <div class="col-md-2">اسم پدر : <span style="color:#f00; font-size:1em;">*</span></div>
                <div class="col-md-4"><input id="txtFatherName" runat="server" class="form-control input-sm" placeholder="اسم پدر" autocomplete="off" />
                     <asp:CustomValidator ID="CustomValidator4" runat="server" ControlToValidate="txtFatherName" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
            </div>
            <div class="row">
                <div class="col-md-2">جنسیت: <span style="color:#f00; font-size:1em;">*</span></div>
                <div class="col-md-4"><asp:DropDownList ID="ddlGender" runat="server" DataSourceID="dsGender" DataTextField="Gender" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                    <asp:SqlDataSource ID="dsGender" runat="server" ConnectionString='<%$ConnectionStrings:Conn %>' SelectCommand="Select ID,Name_local as Gender from zGender"></asp:SqlDataSource>
                </div>
                <div class="col-md-2"> نمبر تذکره: <span style="color:#f00; font-size:1em;">*</span></div>
                <div class="col-md-4"><input id="txtNID" runat="server" class="form-control input-sm" placeholder="نمبر تذکره " autocomplete="off" />
                   <%-- <asp:CustomValidator ID="CustomValidator5" runat="server" ControlToValidate="txtNID" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>--%>
                </div>
            </div>
            <div class="row">
                <div class="col-md-2">تاریخ درخواستی: <span style="color:#f00; font-size:1em;">*</span> </div>
                <div class="col-md-4"><input type="text" id="txtApplicationDate" placeholder="تاریخ درخواستی" runat="server" class="form-control" autocomplete="off" />
                     <asp:CustomValidator ID="CustomValidator6" runat="server" ControlToValidate="txtApplicationDate" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
                <div class="col-md-2">عکس : <span style="color:#f00; font-size:1em;">*</span></div>
                <div class="col-md-4"><asp:FileUpload ID="fuPic" runat="server" CssClass="form-control" /><asp:Image ID="Image1" runat="server" Width="150px" Height="150px" Visible="false"/>
                    <%--<asp:CustomValidator ID="CustomValidator12" runat="server" ControlToValidate="fuPic" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>--%></div>
            </div>
           </div>
        </div>
    <asp:UpdatePanel ID="updp" runat="server" ChildrenAsTriggers="true"><Triggers><asp:AsyncPostBackTrigger ControlID="ddlGroup" /></Triggers><ContentTemplate>
    <div class="panel panel-warning">
       <div class="panel-heading"> گروپ بندی </div>
        <div class="panel-body">
               <div class="row">
                <div class="col-md-2">گروپ: <span style="color:#f00; font-size:1em;">*</span> </div>
                <div class="col-md-4"><asp:DropDownList runat="server" ID="ddlGroup" DataSourceID="dsGroup" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control" AutoPostBack="true" CausesValidation="false" OnSelectedIndexChanged="ddlGroup_SelectedIndexChanged"></asp:DropDownList>
                                      <asp:SqlDataSource runat="server" ID="dsGroup" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_Local from zBusinessGroup union select null,N'--انتخاب--' order by ID">
                                      </asp:SqlDataSource>
                                      <asp:CustomValidator ID="CustomValidator8" runat="server" ControlToValidate="ddlClass" ValidateEmptyText="true" ClientValidationFunction="ValidateDDL"></asp:CustomValidator>
                </div>
                <div class="col-md-2">صنف  : <span style="color:#f00; font-size:1em;">*</span> </div>
                <div class="col-md-4"><asp:DropDownList runat="server" ID="ddlClass" DataSourceID="dsClass" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsClass" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                           SelectCommand="Select ID,Name_local from zBusinessClass union select null,N'--انتخاب--' order by ID">
                                             <%--<SelectParameters>
                                                 <asp:ControlParameter ControlID="ddlGroup" PropertyName="SelectedValue" Name="BusinessGroupID" ConvertEmptyStringToNull="true" />
                                             </SelectParameters>--%>
                                     </asp:SqlDataSource>
                     <asp:CustomValidator ID="CustomValidator7" runat="server" ControlToValidate="ddlClass" ValidateEmptyText="true" ClientValidationFunction="ValidateDDL"></asp:CustomValidator>
                </div>
              </div>

             <div class="row">
                <div class="col-md-2">کتگوری: <span style="color:#f00; font-size:1em;">*</span> </div>
                <div class="col-md-4"><asp:DropDownList runat="server" ID="ddlCategory" DataSourceID="dsCategory" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                                      <asp:SqlDataSource runat="server" ID="dsCategory" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_Local from zBusinessCategory union select null,N'--انتخاب--' order by ID">
                                     </asp:SqlDataSource>
                    <asp:CustomValidator ID="CustomValidator9" runat="server" ControlToValidate="ddlCategory" ValidateEmptyText="true" ClientValidationFunction="ValidateDDL"></asp:CustomValidator>
                </div>
                <div class="col-md-4">مساحت دوکان کمتر از شش متر است؟  </div>
                  <div class="col-md-1">
                      <input type="checkbox" runat="server" id="chkLessThan6" />
                  </div>
              </div>
        </div>
       </div>
        </ContentTemplate></asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ><Triggers><asp:AsyncPostBackTrigger ControlID="ddlProvince" /></Triggers><ContentTemplate>
     <div class="panel panel-warning" >
       <div class="panel-heading"> ادرس </div>
        <div class="panel-body">
               <div class="row">
                <div class="col-md-2">ولایت: <span style="color:#f00; font-size:1em;">*</span></div>
                <div class="col-md-4"><asp:DropDownList runat="server" ID="ddlProvince" DataSourceID="dsProvince" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control" ></asp:DropDownList>
                                      <asp:SqlDataSource runat="server" ID="dsProvince" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_Local from zProvince union select null,N'--انتخاب--' order by ID">
                                     </asp:SqlDataSource></div>
                <div class="col-md-2">ناحیه : <span style="color:#f00; font-size:1em;">*</span></div>
                <div class="col-md-4"><asp:DropDownList runat="server" ID="ddlDistrict" DataSourceID="dsDistrict" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsDistrict" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_local from zDistrict  union select null,N'--انتخاب--' order by ID">
                                             <%--<SelectParameters>
                                                 <asp:ControlParameter ControlID="ddlProvince" PropertyName="SelectedValue" Name="ProvinceID" ConvertEmptyStringToNull="true" />
                                             </SelectParameters>--%>
                                     </asp:SqlDataSource><asp:CustomValidator ID="CustomValidator10" runat="server" ControlToValidate="ddlDistrict" ValidateEmptyText="true" ClientValidationFunction="ValidateDDL"></asp:CustomValidator></div>
              </div>

             <div class="row">
                <div class="col-md-2">کوجه/سرک: <span style="color:#f00; font-size:1em;">*</span> </div>
                <div class="col-md-4"><input id="txtStreet" runat="server" class="form-control input-sm" placeholder="کوجه/سرک" autocomplete="off" />
                     <asp:CustomValidator ID="CustomValidator13" runat="server" ControlToValidate="txtStreet" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
                 <div class="col-md-2">ادرس مکمل: </div>
                <div class="col-md-4"><input id="txtAddress" runat="server" class="form-control input-sm" placeholder="ادرس مکمل" autocomplete="off"/>
                    <asp:CustomValidator ID="CustomValidator12" runat="server" ControlToValidate="txtAddress" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
               
              </div>
             <div class="row">
                <div class="col-md-2">شماره تماس:<span style="color:#f00; font-size:1em;">*</span> </div>
                <div class="col-md-4"><input id="txtPhone" runat="server" class="form-control input-sm" placeholder="شماره تماس" autocomplete="off" />
                    <asp:CustomValidator ID="CustomValidator11" runat="server" ControlToValidate="txtPhone" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
                 <div class="col-md-2">ایمیل آدرس: </div>
                <div class="col-md-4"><input id="txtEmail" runat="server" class="form-control input-sm" placeholder="ایمیل آدرس" autocomplete="off"/></div>
               
              </div>
             <div class="row">
                <div class="col-md-2">شماره دکان: </div>
                <div class="col-md-4"><input id="txtShopNumber" runat="server" class="form-control input-sm" placeholder="شماره دکان" autocomplete="off" /></div>
                 <div class="col-md-2">ویب سابت: </div>
                <div class="col-md-4"><input id="txtWebsite" runat="server" class="form-control input-sm" placeholder="ویب سابت"  autocomplete="off"/></div>
               
              </div>
        </div>
       </div>
        </ContentTemplate></asp:UpdatePanel>
    <div class="row">
                <div class="col-md-6"><asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-warning" data-toggle="modal" data-target="#myModal"><span aria-hidden="true" class="glyphicon glyphicon-floppy-disk"><span style="font-family:Droid Arabic Naskh,sans-serif">   ثبت نماید  </span></span></asp:LinkButton>
                    <%--<asp:LinkButton ID="btnContinue" runat="server" CssClass="btn btn-warning" OnClick="btnContinue_Click"><span aria-hidden="true" class="glyphicon glyphicon-backward"><span style="font-family:Droid Arabic Naskh,sans-serif">   ثبت وادامه  </span></span></asp:LinkButton>--%>
                    <asp:LinkButton ID="btnPrint" runat="server" CssClass="btn btn-warning" OnClientClick = "SetTarget();" OnClick="btnPrint_Click" Enabled="false"><span aria-hidden="true" class="glyphicon glyphicon-print"><span style="font-family:Droid Arabic Naskh,sans-serif">   تعرفه  </span></span></asp:LinkButton>
                    <asp:LinkButton ID="btnCancel" runat="server" CausesValidation="false" CssClass="btn btn-warning" OnClick="btnCancel_Click"><span aria-hidden="true" class="glyphicon glyphicon-remove"><span style="font-family:Droid Arabic Naskh,sans-serif">   لغو  </span></span></asp:LinkButton>
                    
                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-warning" OnClick="LinkButton2_Click" ><span aria-hidden="true" class="glyphicon glyphicon-print"><span style="font-family:Droid Arabic Naskh,sans-serif">   پرنت جواز توسط مدیریت تنظیم مارکیت ها  </span></span></asp:LinkButton>
                </div>
                
                
               
              </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;&nbsp;&nbsp;&nbsp;</span></button>
        <h4 class="modal-title" id="myModalLabel">اطمنان</h4>
      </div>
      <div class="modal-body">
      آیا شما میخواهید این تثبث را ثبت نماید؟
      </div>
      <div class="modal-footer">
           <asp:Button ID="Button1" CssClass="btn btn-warning" runat="server" Text="بلی ثبت نماید" OnClick="btnSave_Click"> </asp:Button>
        <button type="button" class="btn btn-default" data-dismiss="modal">نخیر</button>
       
      </div>
    </div>
  </div>
</div>
</asp:Content>

