<%@ Page Title="Users" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="UsersForChangePassword.aspx.cs" Inherits="UsersForChangePassword" %>


    
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="ContentPlaceHolder2">
         <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="quicksearch.js"></script>
<script type="text/javascript">
    $(function () {
        $('.search_textbox').each(function (i) {
            $(this).quicksearch("[id*=gvUsers] tr:not(:has(th))", {
                'testQuery': function (query, txt, row) {
                    return $(row).children(":eq(" + i + ")").text().toLowerCase().indexOf(query[0].toLowerCase()) != -1;
                }
            });
        });
    });


</script>

    <h2>کاربران</h2>
  
    
   <asp:GridView runat="server" ID="gvUsers" AutoGenerateColumns="False" Width="100%" CssClass="content-table grid"  OnDataBound="gvUsers_DataBound">
            <AlternatingRowStyle BackColor="#F7F7F7" />
       <HeaderStyle Height="30px" />
            <Columns>
	            <asp:TemplateField ItemStyle-Width="200px">
		          
		            <ItemTemplate>
		            <a href="AdminPasswordChange.aspx?user=<%# Eval("UserName") %>">تغیر رمز</a>
		            </ItemTemplate>
                    
	            </asp:TemplateField>
                 <asp:BoundField DataField="UserName" HeaderText="اسم کاربر" SortExpression="UserName" />
	            <asp:BoundField DataField="creationdate" HeaderText="تاریخ ایجاد" />
	            <asp:BoundField DataField="lastlogindate" HeaderText="تاریخ آخیرین ورود" />
	    
	            <asp:BoundField DataField="islockedout" HeaderText="آبا قفل هست" />
            </Columns>



</asp:GridView>
       
     


</asp:Content>