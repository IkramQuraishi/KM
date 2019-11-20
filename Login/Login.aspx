<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login_Login" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
    <title>وارد شدن کاربر به سیستم - KM </title>
    

	<link href="../css/layout.css" rel="stylesheet"/>

	<script src="../Scripts/modernizr-2.8.3.js"></script>

	<script src="../Scripts/jquery-2.2.1.min.js"></script>
    <script src="../Scripts/jquery-ui-1.10.4.custom.min.js"></script>
    <script src="../Scripts/jquery-migrate-1.2.1.min.js"></script>
    <script src="../Scripts/jquery.unobtrusive-ajax.js"></script>
    <script src="../Scripts/jquery.validate.js"></script>
    <script src="../Scripts/jquery.validate.unobtrusive.js"></script>


	<script src="../Scripts/customScripts.js"></script>
<script src="../Scripts/customElements.js"></script>



</head>
<body class="login">
	<div id="container">
		<div id="wrapper">
			<!--Main Body -->

			<div class="row logo-row">
				<div class="logo col">
					<h1 class="headerLogo">
						<a href="#">

                              <img src="../images/logo.png" alt="KM" title="KM" />
							<span>MOWA</span></a>						
					</h1>
				</div>
				<!-- Topbar -->

				<div class="clearfix"></div>

			</div>
			<!-- row ends -->
			<!-- End Header Wrapper  -->


			<div class="login-wrapper">

				<div class="row">
					<div class="col title-row">
						<h2 class="heading"></h2>
					</div>
				</div>
				<div class="row no-margin">
					<div id="dvError" runat="server" visible="false" class="validation-summary-errors error alert" data-valmsg-summary="true"><ul><li>اسم کاربر یا رمز اشتباه است</li>
</ul></div>		
				</div>
				<div class="login-cont">
					

					<div class="credential">

						

<div class="login-form">
<form id="form1" runat="server">		
       <asp:Login ID="Login1" runat="server" OnAuthenticate="Login1_Authenticate"
            Font-Size="10pt" 
            PasswordRecoveryUrl="#" FailureText="Your Username and Password are not matching, Please try again!" BorderPadding="0" >
            <LabelStyle />
            <LayoutTemplate>
    <div class="row">
			<div class="col">
				اسم کاربر
				
                 <asp:TextBox ID="UserName" runat="server" CssClass="txt-username"></asp:TextBox>
                 
			</div>
		</div>
		<div class="row">
			<div class="col">
				رمز
				<asp:TextBox ID="Password" runat="server" CssClass="text-box single-line password" TextMode="Password" ></asp:TextBox>
                
			</div>
		</div>
		<div class="row submit-row">

			<div class="col">
			
                 <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="ورود" ValidationGroup="Login1" CssClass="btn-login" />
			</div>

		
			
		</div>
                 </LayoutTemplate>
            <FailureTextStyle Font-Size="8pt" />
            <TextBoxStyle  BorderColor="#666666" BorderStyle="Solid" BorderWidth="1px" />
            <TitleTextStyle Font-Bold="True" ForeColor="#333333" />
        </asp:Login>
</form></div>
<script type="text/javascript">
    $(document).ready(function () {
        $('#CaptchaImg').click(function () {
            $(this).attr('src', function () {
                var d = new Date();
                return this.src + '?' + d.getTime();
            });
            return false;

        });
    });
</script>



					</div>
				</div>

			</div>

		</div>
		<!-- end #wrapper -->
		<!-- Footer Starts -->
		<div id="footer">
			<div class="footerCont">
				<div class="clearfix"></div>
				


			</div>

			<!--- fonter cont -->

		</div>
		<!-- end #footer -->

	</div>
	<!-- end #container -->
	<!-- </div> -->
	<noscript>
		<div class="no-script-msg">
			<strong>It appears that your browser has JavaScript disabled.</strong>
			<p>This Website requires your browser to be JavaScript enabled. Please follow the steps below to enable JavaScript.</p>
		</div>
	</noscript>
</body>
</html>
