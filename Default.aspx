<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="js/jquery-3.1.1.min.js" type="text/javascript"></script>
    <script src="js/bootstrap.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Navigation" Runat="Server">
        <asp:loginview id="loginview1" runat="server">
        <LoggedInTemplate>
            <asp:loginview id="loginview3" runat="server">
            <RoleGroups>
                <asp:RoleGroup Roles="Admin"><ContentTemplate>
             <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">تنظیم کاربری <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="Login/Register.aspx">ایجاد کاربر جدید</a></li>
                  <li><a href="Login/Users.aspx">تنظیم کاربران</a></li>
                  <li><a href="Login/ChangePassword.aspx">تغیر رمز</a></li>
                  
                </ul>
              </li>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">تنظیمات <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="MasterData/BusinessClass.aspx">اصناف</a></li>
                  <li><a href="MasterData/Category.aspx">کتگوری</a></li>
                  <li><a href="MasterData/BusinessGroup.aspx">گروپ</a></li>
                  <li><a href="MasterData/District.aspx">ناحیه</a></li>
                  <li><a href="MasterData/FeeType.aspx">انوع پرداخت</a></li>
                  <li><a href="MasterData/PaymentCategory.aspx">کتگوری پرداخت</a></li>
                        <li><a href="../MasterData/DistrictTarget.aspx">هدف تحصیل عواید</a></li>
                </ul>
              </li>
                    </ContentTemplate>
                    </asp:RoleGroup>
                </RoleGroups>
                </asp:loginview>
             <li><a href="Reports/Default.aspx">راپور ها</a></li>
            <li><a href="Business/BusinessPayment.aspx">پرداخت ها</a></li>
             <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  تنظیم اصناف <span class="caret"></span></a>
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
                     <asp:loginview id="loginview5" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Cart">
                                <ContentTemplate>
                                         <li><a href="../Business/CartList.aspx">ثبت دست فروش</a></li>
                                </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                        </asp:loginview>
                     <asp:loginview id="loginview4" runat="server">
                        <RoleGroups>
                            <asp:RoleGroup Roles="Admin,Verify"><ContentTemplate>
                                    <li><a href="Business/BusinessToVerify.aspx">تایدی اصناف</a></li>
                             </ContentTemplate>
                            </asp:RoleGroup>
                        </RoleGroups>
                        </asp:loginview>
                 <li><a href="Business/BusinessClose.aspx">غیر فعال ساختن</a></li>
                  
                </ul>
              </li>
          
            <li  class="active"><a href="Default.aspx">صفحه نخست</a></li>
        </LoggedInTemplate>
        
    </asp:loginview>
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Content" Runat="Server">
    
   
    <h3 style="text-align:center; font-family:'B Titre'"> نگاه به ارقام و عواید اصناف</h3>
    <br />
    <div class="row">
        <div class="col-md-4">
           <div class="panel panel-warning">
       <div class="panel-heading"> مجموع عواید جمع آوری شده</div>
        <div class="panel-body">
            <asp:Chart ID="chAvgAge" runat="server" Height="280px" Width="330px" Visible = "false" CssClass="chart" >
                    <Legends>
                        <asp:Legend Alignment="Center" Docking="Bottom" IsTextAutoFit="true" Name="Default" LegendStyle="Row"  />
                    </Legends>
                    
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1" BorderWidth="0" >
                        <Position Height="88" Width="100" X="0" Y="0" />
                            </asp:ChartArea>
                        
                    </ChartAreas>
                </asp:Chart>
            </div></div>
        </div>
         <div class="col-md-4">
              <div class="panel panel-warning">
       <div class="panel-heading">تعداد اصناف ثبت شده در سال روان</div>
        <div class="panel-body">
           <asp:Chart ID="chBusiness" runat="server" Height="280px" Width="330px" Visible = "false" CssClass="chart" >
                    <Legends>
                        <asp:Legend Alignment="Center" Docking="Bottom" IsTextAutoFit="true" Name="Default" LegendStyle="Row"  />
                    </Legends>
                    
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1" BorderWidth="0" >
                        <Position Height="88" Width="100" X="0" Y="0" />
                            </asp:ChartArea>
                        
                    </ChartAreas>
                </asp:Chart>
            </div></div>
        </div>
        <div class="col-md-4">
             <div class="panel panel-warning">
       <div class="panel-heading">گروپ بندی اصناف</div>
        <div class="panel-body">
           <asp:Chart ID="chLoanSector" runat="server" Height="280px" Width="330px" Palette="Bright" >                   
                    <Legends>
                        <asp:Legend Alignment="Center" Docking="Top" IsTextAutoFit="true" Name="Default" LegendStyle="Table"   />
                    </Legends>
                    <Series>
                        <asp:Series Name="Default" ChartType="Pie" CustomProperties="PieLabelStyle=Disabled"/>
                    </Series>
                    <ChartAreas>
                        <asp:ChartArea Name="ChartArea1" BorderWidth="0" >
                           
                        </asp:ChartArea>
                    </ChartAreas>  
             </asp:Chart>
            </div></div>
        </div>

    </div>

   
   
</asp:Content>

