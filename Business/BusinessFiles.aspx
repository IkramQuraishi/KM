<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BusinessFiles.aspx.cs" Inherits="BusinessFiles" %>
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


   </script>
    <h3 class="text-center">ثبت تشبث (پرداخت )</h3>
    
     <ul class="nav nav-pills">
     <li><a href="#" runat="server" id="btnCreate">معلومات ابتدایی</a></li>
      <li><a href="Assessment.aspx">بررسی </a></li>
      <li><a href="Payment.aspx">پرداخت فیس اجازی فعالیت صنفی  </a></li>
       <li class="active"><a href="#">فایل ها </a></li>
     
    </ul>
        
    <div class="panel panel-warning">
       <div class="panel-heading"> مشخصات عمومی تشبث</div>
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
		            <HeaderTemplate> اسم </HeaderTemplate>
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
   <%-- <asp:UpdatePanel ID="updPayment" runat="server" ChildrenAsTriggers="true">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvPayment"  />
        </Triggers>
        <ContentTemplate>--%>

        
            <div class="panel panel-warning">
       <div class="panel-heading"> فایل ها</div>
        <div class="panel-body">
            <asp:GridView runat="server" ID="gvPayment" AutoGenerateColumns="False" Width="99%" CssClass="table table-bordered table-hover"  DataSourceID="dsPayment" EmptyDataText="هیچ پرداخت موجود نیست" OnRowCommand="gvPayment_RowCommand">
           
       <HeaderStyle Height="30px" HorizontalAlign="Center" BackColor="#eccdb0"  />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="شماره" />
                   <asp:TemplateField>
		            <HeaderTemplate>تفصیل فایل</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("Description") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                 <asp:TemplateField>
		            <HeaderTemplate>نام فایل</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("FileName") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                  <asp:TemplateField>
		            <HeaderTemplate>دریافت فایل </HeaderTemplate>
		            <ItemTemplate>
                      <asp:LinkButton ID="filenamelinkbutton" Text="دریافت نماید" CommandArgument='<%# Eval("ID")%>'  CommandName="download" CausesValidation="false"
                          runat="server"  ForeColor="Blue"  ></asp:LinkButton>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                
                <asp:TemplateField>
		            <HeaderTemplate>اقدامات</HeaderTemplate>
		            <ItemTemplate>
                        
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="glyphicon glyphicon-remove-sign" CommandArgument='<%#Eval("ID") %>' CommandName="Del" CausesValidation="false" OnClientClick="return confirm('آیا شما مطمین هستیند؟'); "></asp:LinkButton>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                   
            </Columns>

</asp:GridView>
            <asp:SqlDataSource runat="server" ID="dsPayment" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="select* from businessFile where businessID=@BusinessID">
                 <SelectParameters>
                     <asp:SessionParameter SessionField="BusinessID" Name="BusinessID" />
                 </SelectParameters>
             </asp:SqlDataSource>
            <asp:Label ID="lblID" runat="server" Text="" Visible="false"></asp:Label>
           </div>
        </div>
    
            <div class="panel panel-warning">
       <div class="panel-heading"> فایل جدید</div>
        <div class="panel-body">
               <div class="row">
              
                <div class="col-md-2">تفصیل درباره فایل: <span style="color:#f00; font-size:1em;">*</span> </div>
                <div class="col-md-4"><input type="text" id="txtDescription" placeholder="تفصیل درباره فایل" runat="server" class="form-control" autocomplete="off" />
                     <asp:CustomValidator ID="CustomValidator7" runat="server" ControlToValidate="txtDescription" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
              </div>

             <div class="row">
                <div class="col-md-2">انتخاب فایل: <span style="color:#f00; font-size:1em;">*</span> </div>
                <div class="col-md-4"><asp:FileUpload ID="fuPic" runat="server" CssClass="form-control" />
                     <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="fuPic" ValidateEmptyText="true" ClientValidationFunction="Validate" ></asp:CustomValidator>
                </div>
                
               
              </div> 
           
        </div>
       </div>
       
   
            <div class="row">
                        <div class="col-md-4"><asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-warning"  data-toggle="modal" data-target="#myModal"><span aria-hidden="true" class="glyphicon glyphicon-floppy-disk"><span style="font-family:Droid Arabic Naskh,sans-serif">   ثبت نماید  </span></span></asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-warning" OnClick="btnCancel_Click" CausesValidation="false"><span aria-hidden="true" class="glyphicon glyphicon-remove"><span style="font-family:Droid Arabic Naskh,sans-serif">   لغو  </span></span></asp:LinkButton>
                        </div>
                
                
               
                      </div>
             <%--  </ContentTemplate>
    </asp:UpdatePanel>--%>

            <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;&nbsp;&nbsp;&nbsp;</span></button>
                <h4 class="modal-title" id="myModalLabel">اطمنان</h4>
              </div>
              <div class="modal-body">
              آیا شما میخواهید این فایل را ثبت نماید؟
              </div>
              <div class="modal-footer">
                   <asp:Button ID="Button1" CssClass="btn btn-warning" runat="server" Text="بلی ثبت نماید" OnClick="btnSave_Click"> </asp:Button>
                <button type="button" class="btn btn-default" data-dismiss="modal">نخیر</button>
       
              </div>
            </div>
          </div>
        </div>

         
</asp:Content>

