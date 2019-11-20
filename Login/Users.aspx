<%@ Page Title=" تنظیم کاربران " Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"  CodeFile="Users.aspx.cs" Inherits="Users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Navigation" Runat="Server">
        <asp:loginview id="loginview1" runat="server">
        <LoggedInTemplate>
            <asp:loginview id="loginview1" runat="server">
            <RoleGroups>
                <asp:RoleGroup Roles="Admin"><ContentTemplate>
            <li class="dropdown active">
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
             <li><a href="Reports.aspx">راپور ها</a></li>
            <li><a href="BusinessPayment.aspx">پرداخت ها</a></li>
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
                    <li><a href="../Business/BusinessClose.aspx">غیر فعال ساختن</a></li>
                     <asp:loginview id="loginview3" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Admin,Verify"><ContentTemplate>
                                    <li><a href="../Business/BusinessToVerify.aspx">تایدی اصناف</a></li>
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
  
    <h3> تنظیم کاربران </h3>
  <div class="table-responsive" style="direction:rtl">
    <%-- <div style="border-color:#c6c5c5 !important; border:solid 1px; width:99%; padding-top:10px; padding-bottom:10px;padding-left:7px">--%>
   <asp:GridView runat="server" ID="gvUsers" AutoGenerateColumns="False" Width="99%" CssClass="table table-bordered table-hover" >
           
       <HeaderStyle Height="30px" HorizontalAlign="Center"  />
            <Columns>
	            <asp:TemplateField>
		            <HeaderTemplate>اسم کاربر</HeaderTemplate>
		            <ItemTemplate>
		            <a href="editusers.aspx?username=<%# Eval("UserName") %>"><%# Eval("UserName") %></a>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                  <asp:BoundField DataField="Email" HeaderText="ایمیل" />
	            <asp:BoundField DataField="creationdate" HeaderText="تاریخ ایجاد"  DataFormatString="{0:d}"/>
	            <asp:BoundField DataField="lastlogindate" HeaderText="تاریخ ورود بار آخر" DataFormatString="{0:d}" />
	          
	          
	            <asp:BoundField DataField="isonline" HeaderText="آیا آنلاین هست" />
	            <asp:BoundField DataField="islockedout" HeaderText="آیا قفل هست" />
            </Columns>



</asp:GridView>
      </div>
          <asp:Button ID="CreateUserButton" runat="server"  Text="جدیداً ایجاد کردن"  CssClass="btn btn-warning " PostBackUrl="~/Login/Register.aspx" /> 
        <%-- </div>--%>
    
</asp:Content>