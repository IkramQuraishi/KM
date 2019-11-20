<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Tarufa2.aspx.cs" Inherits="Tarufa2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        hr {
  border:none;
  border-top:1px dotted #f00;
  color:#fff;
  background-color:#fff;
  height:1px;
  width:50%;
}
        body {
                 
                  direction:rtl;
                  font-family:'B Nazanin';
                }
                page[size="A4"] {
                  background: white;
                  width: 21cm;
                  height: 29.7cm;
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
        #tblEmployees {
            border:1px solid black ;
        }
        td {
            border:1px solid black;
            text-align:center;
            font-size:11px;

        }
        th {
             border:1px solid black;
            text-align:center;
            font-size:12px;
        }
                    .rotate {
               -webkit-transform: rotate(-90deg); 
                -moz-transform: rotate(-90deg);   
            }

                    .verticalTableHeader {
    text-align:center;
    white-space:nowrap;
    transform: rotate(90deg);

}
    </style>
</head>
<body>

    <form id="form1" runat="server">
    <div>
                <asp:ListView runat="server" ID="lstTarufa" 
                        DataSourceID="dsTarufa" 
                        DataKeyNames="ID">
                      <LayoutTemplate>
                        <table runat="server" id="tblEmployees"
                            style="width:100%;border-collapse: collapse; border-spacing: 0;">
                          <tr runat="server" id="itemPlaceholder">
                          </tr>
                        </table>
                       <%-- <asp:DataPager runat="server" ID="DataPager" PageSize="3">
                          <Fields>
                            <asp:NumericPagerField
                              ButtonCount="5"
                              PreviousPageText="<--"
                              NextPageText="-->" />
                          </Fields>
                        </asp:DataPager>--%>
                      </LayoutTemplate>
                      <ItemTemplate>
                           <tr>
                           <td colspan="10" style="text-align:right !important; border-bottom:0px !important">شماره مسلسل: <%#Eval("ID") %>
                               <span style="padding-right:35%">
                                   <img src="../images/tarufaLogo.JPG" alt="Alternate Text" style="width:200px; height:60px;" /></span>
                           </td>
                              
                         </tr>
                         <tr>
                           <th colspan="10" style="text-align:right !important;border-top:0px !important">مشخصات تشبث </th>
                         </tr>
                         <tr>
                            <th>اسم</th>
                            <th>ولد/ بنت</th>
                            <th>نمبر تذکره</th>
                            <th>صنف</th>
                            <th>کتگوری</th>
                            <th>ناحيه</th>
                            <th>آدرس</th>
                            <th>تعداد کارمندان</th>
                            <th>فروشات سالانه</th>
                            <th>شماره موبايل</th>
                         </tr>
                          <tr>
                              <td><%#Eval("OwnerName") %></td>
                              <td><%#Eval("FatherName") %></td>
                              <td><%#Eval("Tazkira") %></td>
                              <td><%#Eval("Class") %></td>
                              <td><%#Eval("Category") %></td>
                              <td><%#Eval("District") %></td>
                              <td><%#Eval("Address") %></td>
                              <td><%#Eval("TotalEmp") %></td>
                              <td><%#Eval("AnnualSales") %></td>
                              <td><%#Eval("phone") %></td>

                          </tr>
                          <tr>
                              <td colspan="5" style="border-left:0px !important;border-bottom:0px !important; text-align:right"><strong>تعيين مقدار فيس</strong></td>
                              <td colspan="5" style="border-right:0px !important;border-bottom:0px !important; text-align:right;"><strong>تاريخ:</strong></td>
                          </tr>
                          <tr>
                              <td colspan="10" style="border-top:0px !important;text-align:right">لطفا مبلغ <strong> ــــــــــــ</strong> افغاني را از بابت فيس لوحه <strong> <%#Eval("Class") %> کتگوري</strong>  <strong><%#Eval("category") %> </strong>در حساب شاروالي کابل تاديه نمايد<br /><br /><br />
                                  <span style="text-align:center;padding-right:50%;"><strong>مهر بانک: </strong></span>
                              </td>
                          </tr>
                         
                       </ItemTemplate>
                    </asp:ListView>
        <hr />
        <asp:ListView runat="server" ID="ListView1" 
                        DataSourceID="dsTarufa1" 
                        DataKeyNames="ID">
                      <LayoutTemplate>
                        <table runat="server" id="tblEmployees"
                            style="width:100%;border-collapse: collapse; border-spacing: 0;">
                          <tr runat="server" id="itemPlaceholder">
                          </tr>
                        </table>
                       <%-- <asp:DataPager runat="server" ID="DataPager" PageSize="3">
                          <Fields>
                            <asp:NumericPagerField
                              ButtonCount="5"
                              PreviousPageText="<--"
                              NextPageText="-->" />
                          </Fields>
                        </asp:DataPager>--%>
                      </LayoutTemplate>
                      <ItemTemplate>
                           <tr>
                           <td colspan="10" style="text-align:right !important; border-bottom:0px !important">شماره مسلسل: <%#Eval("ID") %>
                               <span style="padding-right:35%">
                                   <img src="../images/tarufaLogo.JPG" alt="Alternate Text" style="width:200px; height:60px;" /></span>
                           </td>
                              
                         </tr>
                         <tr>
                           <th colspan="10" style="text-align:right !important;border-top:0px !important">مشخصات تشبث </th>
                         </tr>
                         <tr>
                            <th>اسم</th>
                            <th>ولد/ بنت</th>
                            <th>نمبر تذکره</th>
                            <th>صنف</th>
                            <th>کتگوری</th>
                            <th>ناحيه</th>
                            <th>آدرس</th>
                            <th>تعداد کارمندان</th>
                            <th>فروشات سالانه</th>
                            <th>شماره موبايل</th>
                         </tr>
                          <tr>
                              <td><%#Eval("OwnerName") %></td>
                              <td><%#Eval("FatherName") %></td>
                              <td><%#Eval("Tazkira") %></td>
                              <td><%#Eval("Class") %></td>
                              <td><%#Eval("Category") %></td>
                              <td><%#Eval("District") %></td>
                              <td><%#Eval("Address") %></td>
                              <td><%#Eval("TotalEmp") %></td>
                              <td><%#Eval("AnnualSales") %></td>
                              <td><%#Eval("phone") %></td>

                          </tr>
                          <tr>
                              <td colspan="5" style="border-left:0px !important;border-bottom:0px !important; text-align:right"><strong>تعيين مقدار فيس</strong></td>
                              <td colspan="5" style="border-right:0px !important;border-bottom:0px !important; text-align:right;"><strong>تاريخ:</strong></td>
                          </tr>
                          <tr>
                              <td colspan="10" style="border-top:0px !important;text-align:right">لطفا مبلغ <strong> ــــــــــــ</strong> افغاني را از بابت فيس لوحه <strong> <%#Eval("Class") %> کتگوري</strong>  <strong><%#Eval("category") %> </strong>در حساب شاروالي کابل تاديه نمايد<br /><br /><br />
                                  <span style="text-align:center;padding-right:50%;"><strong>مهر بانک: </strong></span>
                              </td>
                          </tr>
                         
                       </ItemTemplate>
                    </asp:ListView>
          <asp:SqlDataSource runat="server" ID="dsTarufa" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="">
                
             </asp:SqlDataSource>
         <asp:SqlDataSource runat="server" ID="dsTarufa1" ConnectionString='<%$ ConnectionStrings:Conn %>'        
                   SelectCommand="">
                
             </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
