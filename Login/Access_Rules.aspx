<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Access_Rules.aspx.cs" Inherits="Default2" Title="Access Rules"  %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.IO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<table class="webparts">
<tr>
	<th>Website Access Rules</th>
</tr>
<tr>
	<td class="details" valign="top">
		
        <table>
		<tr>
			<td valign="top" style="padding-right: 30px;">
				<div class="treeview">
				<asp:TreeView runat="server" ID="FolderTree"
					OnSelectedNodeChanged="FolderTree_SelectedNodeChanged">
					<RootNodeStyle ImageUrl="~/images/folder.gif" />
					<ParentNodeStyle ImageUrl="~/images/folder.gif" />
					<LeafNodeStyle ImageUrl="~/images/folder.gif" />
					<SelectedNodeStyle Font-Underline="true" ForeColor="#A21818" />
				</asp:TreeView>
				</div> 
			</td>

			<td valign="top" style="padding-left: 30px; border-left: 1px solid #999;">
			<asp:Panel runat="server" ID="SecurityInfoSection" Visible="false">
				<h2 runat="server" id="TitleOne" class="alert"></h2>
				
				
				
				<asp:GridView runat="server" ID="RulesGrid" AutoGenerateColumns="false"
				CssClass="list" GridLines="none"
				OnRowDataBound="RowDataBound" SkinID="defautGrid"
				>
					<Columns>
						<asp:TemplateField HeaderText="Action">
							<ItemTemplate>
								<%# GetAction((AuthorizationRule)Container.DataItem) %>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Roles">
							<ItemTemplate>
								<%# GetRole((AuthorizationRule)Container.DataItem) %>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="User">
							<ItemTemplate>
								<%# GetUser((AuthorizationRule)Container.DataItem) %>
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Delete Rule">
							<ItemTemplate>
								<asp:Button ID="Button1" runat="server" Text="Delete Rule" CommandArgument="<%# (AuthorizationRule)Container.DataItem %>" OnClick="DeleteRule" OnClientClick="return confirm('Click OK to delete this rule.')" />
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Move Rule">
							<ItemTemplate>
								<asp:Button ID="Button2" runat="server" Text="  Up  " CommandArgument="<%# (AuthorizationRule)Container.DataItem %>" OnClick="MoveUp" />
								<asp:Button ID="Button3" runat="server" Text="Down" CommandArgument="<%# (AuthorizationRule)Container.DataItem %>" OnClick="MoveDown" />
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
				</asp:GridView>

				<br />
				<hr />
				<h2 runat="server" id="TitleTwo" class="alert"></h2>
				<b>Action:</b>
				<asp:RadioButton runat="server" ID="ActionDeny" GroupName="action" 
					Text="Deny" Checked="true" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<asp:RadioButton runat="server" ID="ActionAllow" GroupName="action" 
					Text="Allow" />
				
				<br /><br />
				<b>Rule applies to:</b>
				<br />
				<asp:RadioButton runat="server" ID="ApplyRole" GroupName="applyto"
					Text="This Role:" Checked="true" />
				<asp:DropDownList ID="UserRoles" runat="server" AppendDataBoundItems="true">
				<asp:ListItem>Select Role</asp:ListItem>
				</asp:DropDownList>
				<br />
					
				<asp:RadioButton runat="server" ID="ApplyUser" GroupName="applyto"
					Text="This User:" />
				<asp:DropDownList ID="UserList" runat="server" AppendDataBoundItems="true">
				<asp:ListItem>Select User</asp:ListItem>
				</asp:DropDownList>	
				<br />
				
				
				<asp:RadioButton runat="server" ID="ApplyAllUsers" GroupName="applyto"
					Text="All Users (*)"  />
				<br />
				
				
				<asp:RadioButton runat="server" ID="ApplyAnonUser" GroupName="applyto"
					Text="Anonymous Users (?)"  />
				<br /><br />
				
				<asp:Button ID="Button4" runat="server" Text="Create Rule" OnClick="CreateRule"
					OnClientClick="return confirm('Click OK to create this rule.');" />
					
				<asp:Literal runat="server" ID="RuleCreationError"></asp:Literal>
			</asp:Panel>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

</asp:Content>

