<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Assessment.aspx.cs" Inherits="Assessment" %>
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
            <li><a href="BusinessPayment.aspx">پرداخت ها</a></li>
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
                            <asp:RoleGroup Roles="Admin,Verify"><ContentTemplate>
                                    <li><a href="../Business/BusinessToVerify.aspx">تایدی اصناف</a></li>
                             </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                        </asp:loginview>
                 <li><a href="../Business/BusinessClose.aspx">غیر فعال ساختن</a></li>
                  
                </ul>
              </li>
          
            <li><a href="../Default.aspx">صفحه نخست</a></li>
        </LoggedInTemplate>
        
    </asp:loginview>
    <script src="../js/jquery-3.3.1.min.js" type="text/javascript"></script>
    <script src="../js/bootstrap.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Content" Runat="Server">
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


       $(document).ready(function () {
       
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

            $('body').on('keyup', '#ctl00_Content_txtCapital,#ctl00_Content_txtAnnualSales,#ctl00_Content_txtMale,#ctl00_Content_txtFemale', function (e) {
          
           
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
   <h3 class="text-center"> ثبت تشبث (بررسی )</h3>
     <div class="alert alert-success" role="alert" runat="server" visible="false" id="dvMessage">بررسی تشبث ثبت شد</div>
     <div class="alert alert-danger" role="alert" runat="server" visible="false" id="dvError">در اندراج ارقام اشتباه صورت گرفت  </div>
     <ul class="nav nav-pills">
     <li><a href="#" runat="server" id="btnCreate">معلومات ابتدایی</a></li>
      <li class="active"><a href="#">بررسی </a></li>
     
         <li><a href="Payment.aspx">پرداخت فیس اجازه فعالیت صنفی  </a></li>
       <li><a href="BusinessFiles.aspx">فایل ها </a></li>
     
    </ul>
        
    <div class="panel panel-warning">
       <div class="panel-heading"> مشخصات عمومی</div>
        <div class="panel-body">
            <asp:GridView runat="server" ID="gvGroup" AutoGenerateColumns="False" Width="99%" CssClass="table table-bordered table-hover"  DataSourceID="dsPaymentCategory" EmptyDataText="هیچ تشبث موجود نیست">
           
       <HeaderStyle Height="30px" HorizontalAlign="Center" BackColor="#eccdb0"  />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="شماره" />
                   <asp:TemplateField>
		            <HeaderTemplate>کود</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("Code") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                 <asp:TemplateField>
		            <HeaderTemplate>نام فعالیت</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("BusinessName") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                  <asp:TemplateField>
		            <HeaderTemplate> اسم  </HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("OwnerName") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                 <asp:TemplateField>
		            <HeaderTemplate>اسم پدر</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("FatherName") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                <asp:BoundField DataField="District" HeaderText="ناحیه" />
                <asp:BoundField DataField="Class" HeaderText="صنف" />
                <asp:BoundField DataField="Phone" HeaderText="شماره نماس" />
	            
                   
            </Columns>

</asp:GridView>
            <asp:SqlDataSource runat="server" ID="dsPaymentCategory" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="select b.ID, b.Code,b.BusinessName,b.OwnerName,b.fathername,d.name_local as District,c.Name_local as Class,b.phone from business b left outer join zBusinessClass c on c.ID=b.BusinessClassID
left outer join zDistrict d on d.ID=b.DistrictID where b.ID=@BusinessID">
                 <SelectParameters>
                     <asp:SessionParameter SessionField="BusinessID" Name="BusinessID" />
                 </SelectParameters>
             </asp:SqlDataSource>
           </div>
        </div>
    
    <div class="panel panel-warning">
       <div class="panel-heading"> بررسی </div>
        <div class="panel-body">
               <div class="row">
                <div class="col-md-2">تاریخ بررسی: <span style="color:#f00; font-size:1em;">*</span></div>
                <div class="col-md-4"><input type="text" id="txtApplicationDate" placeholder="تاریخ بررسی" runat="server" class="form-control" autocomplete="off" />
                     <asp:CustomValidator ID="CustomValidator6" runat="server" ControlToValidate="txtApplicationDate" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
                <div class="col-md-2">نتیجه بررسی : <span style="color:#f00; font-size:1em;">*</span></div>
                <div class="col-md-4"><asp:DropDownList runat="server" ID="ddlApprovalStatus" DataSourceID="dsClass" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsClass" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_local from zApprovalStatus union select null,N'--انتخاب--' order by ID">
                                            
                                     </asp:SqlDataSource>
               <asp:CustomValidator ID="CustomValidator7" runat="server" ControlToValidate="ddlApprovalStatus" ValidateEmptyText="true" ClientValidationFunction="ValidateDDL"></asp:CustomValidator>
                </div>
              </div>

             <div class="row">
                <div class="col-md-2">ملاحظات: </div>
                <div class="col-md-4"><input id="txtRemarks" runat="server" class="form-control input-sm" placeholder="ملاحظات" autocomplete="off"/>
                </div>
                 <div class="col-md-2">بررسی توسط: </div>
                <div class="col-md-4"><input id="txtApprovedBy" runat="server" class="form-control input-sm" placeholder="بررسی توسط" autocomplete="off"/>
                </div>
               
              </div> 
            <div class="row">
                <div class="col-md-2">سرمایه تشبث(افغانی): <span style="color:#f00; font-size:1em;">*</span></div>
                <div class="col-md-4"><input id="txtCapital" runat="server" class="form-control input-sm" placeholder="سرمایه" autocomplete="off"/>
                     <asp:CustomValidator ID="CustomValidator13" runat="server" ControlToValidate="txtCapital" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
                 <div class="col-md-2">عواید سالانه: </div>
                <div class="col-md-4"><input id="txtAnnualSales" runat="server" class="form-control input-sm" placeholder="عواید سالانه" autocomplete="off"/></div>
               
              </div>
             <div class="row">
                <div class="col-md-2">نعداد کارمند ذکور: <span style="color:#f00; font-size:1em;">*</span></div>
                <div class="col-md-4"><input id="txtMale" runat="server" class="form-control input-sm" placeholder="نعداد کارمند ذکور" autocomplete="off"/>
                     <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtCapital" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
                 <div class="col-md-2">نعداد کارمند اناث: </div>
                <div class="col-md-4"><input id="txtFemale" runat="server" class="form-control input-sm" placeholder="نعداد کارمند اناث" autocomplete="off"/></div>
               
              </div>
             <div class="row">
                <div class="col-md-2">کواردینات X: </div>
                <div class="col-md-4"><input id="txtLat" runat="server" class="form-control input-sm" placeholder="کواردینات X" autocomplete="off"/>
                    <%-- <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="txtCapital" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>--%>
                </div>
                 <div class="col-md-2">کواردینات Y: </div>
                <div class="col-md-4"><input id="txtLong" runat="server" class="form-control input-sm" placeholder="کواردینات Y" autocomplete="off"/></div>
               
              </div>
        </div>
       </div>
       
   
    <div class="row">
                <div class="col-md-4"><asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-warning"  data-toggle="modal" data-target="#myModal"><span aria-hidden="true" class="glyphicon glyphicon-floppy-disk"><span style="font-family:Droid Arabic Naskh,sans-serif">   ثبت نماید  </span></span></asp:LinkButton>
                    <%--<asp:LinkButton ID="btnContinue" runat="server" CssClass="btn btn-warning" OnClick="btnContinue_Click"><span aria-hidden="true" class="glyphicon glyphicon-backward"><span style="font-family:Droid Arabic Naskh,sans-serif">   ثبت وادامه  </span></span></asp:LinkButton>--%>
                    <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-warning" OnClick="btnCancel_Click"><span aria-hidden="true" class="glyphicon glyphicon-remove"><span style="font-family:Droid Arabic Naskh,sans-serif">   لغو  </span></span></asp:LinkButton>
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

