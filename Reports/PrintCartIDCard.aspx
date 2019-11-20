<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintCartIDCard.aspx.cs" Inherits="PrintCartIDCard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
         body {
                 
                  direction:rtl;
                  font-family:'B Nazanin';
                }
                page[size="A4"] {
                  background: white;
                  width: 10cm;
                  height: 15cm;
                  display: block;
                  margin: 0 auto;
                  margin-bottom: 0.5cm;
                  box-shadow: 0 0 0.5cm rgba(0,0,0,0.5);
                }
                @media print {
                  body, page[size="A4"] {
                    margin: 0;
                    box-shadow: 0;
                  }
                }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    </div>
    </form>
</body>
</html>
