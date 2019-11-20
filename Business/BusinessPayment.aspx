﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BusinessPayment.aspx.cs" Inherits="BusinessPayment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../Scripts/PersianDatePicker.min.js"></script>
    <link type="text/css" rel="stylesheet" href="../Content/PersianDatePicker.min.css" />
     <link href="../css/jquery-ui.css" rel="stylesheet" />      
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Navigation" Runat="Server">
        
    
          <script src="../js/jquery-3.3.1.min.js" type="text/javascript"></script>
          <script src="../js/bootstrap.js" type="text/javascript"></script>
          <script src="../js/jquery-ui.min.js"></script>
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
                  <li><a href="../MasterData/PaymentCategory.aspx">کتگوری پرداخت</a></li> <li><a href="../MasterData/DistrictTarget.aspx">هدف تحصیل عواید</a></li> <li><a href="../MasterData/DistrictTarget.aspx">هدف تحصیل عواید</a></li>
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
                                       <li class="active"><a href="BusinessPayment.aspx">پرداخت ها</a></li>
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
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Content" Runat="Server">
   <script type="text/javascript">
      
       function Validate(sender, args) {
           if (document.getElementById(sender.controltovalidate).value != "" || document.getElementById("ctl00_Content_ddlPaymentStatus").value == "1")  {               
               args.IsValid = true;
               document.getElementById(sender.controltovalidate).style.borderColor =  "rgb(204, 204, 204)"; 
           }
          
           else {
               args.IsValid = false;
               document.getElementById(sender.controltovalidate).style.borderColor = "red";
           }
       }

       function ValidateDDL(sender, args) {
           if (document.getElementById(sender.controltovalidate).value != "") {
               args.IsValid = true;
                document.getElementById(sender.controltovalidate).style.borderColor =  "rgb(204, 204, 204)"; 
           } else {
               args.IsValid = false;
               document.getElementById(sender.controltovalidate).style.borderColor = "red";
           }
       }
       function SetTarget() {
           //console.log('hi');
            document.forms[0].target = "_blank";}

   </script>
    
    <script type="text/javascript">
        
        $(document).ready(function () {
            
            //$("#ctl00_Content_btnSave").hide();
            $("#ctl00_Content_txtCode").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json;charset=utf-8",
                        url: "BusinessPayment.aspx/GetAutoCompleteData",
                        data: "{'Code':'" + document.getElementById('ctl00_Content_txtCode').value + "'}",
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

            $("#ctl00_Content_txtName").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json;charset=utf-8",
                        url: "BusinessPayment.aspx/GetOwnerName",
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

            $("#ctl00_Content_txtFName").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json;charset=utf-8",
                        url: "BusinessPayment.aspx/GetOwnerFatherName",
                        data: "{'Code':'" + document.getElementById('ctl00_Content_txtFName').value + "'}",
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

            $("#ctl00_Content_txtBusinessName").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json;charset=utf-8",
                        url: "BusinessPayment.aspx/GetBusinessName",
                        data: "{'Code':'" + document.getElementById('ctl00_Content_txtBusinessName').value + "'}",
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

            $('body').on('keyup', '#ctl00_Content_txtReceipt', function (e) {
          
           
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
    <h3 class="text-center">پرداخت ها</h3>
  
     <div class="panel panel-warning">
       <div class="panel-heading">جستجو</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-1">کود: </div>
                <div class="col-md-1"><input id="txtCode" runat="server" class="form-control input-sm" placeholder="کود "/></div>
                <div class="col-md-1">نام فعالیت: </div>
                <div class="col-md-2"><input id="txtBusinessName" runat="server" class="form-control input-sm" placeholder="نام فعالیت "/></div>
                 <div class="col-md-1">اسم: </div>
                <div class="col-md-2"><input id="txtName" runat="server" class="form-control input-sm" placeholder="اسم  "/></div>
                  <div class="col-md-1">اسم پدر : </div>
                <div class="col-md-2"><input id="txtFName" runat="server" class="form-control input-sm" placeholder="اسم پدر "/></div>
                        
                 <div class="col-md-1"><asp:Button ID="btnSearch" CssClass="btn btn-warning" Text="جستجو" OnClick="btnSearch_Click" runat="server" CausesValidation="false" /> </div>
            </div>
           
        </div>
       </div>
        
    <div class="panel panel-warning">
       <div class="panel-heading"> مشخصات عمومی</div>
        <div class="panel-body">
            <div class="table-responsive">
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
                 <asp:BoundField DataField="Category" HeaderText="کتگوری" />
                <asp:BoundField DataField="Phone" HeaderText="شماره تماس" />
               
	         
                   
            </Columns>

</asp:GridView>
            </div>
            <asp:SqlDataSource runat="server" ID="dsPaymentCategory" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="">
               <%--  <SelectParameters>
                     <asp:Parameter Name="BusinessID" />
                 </SelectParameters>--%>
             </asp:SqlDataSource>
           </div>
        </div>
   
    <div class="panel-group">
    <div class="panel panel-warning">
      <div class="panel-heading">
        <h4 class="panel-title">
          <a data-toggle="collapse" href="#collapse1">پرداخت ها</a>
        </h4>
      </div>
      <div id="collapse1" class="panel-collapse collapse">
        <div class="panel-body">
    <asp:UpdatePanel ID="updPayment" runat="server" ChildrenAsTriggers="true">
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvPayment"  />
        </Triggers>
        <ContentTemplate>

        
            <div class="table-responsive">
            <asp:GridView runat="server" ID="gvPayment" AutoGenerateColumns="False" Width="99%" CssClass="table table-bordered table-hover"  DataSourceID="dsPayment" EmptyDataText="هیچ پرداخت موجود نیست" OnRowCommand="gvPayment_RowCommand" OnRowDataBound="gvPayment_RowDataBound">
           
       <HeaderStyle Height="30px" HorizontalAlign="Center" BackColor="#eccdb0"  />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="شماره" />
                <asp:TemplateField>
		            <HeaderTemplate>سال</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("YearID") %>
		            </ItemTemplate>                    
	            </asp:TemplateField> 
                  
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
		            <HeaderTemplate>حالت پرداخت</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("Status") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                 <asp:TemplateField>
		            <HeaderTemplate>شماره رسید</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("Receipt") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                <asp:TemplateField>
		            <HeaderTemplate>اقدامات</HeaderTemplate>
		            <ItemTemplate>
                        <asp:LinkButton ID="lnkEdit" runat="server" CssClass="glyphicon glyphicon-edit" CommandArgument='<%#Eval("ID")+","+ Eval("YearID") %>' CommandName="Ed" CausesValidation="false" Visible="false"></asp:LinkButton>
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="glyphicon glyphicon-remove-sign" CommandArgument='<%#Eval("ID")+","+ Eval("YearID") %>' CommandName="Del" OnClientClick="return confirm('آیا شما مطمین هستیند؟');" CausesValidation="false" Visible="false"></asp:LinkButton>
		           <asp:LinkButton ID="btnPrint" runat="server"  OnClientClick = "SetTarget();" CssClass="glyphicon glyphicon-print" CommandArgument='<%#Eval("ID")+","+ Eval("YearID") %>' CommandName="Print" CausesValidation="false" Visible="false"></asp:LinkButton>
                        </ItemTemplate>
                    
	            </asp:TemplateField>
                   
            </Columns>

           </asp:GridView>
            </div>
            <asp:SqlDataSource runat="server" ID="dsPayment" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="select p.*,ps.PaymentStatus as [Status],ft.Name_Local as PaymentType,case when p.paymentDate is not null then dbo.ToPersianDate(p.paymentDate) end as PaymentDate1 from payment p left outer join zFeeType ft on ft.ID=p.FeeTypeID 
left join zPaymentStatus ps on ps.ID=p.PaymentStatusID where p.businessID=@BusinessID">
                 <SelectParameters>
                     <asp:SessionParameter SessionField="BusinessIDForPayment" Name="BusinessID" />
                 </SelectParameters>
             </asp:SqlDataSource>
            <asp:Label ID="lblID" runat="server" Text="" Visible="false"></asp:Label>
          
    
            <div class="panel panel-warning">
       <div class="panel-heading">  تنطیم پرداخت </div>

        <div class="panel-body">
               <div class="row">
                <div class="col-md-2">تاریخ پرداخت: </div>
                <div class="col-md-4"><input type="text" id="txtApplicationDate" placeholder="تاریخ پرداخت" runat="server" class="form-control" autocomplete="off"/>
                     <asp:CustomValidator ID="CustomValidator6" runat="server" ControlToValidate="txtApplicationDate" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
                <div class="col-md-2">نوع پرداخت : </div>
                <div class="col-md-4"><asp:DropDownList runat="server" ID="ddlApprovalStatus" DataSourceID="dsClass" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlApprovalStatus_SelectedIndexChanged"></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsClass" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_local from zfeetype union select null,N'--انتخاب--' order by ID">
                                            
                                     </asp:SqlDataSource>
                     <asp:CustomValidator ID="CustomValidator7" runat="server" ControlToValidate="ddlApprovalStatus" ValidateEmptyText="true" ClientValidationFunction="ValidateDDL"></asp:CustomValidator>
                </div>
              </div>

             <div class="row">
                <div class="col-md-2">مبلع پرداخت: </div>
                <div class="col-md-4"><input id="txtAmount" runat="server" class="form-control input-sm" placeholder="مبلع پرداخت" autocomplete="off" disabled="disabled"/>
                     <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtAmount" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
                 <div class="col-md-2">شماره رسید: </div>
                <div class="col-md-4"><input id="txtReceipt" runat="server" class="form-control input-sm" placeholder="شماره رسید" autocomplete="off"/>
                     <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="txtReceipt" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                </div>
               
              </div> 
              <div class="row">
                   <div class="col-md-2">حالت پرداخت: </div>
                <div class="col-md-4"><asp:DropDownList runat="server" ID="ddlPaymentStatus" DataSourceID="dsPaymentStatus" DataTextField="PaymentStatus" DataValueField="ID" CssClass="form-control" ></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsPaymentStatus" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                      SelectCommand="Select ID,PaymentStatus from zPaymentStatus union select null,N'--انتخاب--' order by ID">
                                            
                     </asp:SqlDataSource>
                     <asp:CustomValidator ID="CustomValidator5" runat="server" ControlToValidate="ddlPaymentStatus" ValidateEmptyText="true" ClientValidationFunction="ValidateDDL"></asp:CustomValidator>
                </div>
                <div class="col-md-2">برای سال: </div>
                <div class="col-md-4"><asp:DropDownList runat="server" ID="ddlYear" DataSourceID="dsYear" DataTextField="Year" DataValueField="ID" CssClass="form-control" ></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsYear" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                      SelectCommand="Select ID,year from zYear">
                                            
                     </asp:SqlDataSource>
                     <asp:CustomValidator ID="CustomValidator3" runat="server" ControlToValidate="ddlYear" ValidateEmptyText="true" ClientValidationFunction="ValidateDDL"></asp:CustomValidator>
                </div>
                 
               
              </div> 
             <div class="row" runat="server" id="dvSpec" visible="false">
                
                 <div class="col-md-2">مشخصات لوحه: </div>
                <div class="col-md-4"><input id="txtSignBoard" runat="server" class="form-control input-sm" placeholder="مشخصات لوحه" autocomplete="off"/>
                     <asp:CustomValidator ID="CustomValidator4" runat="server" ControlToValidate="txtSignBoard" ValidateEmptyText="true" ClientValidationFunction="ValidateDDL" Enabled="false"></asp:CustomValidator>
                </div>
               
              </div> 
           
        </div>
       </div>
       
   
            <div class="row">
                <asp:loginview id="loginview3" runat="server">
                    <RoleGroups>
                        <asp:RoleGroup Roles="Admin,Verify,License"><ContentTemplate>
                                <div class="col-md-4"><asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-warning" OnClick="btnSave_Click"><span aria-hidden="true" class="glyphicon glyphicon-floppy-disk"><span style="font-family:Droid Arabic Naskh,sans-serif">   ثبت نماید  </span></span></asp:LinkButton>
                                    <%--<asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-warning" OnClick="btnCancel_Click" CausesValidation="false"><span aria-hidden="true" class="glyphicon glyphicon-remove"><span style="font-family:Droid Arabic Naskh,sans-serif">   لغو  </span></span></asp:LinkButton>--%>
                                </div>
                            </ContentTemplate>
                        </asp:RoleGroup>
                    </RoleGroups>
                </asp:loginview>
                      
                
                
               
                      </div>
            
            <div class="row">
                    <div class="alert alert-danger" role="alert" runat="server" visible="false" id="dvError">در اندراج ارقام اشتباه صورت گرفت  </div>
                    <div class="alert alert-success" role="alert" runat="server" visible="false" id="dvMessage"> پرداخت ثبت شد</div>
            </div>
               </ContentTemplate>
    </asp:UpdatePanel>
            </div>
                    
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

