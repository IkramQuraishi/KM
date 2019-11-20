<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="DistrictTarget.aspx.cs" Inherits="DistrictTarget" %>
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
     <div class="panel panel-warning">
       <div class="panel-heading">جستجو</div>
        <div class="panel-body">
            <div class="row">
                <div class="col-md-1">کود: </div>
                <div class="col-md-1"><input id="txtYearSrc" runat="server" class="form-control input-sm" placeholder="سال "/></div>
             
                  <div class="col-md-1">ناحیه : </div>
            <div class="col-md-2"><asp:DropDownList runat="server" ID="ddlDistrict" DataSourceID="dsDistrict" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsDistrict" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_local from zDistrict union select -1,N'--انتخاب--' order by ID">                                            
                                     </asp:SqlDataSource></div>
                
                 <div class="col-md-1"><asp:Button ID="btnSearch" CssClass="btn btn-warning" Text="جستجو" OnClick="BtnSearch_Click" runat="server" CausesValidation="false"  /> </div>
            </div>
           
        </div>
       </div>  

    
    <div class="panel panel-warning">
   <div class="panel-heading">لست اصناف</div>
  <div class="panel-body">
     <asp:GridView runat="server" ID="gvGroup" AutoGenerateColumns="False" Width="99%" CssClass="table table-bordered table-hover"  DataSourceID="dsDistrictTarget" 
         EmptyDataText="هیچ صنف موجود نیست" OnRowCommand="gvGroup_RowCommand" AllowPaging="true" PageSize="10">
           
       <HeaderStyle Height="30px" HorizontalAlign="Center" BackColor="#eccdb0" />
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="شماره" />
                <asp:BoundField DataField="Year" HeaderText="سال" />
	            <asp:BoundField DataField="District" HeaderText=" ناحیه"  />
                <asp:BoundField DataField="Target" HeaderText=" هدف تحصیل عواید"  />
	            <asp:TemplateField>
		            <HeaderTemplate>اقدامات</HeaderTemplate>
		            <ItemTemplate>
                        <asp:LinkButton ID="lnkEdit" runat="server" CssClass="glyphicon glyphicon-edit" CommandArgument='<%#Eval("ID") %>' CommandName="Ed"></asp:LinkButton>
                        <asp:LinkButton ID="lnkDelete" runat="server" CssClass="glyphicon glyphicon-remove-sign" CommandArgument='<%#Eval("ID") %>' CommandName="Del" OnClientClick="return confirm('آیا شما مطمین هستیند؟'); "></asp:LinkButton>
		            </ItemTemplate>                    
	            </asp:TemplateField>                  
            </Columns>

</asp:GridView>
    <asp:SqlDataSource runat="server" ID="dsDistrictTarget" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="Select t.*,g.Name_local as District from Districttarget t left outer join zDistrict g on g.ID=t.DistrictID ">
     </asp:SqlDataSource>
    
      </div></div>

    <div class="panel panel-warning">
   <div class="panel-heading">تنظیم هدف برای ناحیه</div>
  <div class="panel-body">
    
                    <table class="table table-responsive">
                                <tr>
                                    <td>سال:</td>
                                    <td><input runat="server" placeholder="سال" id="txtYear" class="form-control" /> 
                                        <asp:CustomValidator ID="CustomValidator7" runat="server" ControlToValidate="txtYear" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                               </td>
                                </tr>
                                 <tr>
                                    <td> ناحیه:</td>
                                    <td> <asp:DropDownList runat="server" ID="ddlDistrictNew" DataSourceID="dsDistrict1" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsDistrict1" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_local from zDistrict union select -1,N'--انتخاب--' order by ID">
                                            
                                     </asp:SqlDataSource>
                     <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="ddlDistrictNew" ValidateEmptyText="true" ClientValidationFunction="ValidateDDL"></asp:CustomValidator>
                                </tr>
                        <tr>
                                    <td>هدف:</td>
                                    <td><input runat="server" placeholder="هدف" id="txtTarget" class="form-control"  /> 
                                        <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="txtTarget" ValidateEmptyText="true" ClientValidationFunction="Validate"></asp:CustomValidator>
                               </td>
                                </tr>
                             <tr>
                            <td><asp:Button ID="btnCreate" runat="server" OnClick="btnCreate_Click" Text="ثبت نماید"  CssClass="btn btn-warning" /></td>
                                 <td><asp:Label ID="lblID" runat="server" Text="" Visible="false"></asp:Label></td>
                       </tr>
                     </table>
    </div>
        </div>
</asp:Content>

