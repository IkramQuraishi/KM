<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PaymentCategory.aspx.cs" Inherits="PaymentCategory" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI" TagPrefix="asp" %>
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
   <div class="panel-heading">تنظیم فیس اجازه فعالیت صنفی </div>
  <div class="panel-body">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Always"><Triggers><asp:PostBackTrigger ControlID="btnSearch" /><asp:PostBackTrigger ControlID="btnCreate" /></Triggers>
        <ContentTemplate>
                    <table class="table table-responsive">
                        <tr>
                            
                                    <td> گروپ:</td>
                                    <td><asp:DropDownList runat="server" ID="ddlGroup" DataSourceID="dsGroup" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control" AutoPostBack="true"></asp:DropDownList>
                                      <asp:SqlDataSource runat="server" ID="dsGroup" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select * from zBusinessGroup">
                                     </asp:SqlDataSource>
                               </td>
                            </tr>        
                        <tr>
                                    <td>صنف:</td>
                                    <td><asp:DropDownList runat="server" ID="ddlClass" DataSourceID="dsClass" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsClass" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select * from zBusinessClass where businessGroupID=@BusinessGroupID">
                                             <SelectParameters>
                                                 <asp:ControlParameter ControlID="ddlGroup" PropertyName="SelectedValue" Name="BusinessGroupID" ConvertEmptyStringToNull="true" />
                                             </SelectParameters>
                                     </asp:SqlDataSource>
                               </td>
                                </tr>
                                <tr>
                                    <td> کتگوری موقعیت :</td>
                                    <td> <asp:DropDownList runat="server" ID="ddlLocationCategory" DataSourceID="dsLocationCategory" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                  <asp:SqlDataSource runat="server" ID="dsLocationCategory" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select * from zLocationCategory">
                                     </asp:SqlDataSource> </td>
                                </tr>
                                 <tr>
                                    <td> کنگوری تشبث:</td>
                                    <td> <asp:DropDownList runat="server" ID="ddlCategory" DataSourceID="dsCategory" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                 <asp:SqlDataSource runat="server" ID="dsCategory" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select * from zBusinessCategory">
                                     </asp:SqlDataSource> </td>
                                </tr>
                                     <tr>
                                    <td>قیمت جواز صنفی:</td>
                                    <td><input runat="server" placeholder="قیمت جواز صنفی" id="txtPrice" class="form-control"  pattern="[0-9]+([\.][0-9]{0,2})?" title="صرف باید اعداد باشد" /> 
                               </td>
                                </tr>
                             <tr>
                            <td><asp:Button ID="btnCreate" runat="server" OnClick="btnCreate_Click" Text="ثبت نماید"  CssClass="btn btn-warning" /></td>
                                 <td  style="float:left"><asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="جستجو"  CausesValidation="false" CssClass="btn btn-warning" /><asp:Label ID="lblID" runat="server" Text="" Visible="false"></asp:Label>  </td>
                       </tr>
                     </table>
              </ContentTemplate>
          </asp:UpdatePanel>
       </div>
     </div>
 <div class="panel panel-warning">
<div class="panel-heading">تنظیم فیس اجازه فعالیت صنفی</div>
  <div class="panel-body">
      <div class="table-responsive">
     <asp:GridView runat="server" ID="gvGroup" AutoGenerateColumns="False" Width="99%" CssClass="table table-striped table-bordered table-hover"  
         DataSourceID="dsPaymentCategory" EmptyDataText="هیچ صنف موجود نیست" OnRowCommand="gvGroup_RowCommand" AllowPaging="true" PageSize="10" >
           
       <HeaderStyle Height="30px" HorizontalAlign="Center" BackColor="#eccdb0"  />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="شماره" />
                   <asp:TemplateField>
		            <HeaderTemplate>گروپ</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("BusinessGroup") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                 <asp:TemplateField>
		            <HeaderTemplate>صنف</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("Class") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                  <asp:TemplateField>
		            <HeaderTemplate>کتگوری موقعیت  </HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("LocationCategory") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                 <asp:TemplateField>
		            <HeaderTemplate>کتگوری</HeaderTemplate>
		            <ItemTemplate>
                        <%#Eval("Category") %>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                <asp:BoundField DataField="payment" HeaderText="قیمت" />
	            <asp:TemplateField>
		            <HeaderTemplate>اقدامات</HeaderTemplate>
		            <ItemTemplate>
                        <asp:LinkButton ID="lnkEdit" runat="server" CssClass="glyphicon glyphicon-edit" CommandArgument='<%#Eval("ID") %>' CommandName="Ed"></asp:LinkButton>
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="glyphicon glyphicon-remove-sign" CommandArgument='<%#Eval("ID") %>' CommandName="Del" OnClientClick="return confirm('آیا شما مطمین هستیند؟'); "></asp:LinkButton>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                   
            </Columns>

</asp:GridView>
          </div>
    <asp:SqlDataSource runat="server" ID="dsPaymentCategory" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="select c.*,g.Name_local as [BusinessGroup],ct.Name_local as Category,lc.Name_Local as LocationCategory,cls.name_local as Class from PaymentCategory c
inner join zLocationCategory lc on lc.ID=c.LocationCategoryID inner join zBusinessClass cls on cls.ID=c.BusinessClassID inner join zBusinessCategory ct on ct.ID=c.BusinessCategoryID
inner join zBusinessGroup g on g.ID=cls.BusinessGroupID">
     </asp:SqlDataSource>
      
      </div></div>
</asp:Content>

