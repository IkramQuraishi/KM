﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FeeType.aspx.cs" Inherits="FeeType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
           
             
            <li class="dropdown active">
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
             <li><a href="../Reports/Default.aspx">راپور ها</a></li>
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
     
    <div class="panel panel-warning">
   <div class="panel-heading">تنظیم نوعیت پرداخت ها</div>
  <div class="panel-body">
    
                    <table class="table table-responsive">
                                <tr>
                                    <td>نوعیت پرداخت (انگلیسی):</td>
                                    <td><input runat="server" placeholder="نوعیت پرداخت در انگلیسی" id="txtName" class="form-control" required="required" /> 
                               </td>
                                </tr>
                                <tr>
                                    <td> نوعیت پرداخت (دری):</td>
                                    <td>  <input id="txtName_Local" runat="server" placeholder="نوعیت پرداخت در دری"  class="form-control" required="required" /> </td>
                                </tr>
                             <tr>
                            <td><asp:Button ID="btnCreate" runat="server" OnClick="btnCreate_Click" Text="ثبت نماید"  CssClass="btn btn-warning" /></td>
                                 <td><asp:Label ID="lblID" runat="server" Text="" Visible="false"></asp:Label></td>
                       </tr>
                     </table>
    </div>
        </div>
    <div class="panel panel-warning">
   <div class="panel-heading">لست نوعیت پرداخت ها</div>
  <div class="panel-body">
     <asp:GridView runat="server" ID="gvGroup" AutoGenerateColumns="False" Width="99%" CssClass="table table-bordered table-hover"  DataSourceID="dsGroup" EmptyDataText="هیچ نوعیت پرداخت موجود نیست" OnRowCommand="gvGroup_RowCommand">
           
       <HeaderStyle Height="30px" HorizontalAlign="Center" BackColor="#eccdb0" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="شماره" />
                <asp:BoundField DataField="Name" HeaderText="نوعیت پرداخت (انگلیسی)" />
	            <asp:BoundField DataField="Name_local" HeaderText=" نوعیت پرداخت (دری)"  />
	           
	            <asp:TemplateField>
		            <HeaderTemplate>اقدامات</HeaderTemplate>
		            <ItemTemplate>
                        <asp:LinkButton ID="lnkEdit" runat="server" CssClass="glyphicon glyphicon-edit" CommandArgument='<%#Eval("ID") %>' CommandName="Ed"></asp:LinkButton>
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="glyphicon glyphicon-remove-sign" CommandArgument='<%#Eval("ID") %>' CommandName="Del" OnClientClick="return confirm('آیا شما مطمین هستیند؟'); "></asp:LinkButton>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                  
            </Columns>

</asp:GridView>
    <asp:SqlDataSource runat="server" ID="dsGroup" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="Select * from zFeeType">
     </asp:SqlDataSource>
      </div></div>
</asp:Content>

