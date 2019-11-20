<%@ Page Title="Register" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="EditUsers.aspx.cs" Inherits="EditUsers" %>

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
                     <asp:loginview id="loginview3" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Admin,verify"><ContentTemplate>
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
      <h4>وظایف</h4>
<asp:CheckBoxList ID="UserRoles" runat="server"  CssClass="ui-icon-circle-check" />
   
    <h4>معلومات حساب</h4>
<asp:DetailsView AutoGenerateRows="False" DataSourceID="MemberData"  CssClass="table table-bordered" OnItemCommand="UserInfo_ItemCommand"
  ID="UserInfo" runat="server" OnItemUpdating="UserInfo_ItemUpdating" ondatabound="UserInfo_DataBound">
  
    <AlternatingRowStyle BackColor="White"/>
    <CommandRowStyle  Font-Bold="True" />
    <EditRowStyle BackColor="White" />
    <FieldHeaderStyle BackColor="#f4f4ff"  />
  
<Fields>
	<asp:BoundField DataField="UserName" HeaderText="اسم کاربری" ReadOnly="True" HeaderStyle-CssClass="detailheader" ItemStyle-CssClass="detailitem">
<HeaderStyle CssClass="detailheader"></HeaderStyle>

<ItemStyle CssClass="detailitem"></ItemStyle>
	</asp:BoundField>
	<asp:BoundField DataField="Email" HeaderText="ایمیل" HeaderStyle-CssClass="detailheader" ItemStyle-CssClass="detailitem">
<HeaderStyle CssClass="detailheader"></HeaderStyle>

<ItemStyle CssClass="detailitem"></ItemStyle>
    </asp:BoundField>
	
	<asp:CheckBoxField DataField="IsApproved" HeaderText="فعال" 
        HeaderStyle-CssClass="detailheader" ItemStyle-CssClass="detailitem" >
<HeaderStyle CssClass="detailheader"></HeaderStyle>

<ItemStyle CssClass="detailitem"></ItemStyle>
    </asp:CheckBoxField>
	<%--<asp:CheckBoxField DataField="IsLockedOut" HeaderText="آیا قفل هست" 
        ReadOnly="true" HeaderStyle-CssClass="detailheader" 
        ItemStyle-CssClass="detailitem" >
	
<HeaderStyle CssClass="detailheader"></HeaderStyle>

<ItemStyle CssClass="detailitem"></ItemStyle>
    </asp:CheckBoxField>--%>
	
	
	
	<asp:TemplateField HeaderText="ناحیه">
        <EditItemTemplate>
            <asp:DropDownList ID="DDLAgency" runat="server" DataSourceID="dsAgency"  
                DataTextField="Name" DataValueField="ID">
            </asp:DropDownList>
            <asp:SqlDataSource ID="dsAgency" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
                SelectCommand="SELECT [ID], [Name_local] as Name FROM [zdistrict] union select -1,'--Select--'"></asp:SqlDataSource>
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="lbAgency" runat="server"></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>

	
	<asp:TemplateField HeaderText="ولایت">
        <EditItemTemplate>
            <asp:DropDownList ID="ddlLocation" runat="server" DataSourceID="dsLocation" 
                DataTextField="Name" DataValueField="ID">
            </asp:DropDownList>
            <asp:SqlDataSource ID="dsLocation" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
                SelectCommand="SELECT [ID], Name_local as Name FROM [zProvince] union select -1,'--Select--' order by ID"></asp:SqlDataSource>
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="lblLocation" runat="server" Text=""></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
<%--	<asp:TemplateField HeaderText="Employee">
        <EditItemTemplate>
            <asp:DropDownList ID="ddlEmployee" runat="server">
            </asp:DropDownList>
            
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="lblEmp" runat="server"></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>--%>
	
    <asp:CommandField ButtonType="button" ShowEditButton="true" EditText="تغیر حساب" UpdateText="ثبت کنید" CancelText="لغو" />
    <asp:ButtonField ButtonType="Button" CommandName="Delete" Text="حذف کنید" />
</Fields>
    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#5D7B9D" ForeColor="White" />
    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
</asp:DetailsView>
 <p class="submitButton">
 <%--<asp:Button ID="Button1" runat="server" Text="Unlock" OnClick="UnlockUser" OnClientClick="return confirm('Click OK to unlock this user.')" />
&nbsp;&nbsp;&nbsp;--%>
<%--<asp:Button ID="Button2" runat="server" Text="حذف کردن" OnClick="DeleteUser" OnClientClick="return confirm('Are Your Sure?')" />
</p>  --%>
<asp:ObjectDataSource ID="MemberData" runat="server" DataObjectTypeName="System.Web.Security.MembershipUser" SelectMethod="GetUser" UpdateMethod="UpdateUser" TypeName="System.Web.Security.Membership">
	<SelectParameters>
		<asp:QueryStringParameter Name="username" QueryStringField="username" />
	</SelectParameters>
</asp:ObjectDataSource> 
<asp:Literal ID="UserUpdateMessage" runat="server" >&nbsp;</asp:Literal>
</asp:Content>