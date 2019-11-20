<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BusinessLicense.aspx.cs" Inherits="BusinessLicense" %>
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
             <li class="active"><a href="../Reports/Default.aspx">راپور ها</a></li>
              <asp:loginview id="loginview5" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Admin,License,Market">
                                <ContentTemplate>
                                       <li><a href="BusinessPayment.aspx">پرداخت ها</a></li>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                        </asp:loginview>
         
            <li class="dropdown">
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
      <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/jquery-ui.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ctl00_Content_txtName").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json;charset=utf-8",
                        url: "BusinessLicense.aspx/GetAutoCompleteData",
                        data: "{'Code':'" + document.getElementById('ctl00_Content_txtName').value + "'}",
                        dataType: "json",
                        success: function (data) {
                            response(data.d);
                        },
                        error: function (result) {
                            alert("Error");
                        }
                    });
                }
            });
        });

    </script>
    <h3 class="text-center">جواز فعالیت
    </h3>
    
     <div class="panel panel-warning">
       <div class="panel-heading">جستجو تشبث</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-1">کود تشبث: </div>
                <div class="col-md-2"><input id="txtCode" runat="server" class="form-control input-sm" placeholder="کود "/></div>
                  <div class="col-md-1">اسم تتشبث: </div>
                <div class="col-md-2"> <input id="txtName" runat="server" class="form-control input-sm auto" placeholder="اسم متتشبث  "/>
                   
                </div>
                <%--  <div class="col-md-1">اسم پدر : </div>
                <div class="col-md-2"><input id="txtFName" runat="server" class="form-control input-sm" placeholder="اسم پدر "/></div>
                        --%>
                 <div class="col-md-1"><asp:Button ID="btnSearch" CssClass="btn btn-warning" Text="جستجو" OnClick="btnSearch_Click" runat="server" CausesValidation="false" /> </div>
            </div>
           
        </div>
       </div>
        
    <div class="panel panel-warning">
       <div class="panel-heading"> مشخصات عمومی تشبث</div>
        <div class="panel-body">
            <div class="table-responsive">
            <asp:GridView runat="server" ID="gvGroup" AutoGenerateColumns="False" Width="99%" CssClass="table table-bordered table-hover"  DataSourceID="dsPaymentCategory" EmptyDataText=" هیچ تشبث موجود نیست یافیس خدمات شهری نه پرداخته است">
           
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
                 <asp:BoundField DataField="Category" HeaderText="کتگوری" />
                <asp:BoundField DataField="Phone" HeaderText="شماره تماس" />
	         
                   
            </Columns>

</asp:GridView>
            </div>
            <asp:SqlDataSource runat="server" ID="dsPaymentCategory" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="">
                <%-- <SelectParameters>
                     <asp:Parameter Name="BusinessID" />
                 </SelectParameters>--%>
             </asp:SqlDataSource>
           </div>
        </div>
   
    <div class="panel-group">
    <div class="panel panel-warning">
      <div class="panel-heading">
        <h4 class="panel-title">
          معلومات جواز
        </h4>
      </div>
    
        <div class="panel-body">
    <asp:UpdatePanel ID="updPayment" runat="server" ChildrenAsTriggers="true">
       <%-- <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvPayment"  />
        </Triggers>--%>
        <ContentTemplate>

        
            <div class="table-responsive">
            <asp:GridView runat="server" ID="gvPayment" AutoGenerateColumns="False" Width="99%" CssClass="table table-bordered table-hover"  DataSourceID="dsPayment" EmptyDataText="هیچ جواز موجود نیست" OnRowCommand="gvPayment_RowCommand" OnRowDataBound="gvPayment_RowDataBound">
           
       <HeaderStyle Height="30px" HorizontalAlign="Center" BackColor="#eccdb0"  />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="شماره" />
                   <asp:TemplateField>
		            <HeaderTemplate>تاریخ صدور</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("IssueDate") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                 <asp:TemplateField>
		            <HeaderTemplate>تاریخ اعتبار</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("ExpiryDate") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                  <asp:TemplateField>
		            <HeaderTemplate>حالت فعلی </HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("Status") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                 
                <asp:TemplateField>
		            <HeaderTemplate>اقدامات</HeaderTemplate>
		            <ItemTemplate>
                        <asp:LinkButton ID="lnkPrint" runat="server" CssClass="glyphicon glyphicon-print" CommandArgument='<%#Eval("ID") %>' CommandName="print" CausesValidation="false" Visible="false"></asp:LinkButton>
                      <%--  <asp:LinkButton ID="lnkEdit" runat="server" CssClass="glyphicon glyphicon-edit" CommandArgument='<%#Eval("ID") %>' CommandName="Ed" CausesValidation="false" Visible="false"></asp:LinkButton>--%>
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="glyphicon glyphicon-remove-sign" CommandArgument='<%#Eval("ID") %>' CommandName="Del" OnClientClick="return confirm('آیا شما مطمین هستیند؟');" CausesValidation="false" Visible="false"></asp:LinkButton>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                   
            </Columns>

</asp:GridView>
            </div>
            <asp:SqlDataSource runat="server" ID="dsPayment" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="select bl.ID,dbo.ToPersianDate(bl.IssueDate) as IssueDate,dbo.ToPersianDate(bl.ExpirationDate) as ExpiryDate, s.Name_Local as Status,BusinessID from BusinessLicense bl inner join zcertificateStatus s on s.ID=bl.statusID where bl.businessID=@BusinessID">
                 <SelectParameters>
                     <asp:SessionParameter SessionField="BusinessIDForLicense" Name="BusinessID" />
                 </SelectParameters>
             </asp:SqlDataSource>
            <asp:Label ID="lblID" runat="server" Text="" Visible="false"></asp:Label>
          
    
            <div class="panel panel-warning">
       <div class="panel-heading">  تنطیم جواز </div>
        <div class="panel-body">
               <div class="row">
                <div class="col-md-2">تاریخ صدور: </div>
                <div class="col-md-4"><input type="text" id="txtIssueDate" placeholder="تاریخ صدور" runat="server" class="form-control" autocomplete="off"/>
                     <asp:CustomValidator ID="CustomValidator6" runat="server" ControlToValidate="txtIssueDate" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
                <%--<div class="col-md-2">تاریخ اعتبار : </div>
                <div class="col-md-4"><input type="text" id="txtExpiryDate" placeholder="تاریخ اعتبار" runat="server" class="form-control" autocomplete="off"/>
                     <asp:CustomValidator ID="CustomValidator7" runat="server" ControlToValidate="txtExpiryDate" ValidateEmptyText="true" ClientValidationFunction="ValidateDDL"></asp:CustomValidator>
                </div>--%>
              </div>

            <%-- <div class="row">
                <div class="col-md-2">حالت جواز: </div>
                <div class="col-md-4"><asp:DropDownList runat="server" ID="ddlStatus" DataSourceID="dsClass" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsClass" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_local from zCertificateStatus union select null,N'--انتخاب--' order by ID">
                                     </asp:SqlDataSource>
                </div>
                --%>
              <div class="row">
                        <div class="col-md-4"><asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-warning" OnClick="btnSave_Click"><span aria-hidden="true" class="glyphicon glyphicon-floppy-disk"><span style="font-family:Droid Arabic Naskh,sans-serif">   ثبت نماید  </span></span></asp:LinkButton>
                            <%--<asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-warning" OnClick="btnCancel_Click" CausesValidation="false"><span aria-hidden="true" class="glyphicon glyphicon-remove"><span style="font-family:Droid Arabic Naskh,sans-serif">   لغو  </span></span></asp:LinkButton>--%>
                        </div>
                      </div>
               
              </div> 
           
        </div>
       </div>
       
               </ContentTemplate>
    </asp:UpdatePanel>
            </div>
                    
                 
                </div>
              </div>
            
    <!--Modal-->
         <%--   <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;&nbsp;&nbsp;&nbsp;</span></button>
                <h4 class="modal-title" id="myModalLabel">اطمنان</h4>
              </div>
              <div class="modal-body">
              آیا شما میخواهید این پرداخت را ثبت نماید؟
              </div>
              <div class="modal-footer">
                   <asp:Button ID="Button1" CssClass="btn btn-warning" runat="server" Text="بلی ثبت نماید" OnClick="btnSave_Click"> </asp:Button>
                <button type="button" class="btn btn-default" data-dismiss="modal">نخیر</button>
       
              </div>
            </div>
          </div>
        </div>--%>

         
</asp:Content>

