<%@ Page Title="سیستم دیتابیس برای ثبت دست فروشان" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CartList.aspx.cs" Inherits="CartList" %>
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>.input-group{
    display: inline;
}</style>
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
     <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.1/jquery-ui.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ctl00_Content_txtBusinessName").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json;charset=utf-8",
                        url: "CartList.aspx/GetAutoCompleteData",
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

            $("#ctl00_Content_txtName").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json;charset=utf-8",
                        url: "CartList.aspx/GetOwnerName",
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
                        url: "CartList.aspx/GetOwnerFatherName",
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

            $('body').on('keyup', '#txtCode', function (e) {
          
          
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
     <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Always">
        <ContentTemplate>
     <div class="panel panel-warning">
       <div class="panel-heading">جستجو</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-1">کود: </div>
                <div class="col-md-1"><input id="txtCode" runat="server" class="form-control input-sm" placeholder="کود "/></div>                      
                 <div class="col-md-1">ناحیه: </div>

                 <div class="col-md-2"><asp:DropDownList runat="server" ID="ddlDistrict" DataSourceID="dsDistrict" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsDistrict" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_local from zDistrict union select -1,N'--انتخاب--' order by ID" >
                                            
                                     </asp:SqlDataSource></div>
                 </div>
             <div class="row">
                  <div class="col-md-1">اسم: </div>
                <div class="col-md-1"><input id="txtName" runat="server" class="form-control input-sm" placeholder="اسم  "/></div>
                  <div class="col-md-1">اسم پدر : </div>
                <div class="col-md-2"><input id="txtFName" runat="server" class="form-control input-sm" placeholder="اسم پدر "/></div>
                 <div class="col-md-1">نام فعالیت : </div>
                <div class="col-md-2"><input id="txtBusinessName" runat="server" class="form-control input-sm" placeholder="نام فعالیت "/></div>
                 <div class="col-md-1"><asp:Button ID="btnSearch" CssClass="btn btn-warning" Text="جستجو" OnClick="btnSearch_Click" runat="server" /> </div>
            </div>
           
        </div>
       </div>
           
    <div class="panel panel-warning">
       <div class="panel-heading"> دست فروشان <span style="float:left;"><asp:LinkButton ID="btnNew" runat="server" CssClass="btn btn-warning" OnClick="btnNew_Click"><span aria-hidden="true" class="glyphicon glyphicon-plus"><span style="font-family:Droid Arabic Naskh,sans-serif">   جدید  </span></span></asp:LinkButton></span></div>
        <div class="panel-body">
            <div class="table-responsive">
               <asp:GridView runat="server" ID="gvGroup" AutoGenerateColumns="False" Width="99%" CssClass="table table-bordered table-hover"  DataSourceID="dsPaymentCategory" 
                   EmptyDataText="هیچ دست فروش موجود نیست" OnRowCommand="gvGroup_RowCommand" OnRowDataBound="gvGroup_RowDataBound" AllowPaging="true" PageSize="10" OnPageIndexChanged="gvGroup_PageIndexChanged">
           
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
                    <asp:BoundField DataField="Phone" HeaderText="شماره تماس" />
	                <asp:TemplateField>
		                <HeaderTemplate>اقدامات</HeaderTemplate>
		                <ItemTemplate>
                            <asp:LinkButton ID="lnkEdit" runat="server" CssClass="glyphicon glyphicon-edit" CommandArgument='<%#Eval("ID") %>' CommandName="Ed" Visible="true" ToolTip="تغیر"></asp:LinkButton>
                            <asp:LinkButton ID="lnkDelete" runat="server" CssClass="glyphicon glyphicon-remove-sign" ToolTip="حذف" CommandArgument='<%#Eval("ID") %>' CommandName="Del" OnClientClick="return confirm('آیا شما مطمین هستیند؟'); " Visible="false"></asp:LinkButton>
		                    <asp:LinkButton ID="lnkView" runat="server" CssClass="glyphicon glyphicon-eye-open" ToolTip="تماشا" CommandArgument='<%#Eval("ID") %>' CommandName="View"  CausesValidation="false" Visible="false"></asp:LinkButton>
                        </ItemTemplate>
                    
	                </asp:TemplateField>
                   
                </Columns>

    </asp:GridView>
            </div>
             <asp:SqlDataSource runat="server" ID="dsPaymentCategory" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="">
     </asp:SqlDataSource>
           <asp:Label runat="server" ID="lblID" Text="" Visible="false"></asp:Label>
        </div>
       </div>
    </ContentTemplate>
         </asp:UpdatePanel>
    
</asp:Content>

