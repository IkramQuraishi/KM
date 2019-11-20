﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BusinessDetail.aspx.cs" Inherits="BusinessDetail" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" src="../Scripts/PersianDatePicker.min.js"></script>
    <link type="text/css" rel="stylesheet" href="../Content/PersianDatePicker.min.css" />
    <script type="text/javascript">
        var launch = false;
        function launchModal() 
        {
            launch = true;
        }
        function pageLoad() {
            if (launch) {
                $find("mpe").show();
            }
        }
</script>
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
                </ul>
              </li>
                    </ContentTemplate>
                    </asp:RoleGroup>
                </RoleGroups>
                </asp:loginview>
             <li class="active"><a href="Default.aspx">راپور ها</a></li>
            <li><a href="../Business/BusinessPayment.aspx">پرداخت ها</a></li>
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
     <script src="../js/jquery.js" type="text/javascript"></script>
    <script src="../js/bootstrap.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Content" Runat="Server">
    <h3 style="text-align:center"> راپورتفصیلی اصناف </h3>
     <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Always">
        <ContentTemplate>
     <div class="panel panel-warning">
       <div class="panel-heading">جستجو </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-1">کود تشبث: </div>
                <div class="col-md-2"><input id="txtCode" runat="server" class="form-control input-sm" placeholder="کود "/></div>

                         <div class="col-md-1">گروپ: </div>
                 <div class="col-md-2"><asp:DropDownList runat="server" ID="ddlGroup" DataSourceID="dsGroup" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                                      <asp:SqlDataSource runat="server" ID="dsGroup" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_Local from zBusinessGroup union select -1,N'--انتخاب--' order by ID">
                                     </asp:SqlDataSource></div>
                <div class="col-md-1">صنف تشبث: </div>

                 <div class="col-md-2"><asp:DropDownList runat="server" ID="ddlClass" DataSourceID="dsClass" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsClass" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_local from zBusinessClass where businessGroupID=@BusinessGroupID union select -1,N'--انتخاب--' order by ID">
                                             <SelectParameters>
                                                 <asp:ControlParameter ControlID="ddlGroup" PropertyName="SelectedValue" Name="BusinessGroupID" ConvertEmptyStringToNull="true" />
                                             </SelectParameters>
                                     </asp:SqlDataSource></div>
                 <div class="col-md-1">ناحیه: </div>

                 <div class="col-md-2"><asp:DropDownList runat="server" ID="ddlDistrict" DataSourceID="dsDistrict" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsDistrict" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_local from zDistrict union select -1,N'--انتخاب--' order by ID">
                                            
                                     </asp:SqlDataSource></div>
                </div>
             <div class="row">
                       <div class="col-md-1">اسم متتشبث: </div>
                <div class="col-md-2"><input id="txtName" runat="server" class="form-control input-sm" placeholder="اسم  "/></div>
                  <div class="col-md-1">اسم پدر : </div>
                <div class="col-md-2"><input id="txtFName" runat="server" class="form-control input-sm" placeholder="اسم پدر "/></div>
                  <div class="col-md-1">نام تشبث : </div>
                <div class="col-md-2"><input id="txtBusinessName" runat="server" class="form-control input-sm" placeholder="نام تشبث "/></div>
                  <div class="col-md-1">حالت تشبث: </div>

                 <div class="col-md-2"><asp:DropDownList runat="server" ID="ddlBusinessStatus" DataSourceID="dsBusinessStatus" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsBusinessStatus" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_local from zBusinessStatus union select -1,N'--انتخاب--' order by ID">
                                            
                                     </asp:SqlDataSource></div>
              </div>
                <div class="row">
                      
                    <div class="col-md-1">از تاریخ ثبت: </div>
                <div class="col-md-2"><input type="text" id="txtFrom" placeholder="از تاریخ ثبت" runat="server" class="form-control" /></div>
                    <div class="col-md-1">تا تاریخ ثبت: </div>
                <div class="col-md-2"><input type="text" id="txtTo" placeholder="تا تاریخ ثبت" runat="server" class="form-control" /></div>
                 <div class="col-md-1"><asp:Button ID="btnSearch" CssClass="btn btn-warning" Text="جستجو" OnClick="btnSearch_Click" runat="server" /> </div>
            </div>
           
        </div>
       </div>
           
    <div class="panel panel-warning">
       <div class="panel-heading">  لست اصناف </div>
        <div class="panel-body">
            <div class="table-responsive">
               <asp:GridView runat="server" ID="gvGroup" AutoGenerateColumns="False" Width="99%" CssClass="table table-bordered table-hover"  DataSourceID="dsReport" EmptyDataText="هیچ  موجود نیست" AllowPaging="true" PageSize="100" ShowFooter="true" OnRowDataBound="gvGroup_RowDataBound" OnRowCommand="gvGroup_RowCommand" OnPageIndexChanged="gvGroup_PageIndexChanged">
           
           <HeaderStyle Height="30px" HorizontalAlign="Center" BackColor="#eccdb0"  />
                    <FooterStyle Height="30px"  BackColor="#faebcc" Font-Bold="true"  />
                <Columns>
                    <asp:BoundField DataField="Code" HeaderText="کود" />
                    <asp:TemplateField HeaderText="نام تشبث" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnk"  runat="server" CommandName="show" CommandArgument='<%#Eval("ID") %>'><%#Eval("BusinessName") %></asp:LinkButton>
                        </ItemTemplate>

                    </asp:TemplateField>
                    <%--<asp:BoundField DataField="BusinessName" HeaderText="نام تشبث" />--%>
                     <asp:BoundField DataField="OwnerName" HeaderText="اسم متشبث" />
                     <asp:BoundField DataField="FatherName" HeaderText="اسم پدر" />
                    <asp:BoundField DataField="Gender" HeaderText="جنسیت" />
                    <asp:BoundField DataField="Tazkira" HeaderText="نمبر تذکره " />
                    <asp:BoundField DataField="Class" HeaderText="صنف" />
                    <asp:BoundField DataField="Category" HeaderText="کتگوری" />
                    <asp:BoundField DataField="Province" HeaderText="ولابت" />
                    <asp:BoundField DataField="District" HeaderText="ناحیه" />
                    <asp:BoundField DataField="Street" HeaderText="گذر" />
                    <asp:BoundField DataField="Address" HeaderText="آدرس" />
                    <asp:BoundField DataField="ShopNumber" HeaderText="شماره دکان" />
                    <asp:BoundField DataField="Phone" HeaderText="شماره تماس" />
                    <asp:BoundField DataField="ApplicationDate" HeaderText="تاریخ درخواستی" />
                    <asp:BoundField DataField="BusinessStatus" HeaderText="حالت تشبث" />
                    <asp:BoundField DataField="ApprovalStatus" HeaderText="حالت درخواستی" />
                </Columns>

    </asp:GridView>
            </div>
             <asp:SqlDataSource runat="server" ID="dsReport" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="">
                
     </asp:SqlDataSource>
           <asp:Label runat="server" ID="lblID" Text="" Visible="false"></asp:Label>
        </div>
       </div>
    </ContentTemplate>
         </asp:UpdatePanel>
     <div class="row">
                    <div class="col-md-4"> <asp:LinkButton ID="btnPrint" runat="server" CssClass="btn btn-warning" OnClick="btnPrint_Click"><span aria-hidden="true" class="glyphicon glyphicon-print"><span style="font-family:Droid Arabic Naskh,sans-serif">   ایکسپورت  </span></span></asp:LinkButton>
                </div>
         </div> 
    <!--Modal-->
 
</asp:Content>
