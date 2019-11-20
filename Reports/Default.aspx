<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Reports_Default" %>

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
             <li class=" active"><a href="Default.aspx">راپور ها</a></li>
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
    <h3 class="text-center"> راپورها</h3>
    <div class="panel panel-warning">
       <div class="panel-heading">راپورها</div>
        <div class="panel-body">
            <div class="table-responsive">
             <asp:GridView ID="gvReports" runat="server" CssClass=" table table-hover table-bordered"   AutoGenerateColumns="false" Width="100%" DataSourceID="dsReports">
          
           <Columns>
                <asp:BoundField DataField="ID" HeaderText="ID" Visible="false">
                    <ItemStyle Width="200px"/>
                </asp:BoundField>
               <asp:TemplateField HeaderText="شماره">
                   <ItemTemplate>
                       <%# ((GridViewRow)Container).RowIndex+1 %>
                   </ItemTemplate>

               </asp:TemplateField>
                <asp:BoundField DataField="ReportName_Local" HeaderText="نوع راپور">
                    
                </asp:BoundField>
                <asp:BoundField DataField="ReportDescription_Local" HeaderText="مشخصات راپور">
                    
                </asp:BoundField>
                 <asp:TemplateField>
                <ItemTemplate>
                    <%--<asp:LinkButton ID="lnkDownload" Text ="Generate Report" CommandArgument = '<%# Eval("ID") %>' runat="server" ></asp:LinkButton>--%>
                    <asp:HyperLink ID="lnk" runat="server" NavigateUrl='<%# String.Format("{0}", Eval("path").ToString()) %>' Text="راپور را ببینید"></asp:HyperLink>
                </ItemTemplate>
            </asp:TemplateField>
              
</Columns>
       </asp:GridView>
     <asp:SqlDataSource runat="server" ID="dsReports" ConnectionString='<%$ ConnectionStrings:Conn %>'
                             SelectCommand="Select * FROM Reports" >

     </asp:SqlDataSource>

                </div>
           </div>
        </div>
</asp:Content>

