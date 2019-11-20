<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="TarufaDistributed.aspx.cs" Inherits="TarufaDistributed" EnableEventValidation="false" %>

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
    <h3 style="text-align:center"> راپور تعرفه توزیع و پرداخت </h3>
     <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Always">
        <ContentTemplate>
     <div class="panel panel-warning">
       <div class="panel-heading">جستجو </div>
        <div class="panel-body">
            <div class="row">
                 <div class="col-md-1">ناحیه: </div>

                 <div class="col-md-2"><asp:DropDownList runat="server" ID="ddlDistrict" DataSourceID="dsDistrict" DataTextField="Name_Local" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsDistrict" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,Name_local from zDistrict union select -1,N'--انتخاب--' order by ID">
                                            
                                     </asp:SqlDataSource></div>
                 <div class="col-md-1">نوع تعرفه: </div>
                 <div class="col-md-2"><asp:DropDownList runat="server" ID="ddlPaymentStatus" DataSourceID="dsPaymentStatus" DataTextField="PaymentStatus" DataValueField="ID" CssClass="form-control"></asp:DropDownList>
                                         <asp:SqlDataSource runat="server" ID="dsPaymentStatus" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                                       SelectCommand="Select ID,PaymentStatus from zPaymentStatus union select -1,N'--انتخاب--' order by ID">
                                            
                                     </asp:SqlDataSource></div>
               
                   
                <div class="col-md-2"><input type="text" id="txtFrom" placeholder="از تاریخ " runat="server" class="form-control" /></div>
                  
                <div class="col-md-2"><input type="text" id="txtTo" placeholder="تا تاریخ " runat="server" class="form-control" /></div>
                 <div class="col-md-1"><asp:Button ID="btnSearch" CssClass="btn btn-warning" Text="جستجو" OnClick="btnSearch_Click" runat="server" /> </div>
           </div>
           
        </div>
       </div>
           
    <div class="panel panel-warning">
       <div class="panel-heading"> راپور  </div>
        <div class="panel-body">
            <div class="table-responsive">
               <asp:GridView runat="server" ID="gvGroup" AutoGenerateColumns="False" Width="99%" CssClass="table table-bordered table-hover"  
                   DataSourceID="dsReport" EmptyDataText="هیچ  موجود نیست" ShowFooter="true" OnRowDataBound="gvGroup_RowDataBound" OnRowCommand="gvGroup_RowCommand" >
           
           <HeaderStyle Height="30px" HorizontalAlign="Center" BackColor="#eccdb0"  />
                    <FooterStyle Height="30px"  BackColor="#faebcc" Font-Bold="true"  />
                <Columns>
                  
                     
                    <asp:BoundField DataField="District" HeaderText="ناحیه" />
                    <asp:BoundField DataField="TarufaDist" HeaderText="تعداد تعرفه" />
                   
                   
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

