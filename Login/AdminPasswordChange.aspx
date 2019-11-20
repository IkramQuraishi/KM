<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="AdminPasswordChange.aspx.cs" Inherits="AdminPasswordChange" %>


<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="ContentPlaceholder2">
     <style>
        .tdh {
            width:180px;
            font-weight:bold;
        }
    </style>
    <h2>تغیر رمز کاربران</h2>
    <br />
     <table class="content-table grid">
        <tr>
            <td class="tdh">اسم کاربر:</td>
            <td><asp:Label runat="server" ID="UserNameLabel"></asp:Label></td>
        </tr>
        <tr>
            <td class="tdh">تاریخ ایجاد:</td>
            <td><asp:Label runat="server" ID="CreationDateLabel"></asp:Label></td>
        </tr>
        <tr>
            <td class="tdh">تاریخ تغیر رمز:</td>
            <td><asp:Label runat="server" ID="LastPasswordChangedDateLabel"></asp:Label></td>
        </tr>
      
        <tr>
            <td class="tdh">رمز جدید:</td>
            <td><asp:TextBox ID="NewPassword1" TextMode="Password" runat="server"></asp:TextBox></td>
        </tr>
        <tr>
            <td class="tdh">تصدیق رمز جدید:</td>
            <td><asp:TextBox ID="NewPassword2" TextMode="Password" runat="server"></asp:TextBox>
                <asp:CompareValidator ID="PwdCompareValidator" runat="server" 
                    ControlToCompare="NewPassword1" ControlToValidate="NewPassword2" 
                    Display="Dynamic" ErrorMessage="The entered password values do not match." Text="*" SetFocusOnError="False"></asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center;">
                <asp:Label ID="StatusMessage" CssClass="Important" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align:center;">
                <asp:Button ID="UpdateUser" runat="server" Text="تغیر نماید" 
                    onclick="UpdateUser_Click" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="CancelUpdate" CausesValidation="false" runat="server" 
                    Text="لغو" onclick="CancelUpdate_Click" />
            </td>
        </tr>
    </table>
</asp:Content>