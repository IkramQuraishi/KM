<%@ Page Title="Register" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="Account_Register" %>

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
             <li><a href="../Reports/Default.aspx">راپور ها</a></li>
            <li><a href="../Business/BusinessPayment.aspx">پرداخت ها</a></li>
             <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">تنظیم اصناف <span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="../Business/index.aspx">ثبت اصناف</a></li> <li><a href="../Business/CartList.aspx">ثبت دست فروش</a></li><li><a href="../Business/BusinessClose.aspx">غیر فعال ساختن</a></li>
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
   

    <asp:CreateUserWizard ID="RegisterUser" runat="server" EnableViewState="false" OnCreatedUser="RegisterUser_CreatedUser"  LoginCreatedUser="false">
       
       
        <WizardSteps>
            <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server">
                <ContentTemplate>
                    <h3>
                       ایجاد حساب کاربری
                    </h3>
                    
                  
                    <span class="failureNotification">
                        <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                    </span>

                    <div>
                        <fieldset >
                           
                            <table class="table" >
                                <tr>
                                    <td> <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">اسم کاربری:</asp:Label></td>
                                    <td><asp:TextBox ID="UserName" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName" 
                                     CssClass="failureNotification" ErrorMessage="User Name is required." ToolTip="User Name is Required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td> <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email"> ایمیل ادرس:</asp:Label></td>
                                    <td>  <asp:TextBox ID="Email" runat="server" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email" 
                                     CssClass="failureNotification" ErrorMessage="E-mail is required." ToolTip="Email is Required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator></td>
                                </tr>
                                <tr>
                                    <td> <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password"> رمز :</asp:Label></td>
                                    <td>
                                          <asp:TextBox ID="Password" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password" 
                                     CssClass="failureNotification" ErrorMessage="Password is required." ToolTip="Password is required." 
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword">  تکرار رمز :</asp:Label></td>
                                    <td> <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="ConfirmPassword" CssClass="failureNotification" Display="Dynamic" 
                                     ErrorMessage="Confirm Password is required." ID="ConfirmPasswordRequired" runat="server" 
                                     ToolTip="Confirm Password is required." ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                                     CssClass="failureNotification" Display="Dynamic" ErrorMessage="Passwords are not Matching."
                                     ValidationGroup="RegisterUserValidationGroup">*</asp:CompareValidator></td>
                                </tr>
                            </table>

                        </fieldset>
                        <p class="col-lg-8">
                            <asp:Button ID="CreateUserButton" runat="server" CommandName="MoveNext" Text="ایجاد کنید"  CssClass="btn btn-warning"
                                 ValidationGroup="RegisterUserValidationGroup"/>
                        </p>
                                        <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server"  ForeColor="Red"
                        ValidationGroup="RegisterUserValidationGroup" />
                    </div>
                </ContentTemplate>
                <CustomNavigationTemplate>
                </CustomNavigationTemplate>
            </asp:CreateUserWizardStep>
          <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server" OnActivate="CompleteWizardStep1_Activate">
                <%--  <ContentTemplate>
                    <table border="0" style="font-size: 100%; width: 568px; font-family: Verdana; height: 260px">
                        <tr>
                            <td align="center" colspan="2" style="font-weight: bold; color: white; background-color: #87ac67">
                               Completion Stage</td>
                        </tr>
                        <tr>
                            <td style="text-align: left">
                                &nbsp; Your account has successfully created!</td>
                        </tr>
                        <tr>
                            <td align="right" colspan="2" style="text-align: right">
                                <asp:Button ID="ContinueButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC"
                                    BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="Continue"
                                    Font-Names="Verdana" ForeColor="#284775" PostBackUrl="~/Login/Users.aspx" Text="Continue"
                                    ValidationGroup="RegisterUserValidationGroup" Width="105px" />
                                &nbsp; &nbsp; &nbsp;</td>
                        </tr>
                    </table>
                </ContentTemplate>--%>
            </asp:CompleteWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>
   
</asp:Content>