<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BusinessClose.aspx.cs" Inherits="BusinessClose" %>
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
    <h3 class="text-center">غیر فعال سازی تشبث </h3>
    
     <div class="panel panel-warning">
       <div class="panel-heading">جستجو تشبث</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-2">جستجو بر اساس: </div>
                <div class="col-md-2"><asp:DropDownList ID="ddlSearch" runat="server" CssClass="form-control">
                    <asp:ListItem Value="1" Text="کود تشبث"></asp:ListItem>
                    <asp:ListItem Value="2" Text="شماره تذکره"></asp:ListItem>
                    <asp:ListItem Value="3" Text="نام تشبث"></asp:ListItem>                </asp:DropDownList></div>
                   
                    <div class="col-md-2"> <input id="txtSearch" runat="server" class="form-control input-sm" placeholder="واژه جستجو "/></div>
                
                        
                 <div class="col-md-1"><asp:Button ID="btnSearch" CssClass="btn btn-warning" Text="جستجو" OnClick="btnSearch_Click" runat="server" CausesValidation="false" /> </div>
            </div>
           
        </div>
       </div>
      
        
    <div class="panel panel-warning">
       <div class="panel-heading"> مشخصات عمومی تشبث</div>
        <div class="panel-body">
            <div class="table-responsive">
            <asp:GridView runat="server" ID="gvGroup" AutoGenerateColumns="False" Width="99%" CssClass="table table-bordered table-hover"  DataSourceID="dsPaymentCategory" EmptyDataText="هیچ تشبث موجود نیست" OnRowCommand="gvGroup_RowCommand" OnRowDataBound="gvGroup_RowDataBound" AllowPaging="true" PageSize="5" OnPageIndexChanged="gvGroup_PageIndexChanged">
           
       <HeaderStyle Height="30px" HorizontalAlign="Center" BackColor="#eccdb0"  />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="شماره" />
                   <asp:TemplateField>
		            <HeaderTemplate>کود تشبث</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("Code") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                 <asp:TemplateField>
		            <HeaderTemplate>اسم تشبث</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("BusinessName") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                  <asp:TemplateField>
		            <HeaderTemplate> اسم متشبث </HeaderTemplate>
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
              
                <asp:BoundField DataField="Phone" HeaderText="شماره تماس" />
                   <asp:BoundField DataField="Category" HeaderText="حالت فعلی" />
                 <asp:BoundField DataField="CloseDate" HeaderText="تاریخ بسته شدن" />
                <asp:BoundField DataField="CloseReason" HeaderText="سبب بسته شدن" />
                <asp:TemplateField>
		            <HeaderTemplate>اقدامات</HeaderTemplate>
		            <ItemTemplate>
                      
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="glyphicon glyphicon-remove-sign" CommandArgument='<%#Eval("ID")+ ";" +Eval("catID") %>' CommandName="Del"  CausesValidation="false" OnClick="lnkDelete_Click"></asp:LinkButton>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
	         
                   
            </Columns>

</asp:GridView>
            </div>
            <asp:SqlDataSource runat="server" ID="dsPaymentCategory" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="">
               
             </asp:SqlDataSource>
           </div>
        </div>
   
    <asp:Panel class="panel-group" id="pnl" runat="server" Visible="false">
 

            <div class="panel panel-warning">
                   <div class="panel-heading">  غیر فعال سازی تشبث </div>
                    <div class="panel-body">
                           <div class="row">
                            <div class="col-md-2">تاریخ بسته شدن: </div>
                            <div class="col-md-4"><input type="text" id="txtApplicationDate" placeholder="تاریخ بسته شدن" runat="server" class="form-control" autocomplete="off"/>
                                 <asp:CustomValidator ID="CustomValidator6" runat="server" ControlToValidate="txtApplicationDate" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                            </div>
                           <div class="col-md-2">سبب بسته شدن: </div>
                            <div class="col-md-4"><input id="txtReceipt" runat="server" class="form-control input-sm" placeholder="سبب بسته شدن" autocomplete="off"/>
                                 <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="txtReceipt" ValidateEmptyText="true" ClientValidationFunction="ValidateDDL"></asp:CustomValidator>
                            </div>
                          </div>
                          <div class="row">
                                    <div class="col-md-4"><asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-warning" OnClick="btnSave_Click"><span aria-hidden="true" class="glyphicon glyphicon-floppy-disk"><span style="font-family:Droid Arabic Naskh,sans-serif">   غیر فعال نمایید  </span></span></asp:LinkButton>
                                        <%--<asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-warning" OnClick="btnCancel_Click" CausesValidation="false"><span aria-hidden="true" class="glyphicon glyphicon-remove"><span style="font-family:Droid Arabic Naskh,sans-serif">   لغو  </span></span></asp:LinkButton>--%>
                                    </div>
                
                
               
                                  </div>

                    </div>
             </div>

          
             
            
  </asp:Panel>

         
</asp:Content>

