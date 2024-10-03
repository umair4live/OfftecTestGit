<!DOCTYPE html>
// THis is umair and I am comgtting my first commit

I am not sidhu mose walacls

<head>
<title>- : RAAZEE Therapeutics : MIS Department : infoSys Portal : </title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="Description"		content="RAAZEE Therapeutics Private Limited, Lahore, Pakistan">
<meta name="Keywords"			content="MIS, Orders & Stock Management System, RAAZEE Therapeutics, Orders, Inventory">
<meta name="viewport"			content= "width=device-width, initial-scale=1.0"> 
<script type="text/javascript" src="ChkInvoice.js"></script>
<script language="JavaScript">
function isNumber(evt) { evt = (evt) ? evt : window.event; var charCode = (evt.which) ? evt.which : evt.keyCode; if (charCode > 31 && (charCode < 48 || charCode > 57)) {return false;} return true;}
</script>
<script>

  function togglePendingUnits(productId) {
    const checkbox = document.getElementById('productCheck' + productId);
    const pendingUnitsField = document.getElementById('disp_unit' + productId);
	const batchNoField = document.getElementById('batch_no' + productId);
	

    const totalUnits = document.getElementById('Tot_Units' + productId).innerHTML; // Replace with the actual total units for the product

    if (checkbox.checked) {
      pendingUnitsField.value = 0;
	  batchNoField.tabIndex = 0;

    } else {
      pendingUnitsField.value = totalUnits;
	  batchNoField.tabIndex = -1;

    }

  }

  // Handle product name or checkbox click
  function handleProductClick(event, productId) {
    const checkbox = document.getElementById('productCheck' + productId);

    // Prevent checkbox click from triggering the event twice
    if (event.target.tagName !== 'INPUT') {
      checkbox.checked = !checkbox.checked; // Toggle checkbox
    }

    // Call the functions to update Batch No tabindex and pending units
    togglePendingUnits(productId);
  }


</script>



<style>
table{
	border: none;
}
</style>

<style>
	.cdatepicker{
width: 105px !important;

	}
	.custom-checkbox {
	  display: inline-block;
	  position: relative;
	  vertical-align: middle;
	}
	
	.custom-checkbox input {
	  display: none; /* Hide the default checkbox */
	}
	
	.custom-checkbox span {
	  width: 18px;  /* Reduced width */
	  height: 18px; /* Reduced height */
	  border: 2px solid #999;
	  display: inline-block;
	  position: relative;
	  cursor: pointer;
	  transition: background-color 0.3s, border-color 0.3s;
	  border-radius: 5px; /* Rounded corners */
	}
	
	.custom-checkbox span:after {
	  content: '\2718';  /* Unicode for cross (✖) */
	  position: absolute;
	  font-size: 12px; /* Smaller icon */
	  left: 50%;
	  top: 50%;
	  transform: translate(-50%, -50%);
	  color: darkred; /* Cross color */
	  transition: color 0.3s;
	}
	
	.custom-checkbox input:checked + span {
	  background-color: #4CAF50; /* Green background when checked */
	  border-color: #4CAF50; /* Green border */
	}
	
	.custom-checkbox input:checked + span:after {
	  content: '\2714'; /* Unicode for tick (✔) */
	  color: white;  /* White tick */
	}
	
	.custom-checkbox input:not(:checked) + span {
	  background-color: #FF6347; /* Reddish-orange for unchecked */
	  border-color: #FF6347;  /* Matching border color */
	}
	
	.custom-checkbox input:not(:checked) + span:after {
	  color: darkred;  /* Cross color for unchecked */
	}
	</style>

</head>

<body  onkeydown="if(event.keyCode==13){event.keyCode=9; return event.keyCode}">
<!-- #include virtual = "includes/loading.asp"-->
<!-- #include virtual = "includes/header-mini.asp"-->
<center>
<!-------------------------------- PAGE TITLES ------------------------------------------------------->
<div class="edit1" id="title1">
	order dispatch section
</div>
<div class="edit2"id="title2"> 
	enter dispatch information
</div>

<!--------------------------------END PAGE TITLES ------------------------------------------------------->



<%'response.write(request.form("ordernumber"))
'response.write(request.form("biltyno"))
'response.End()
'%>
<%' Initial checking before proceed: if order number is not empty
if request.form("ordernumber") = "" then	
	session("report_error") = "<img src=""../picture_library/failed.gif"" border=""0"" align=""middle"" style=""padding-right:10px;""><font face=verdana color=red size=2>All parameters are mandatory.</font>"
	response.Redirect("DispatchHome.asp#dispatch_section")
	response.End 
end if

' Initial checking before proceed: if order number is valid
set rs_order = conn.execute("select * from orders where Orderid="&Request.Form("ordernumber")&"")
if rs_order.eof then
	session("report_error") = "<img src=""../picture_library/failed.gif"" border=""0"" align=""middle"" style=""padding-right:10px;""><font face=verdana color=red size=2><b>Order # " & Request.Form("ordernumber") & "</b> does not exist.</font></font><br><br>"
	response.Redirect("DispatchHome.asp#dispatch_section")
	response.End 
end if

' Initial checking before proceed: if order number is forwarded for dispatch
set rs_fdate = conn.execute("select * from orders where Orderid="&Request.Form("ordernumber")&" and farward_date is null")
if not rs_fdate.eof then
	session("report_error") = "<img src=""../picture_library/failed.gif"" border=""0"" align=""middle"" style=""padding-right:10px;""><font face=verdana color=red size=2><b>Order # " & Request.Form("ordernumber") & "</b> has not been forwarded yet.</font></font><br><br>"
	response.Redirect("DispatchHome.asp#dispatch_section")
	response.End 
end if
%>





<section>
<%'Check if user has decided to enter the dispatch
if request("dispatch")="3-01A - Dispatch-Enter" then

' Initial checking before proceed: if user has got basic rights
set role_rs = conn.execute("SELECT * FROM role AS rl WHERE rl.right_id='14-001' and rl.status='A' and rl.userid="&session("loginid")&"")
if role_rs.eof then
session("report_error") = "<img src=""../picture_library/failed.gif"" border=""0"" align=""middle"" style=""padding-right:10px;""><font face=verdana color=red size=2><b>Access Denied.</b> Please contact OSMS Administrator.</font></font><br><br>"
response.Redirect("DispatchHome.asp#dispatch_section")
Response.End 
end if

' Initial checking before proceed: if order has not been dispatched fully
Set ifful = conn.execute("select * from orders  where Orderid="&Request("ordernumber")&" ")
session("ost")=ifful("status")
If ifful("status")=2 then
session("report_error") = "<img src=""../picture_library/failed.gif"" border=""0"" align=""middle"" style=""padding-right:10px;""><font face=verdana color=red size=2><b>Order # " & Request.Form("ordernumber") & "</b> has already been fully dispatched.</font></font><br><br>"
response.Redirect("DispatchHome.asp#dispatch_section")
Response.End 
end if

 

set chk_entry_exit = conn.execute("select * from Dispatches where Orderid="&Request.Form("ordernumber")&"  ")
while not chk_entry_exit.eof
c=c+1
chk_entry_exit.movenext
wend


'PENDING TRANSFER TO INVOICES FOR TRANSECTION OF DISPATCHES AND INVOICES
set in_orders= conn.Execute (" SELECT count(OrderDetail.Orderid) as tot_rec FROM OrderDetail,orders where OrderDetail.orderid=orders.Orderid and orders.status=1 and OrderDetail.Orderid="&Request("ordernumber")&" ")
set in_invoices= conn.Execute (" SELECT count(Inv_OrderNO) as tot_rec FROM Invoices where Inv_type='PENDING' and Inv_OrderNO="&Request("ordernumber")&" and Inv_status is null ")
if in_invoices("tot_rec") = in_orders("tot_rec") then
conn.Execute "UPDATE orders INNER JOIN OrderDetail ON orders.Orderid = OrderDetail.orderid SET OrderDetail.pending_units = OrderDetail.units+OrderDetail.bonus, OrderDetail.dispatch_status = 'N', OrderDetail.type = 'PEN' WHERE orders.Orderid="&Request("ordernumber")&"  AND orders.status=1"
else
'conn.Execute "INSERT INTO Invoices ( Inv_OrderNO, Inv_Prdid, Inv_Packs, Inv_Price, Inv_Dist_id, Inv_Area_id, Inv_type, Inv_Dispatch_Date ) SELECT OrderDetail.orderid, OrderDetail.productid, OrderDetail.units+OrderDetail.bonus, OrderDetail.price, orders.tblDistId, orders.tblAreaID, 'PENDING' AS type, #"&fnewdate&"# FROM OrderDetail, orders WHERE OrderDetail.orderid="&Request("ordernumber")&" And OrderDetail.orderid=[orders].[Orderid] AND orders.status=1 "
end if
			
'UPDATE PENDING OF FORWARDED ORDER	
conn.Execute "UPDATE orders INNER JOIN OrderDetail ON orders.Orderid = OrderDetail.orderid SET OrderDetail.pending_units = OrderDetail.units+OrderDetail.bonus, OrderDetail.dispatch_status = 'N', OrderDetail.type = 'PEN' WHERE orders.status=1 and orders.Orderid="&Request("ordernumber")&" AND OrderDetail.disp_date Is Null AND OrderDetail.pending_date Is Null"
conn.Execute "UPDATE orders INNER JOIN OrderDetail ON orders.Orderid = OrderDetail.orderid SET OrderDetail.pending_units = OrderDetail.units+OrderDetail.bonus, OrderDetail.dispatch_status = 'N', OrderDetail.type = 'PEN' WHERE orders.status=3 and orders.Orderid="&Request("ordernumber")&" AND OrderDetail.disp_date Is Null AND OrderDetail.pending_date Is Null"
conn.Execute "UPDATE orders INNER JOIN OrderDetail ON orders.Orderid = OrderDetail.orderid SET OrderDetail.pending_units = OrderDetail.units+OrderDetail.bonus, OrderDetail.dispatch_status = 'N', OrderDetail.type = 'PEN' WHERE orders.status=8 and orders.Orderid="&Request("ordernumber")&" AND OrderDetail.disp_date Is Null AND OrderDetail.pending_date Is Null"
conn.Execute "UPDATE Dispatches INNER JOIN orders ON Dispatches.Orderid = orders.Orderid SET orders.disp_Date =Dispatches.dispatch_date where orders.Orderid="&Request("ordernumber")&""

'Retriving Value from Previous page
if len(Request("orderNumber")) <> 0 then
idd = Request("orderNumber")
end if
if Request("radio1") <> 0 then
idd = Request("radio1")
end if
if Request("radio2") <> 0 then
idd = Request("radio2")
end if

'ON ERROR RESUME NEXT
if idd <> 0 then



Set rs = conn.execute("select * from orders,OrderDetail, Distributor, Area where orders.Orderid="&idd&" And orders.tblDistId=Distributor.DistId And orders.tblAreaID=Area.AreaID  ")
subareaid	=	rs("subareaid")
	if subareaid<>0 then
	Set rs2 = conn.execute("select * from SubArea where subAreaId="&subareaid&"  ")
	Set rs3 = conn.execute("select * from insti where partyId="&instiID&"  ")
	suban=rs2("AreaName")
	else
	suban="Not Available"
	end if

orderdd		=	rs("dd_amount")
instiID		=	rs("instiID")
	if instiID<>0 then
	Set rs3 = conn.execute("select * from insti where partyId="&instiID&"  ")
	instiname=rs3("partyName")
	else
	instiname="Not Available"
	end if

'dim status, status_comments, order_type
status			= Rs.Fields("orders.status")
status_comments = Rs.Fields("crem")
order_type		= Rs.Fields("orderType")
otype			= Rs.fields("orderType")
dd_amount		= Rs.Fields("dd_amount")
instruct		= Rs.Fields("instructions")
Month_PRD		= Rs.Fields("Period")
Period			= monthname(right(Rs.Fields("Period"),2))
Period			= Period &"-"& left(Rs.Fields("Period"),4)
'Calculate order value
prd_value	=0
order_value	=0

set rs_value = conn.execute("select * from OrderDetail where orderid="&idd&"")
rs_value.MoveFirst()
Do while not rs_value.eof 
	prd_value=rs_value.fields("value")
	order_value = order_value + prd_value
rs_value.MoveNext()
Loop

variance=0
variance=(orderdd-order_value)
%>

<div class="table-box2">
    <table id="ssr">
<tr>
	<!--<th>Order #</th>
	<td><%=Rs.Fields("orders.Orderid")%>	</td>-->
	<!--<th>Sale Type</th>	
	<td style=" letter-spacing:1px; text-align: center; font-family: Arial black, Arial; font-size:21px; color:#990000;"><%=order_type%> Sales</td>-->
</tr>
<tr valign="middle">
    <th>Order #</th>	
	<th>Area</th>
	<th>Distributor</th>
	<th>Order Month</th>
	<th>Forward Date</th>
</tr>
<tr valign="middle">
    <td id="invorderid" align="center"><%=Rs.Fields("orders.Orderid")%>	</td>
	<td style="text-align: center;vertical-align: middle;" ><%=Rs.Fields("AreaName")%></td>
	<td style="text-align: center;vertical-align: middle;" ><%=Rs.Fields("DistName")%></td>	
	<td style="text-align: center;vertical-align: middle;" ><%=Period%></td>
	<td style="text-align: center;vertical-align: middle;" ><%=theDateformat(Rs.fields("farward_date"),2)%></td>	
</tr>
<!--<tr valign="middle">
	<th style="text-align: center;vertical-align: middle;" >Payment mode /<br>Instrument #</th>
	<th  >Enclosed /<br>Payment (Rs.)</th>
	<th>Order Value (Rs.)</th>
	<th>Amount Variance (Rs.)</th>
</tr>
<tr valign="middle">
	<td style="text-align: center;vertical-align: middle;" ><%=Rs.Fields("ddNumber")%></td>
	<td style="text-align: center;vertical-align: middle;" ><%=FormatNumber(rs("dd_amount"),0)%></td>
	<td style="text-align: center;vertical-align: middle;" ><%=FormatNumber(order_value,0)%></td>
	<% if variance<0 then %>
		<font color="#FF0000">
	<% else %>
		<font color="#000000">
	<% end if %>
	<td style="text-align: center;vertical-align: middle;" ><%=FormatNumber(variance,0)%></td>
</tr>-->
</table>
</div>        
</b>
</font>

<%	if status = 5 then%>
<div class="table-box2">
    <table id="ssr">
<tr>
<td align="center">
<%Response.Write ("<font size='5' color='red'>CANCELLED ORDER</font><BR><font size='3' color='lightblue'>DUE TO FOLLOWING REASON</font><BR><font size='4' color='red'>"&status_comments)	%>
</td>
</tr>
</table>
</div>
<%	end if	%>
<%	
	set rs=Nothing
	set rs_value=nothing
%>
<br>
<form style="padding-bottom: 40px;" action="updateOrder4dispatch.asp" name="dispatchfrm" method="post">





<%' Checking what it is and why it is
'if request("selt") <> "" or request("selt") <>0 then
'response.Write "<h1><font color=red>" & (request("selt")) & "</h1></font>"
'response.end()
'end if
%>


<!--input type="hidden" name="entrytype" value="<%'=request("selt")%>" -->
<div class="table-box2">
    <table id="ssr">
<tr valign="middle" height="35">
	<th>Sr. #					</th>
	<th>Product Name			</th>
	<th>Price					</th>
    <th style="width: auto;" valign="middle">Batch No</th>
    <th style="width: 20px;"><font color="#993300">Pending <br> Packs</font>	</th>
	<th>Base<br>Packs			</th>
	<th>Bonus<br>Packs			</th>
	<th>Total<br>Packs			</th>
	<th>Value<br>(Rs.) 			</th>
	
	
</tr>   
<%
dim theQry
if session("type")=4 then
    theQry="select * from OrderDetail, Products where orderid="&idd&" AND PrdID=productid ORDER BY PrdFormId, prdName"
else
    theQry="select * from OrderDetail, Products where orderid="&idd&" AND PrdID=productid ORDER BY prdName"
end if
'response.write(theQry)
Set rs = conn.execute(theQry)
counter=1
sum=0
val=0
bases=0
bonuses=0
packs=0

While Not Rs.Eof
    readers=""
    backg="background: transparent;"
    if rs("pending_units")=0 then
        readers="readonly"
        backg="background: transparent;"
        bord="border:none;"
    end if

%>
<tr <%if counter MOD 2 = 0 then%>bgcolor="#ffffff"<%end if%> height="35">
	<td align="center">					<%=counter%>							</td>
	<td align="left" style="cursor: pointer;"  onclick="handleProductClick(event,<%=counter%>)"> 
		<%if rs("pending_units")<>0 then%>

		<label  onclick="handleProductClick(event,<%=counter%>)"  class="custom-checkbox">
			<input  tabindex="-1" id="productCheck<%=counter%>" name="productCheck<%=counter%>" checked onchange="togglePendingUnits(<%=counter%>)" type="checkbox">
			<span ></span>
		  </label>
		<!-- <input type="checkbox" tabindex="-1" id="productCheck<%=counter%>" name="productCheck<%=counter%>" checked onchange="togglePendingUnits(<%=counter%>)"> -->
		<% end if %>
		<b>	<%=Rs.Fields("PrdName")%></b><input type="hidden" id="text2" name="pid<%=counter%>" value="<%=Rs("productid")%>">
							<%	if order_type = "INSTITUTIONAL" then
   								Response.Write ("<br><FONT SIZE='-1' COLOR='GRAY'>" & rs.fields("generic"))
   								'Response.Write " ( Packing of " &rs.fields("packing")&" )" 
   								end if
   							%>								</td>
	<td align="right" width="60"><font color="gray">	<%=FormatNumber(Rs.Fields("price"),2)%>	</td>
    <td style="width: 50px; text-align:center;" width="90">
		<%if rs("pending_units")<>0 then%>
		<input type="text" style="text-align: center; min-height:32px; min-width:95px; border:1px outset darkgreen; background-color:transparent;" id="batch_no<%=counter%>" name="batch_no<%=counter%>" size="4" title="Enter the relevent batch #" value="0">	
		<% else 
		set role_rs = conn.execute("SELECT * FROM role AS rl WHERE rl.right_id='14-006' and rl.status='A' and rl.userid="&session("loginid")&"")
		if not role_rs.eof then %>
		<input <%=readers%> tabindex="-1" type="text" style="text-align: center; <%=backg%> <%=backg%> <%=bord%>" id="batch_no<%=counter%>" name="batch_no<%=counter%>" size="4" title="Enter the relevent batch #" value="<%=rs("batchno")%>">
       <% else
		Response.Write (rs.fields("batchno"))
		end if 
		end if
		%>
	</td>
    <%if rs("pending_units")<>0 then%>
	<td align="center"><input tabindex="-1" style="color:#FF0000;text-align: center; min-height:32px; min-width:95px; border:1px outset darkgreen; background-color:transparent;" type="text" id="disp_unit<%=counter%>" name="disp_unit<%=counter%>" value="0" size="5" onKeyPress="return isNumber(event)"></td>
	 <%else%>
	 <!-- <td align="center"><input tabindex="-1" style="color:#FF0000;text-align: center; min-height:32px; min-width:95px; border:1px outset darkgreen; background-color:transparent;" type="text" id="disp_unit<%=counter%>" name="disp_unit<%=counter%>" value="<%=rs("pending_units")%>" size="5" onKeyPress="return isNumber(event)"></td> -->

	<td width="90" style="text-align: center;" >
	<% 
	set role_rs = conn.execute("SELECT * FROM role AS rl WHERE rl.right_id='14-006' and rl.status='A' and rl.userid="&session("loginid")&"")
	if not role_rs.eof then 
	%>
	<input <%=readers%> tabindex="-1"  style="color:#FF0000; text-align: center; <%=backg%> <%=bord%>" type="text" id="disp_unit<%=counter%>" name="disp_unit<%=counter%>" value="0" size="5" onKeyPress="return isNumber(event)">

	<% else %>

	-

   	<%end if%>
	
	   </td>
   	<%end if%>
   	<td align="right" width="60">	<%=FormatNumber(Rs.Fields("units"),0)%>	</td>
   	<td align="right" width="60">	<%=FormatNumber(Rs.Fields("bonus"),0)%>	</td>   	
   	<td align="right" width="60"><b id="Tot_Units<%=counter%>"><%=FormatNumber(Rs.Fields("units")+Rs.Fields("Bonus"),0)%></b></td>
   	<td align="right" width="60">	<%=FormatNumber((Rs.Fields("units")*Rs.Fields("price")),0)%>	</td>   	
	<input type="hidden" name="prd_id<%=counter%>" value="<%=Rs.Fields("productid")%>">	
	<input type="hidden" name="disp_name<%=counter%>" value="<%=Rs.Fields("PrdName")%>">
</tr>
<%
	bases=bases+Rs.Fields("units")
	bonuses=bonuses+Rs.Fields("Bonus")
	packs=packs+Rs.Fields("units")+Rs.Fields("Bonus")
	orderValue=orderValue+(Rs.Fields("units")*Rs.Fields("price"))
	Rs.MoveNext
	counter=counter+1
	Wend	
%>
	
<%	
	if otype="General"then
	psum=0
	pval=0			
%>
</tr>
<tr height="35">
	<th colspan="5">Total</th>
	<th><%=FormatNumber(bases,0)%></th>
	<th><%=FormatNumber(bonuses,0)%></th>
	<th><%=FormatNumber(packs,0)%></th>
	<th id="tdordervalue_1"><%=FormatNumber(orderValue,0)%></th>	
</tr>
	<%	
		nsum=0
		nval=0
		Set rs = conn.execute("select * from OrderDetail, Products where orderid="&idd&"  and PrdType=5 and PrdID=productid ORDER BY prdSequence")
		While Not Rs.Eof
 			nval=rs.fields("value")
   			nsum = nsum+nval
		Rs.MoveNext
		Wend
%>
<%if nsum=<0 then %>
<%else%>
<tr>
	<th colspan="5">NON-PROMOTIONAL PRODUCTS TOTAL VALUE (Rs.)</th>	
	<th id="tdordervalue_2">		<%=FormatNumber(nsum,0)%></th>
</tr>
<tr>
	<td colspan="5" align="right">	GRAND TOTAL VALUE (Rs.)		</th>
	<td id="tdordervalue_3">		<%=FormatNumber(nsum+psum,0)%></th>
</tr>
<%end if%>
<%else	
	psum=0
	pval=0				
		Set rs = conn.execute("select * from OrderDetail, Products where orderid="&idd&"  and PrdID=productid ORDER BY prdname")
		While Not Rs.Eof
		'pval=rs.fields("units")*rs.fields("price")
		pval=rs.fields("value")
		unt=unt+rs.fields("units")
		psum = psum+pval
		Rs.MoveNext
		Wend
if otype="DX" then
%>
<tr>
	<th colspan="3">GRAND TOTAL VALUE (Rs.)</th>
	<th>		<%=FormatNumber(unt,0)%></th>
	<th>		</td>
	<th id="tdordervalue_3">		<%=FormatNumber(psum,0)%></th>
	<%if unt>=7600 then %>
	<%truck=unt/7600%>
	<%cott=unt/20%>
	<th><%="Number of Truck(s): "&round(truck,1)%></th>
	<%end if %>
</tr>
<%else%>
<tr>
	<th colspan="5">GRAND TOTAL VALUE (Rs.)</th>
	<th id="tdordervalue_3"><%=FormatNumber(psum,0)%></th>
</tr>
<%end if%>
<%end if%>
</table>
</div>
<br>

<div>
    <table style="table-layout: auto; border: none;" >
<tr>
	<th colspan="3">Goods Transporter Name</th>
	<td colspan="4" align="center">
	<!--input type="text" name="disp_adda" <%if ddc>0 then %> value="<%=dcc("OrderDetail.addaname")%>" <%else :%> value="" <% end if%>-->
	<select required class="selecto" class="selecto" name="disp_adda">
	<option value="" selected name="disp_adda"> Select Goods Transporters </option>
	<%  set rs_gt = conn.execute ("select * from goods_transporters where status=1 order by gt_name")
		rs_gt.MoveFirst()
		do while not rs_gt.eof
	%>
		<option value="<%=rs_gt("gt_id")%>"><%=rs_gt("gt_name")%></option>
	<%
		rs_gt.MoveNext()
		loop
	%>
	</td>
</tr>
<tr>
	<th colspan="3">Date</th>
	<td colspan="4" align="center">
    <!-- Year, Month, and Day Dropdowns (like in the previous example) -->
    <label for="misYear">Year:</label>
    <select id="misYear" class="selecto" onchange="misUpdateDays()"></select>
    
    <label for="misMonth">Month:</label>
    <select id="misMonth" class="selecto" onchange="misUpdateDays()">
        <option value="1">January</option>
        <option value="2">February</option>
        <option value="3">March</option>
        <option value="4">April</option>
        <option value="5">May</option>
        <option value="6">June</option>
        <option value="7">July</option>
        <option value="8">August</option>
        <option value="9">September</option>
        <option value="10">October</option>
        <option value="11">November</option>
        <option value="12">December</option>
    </select>

    <label  for="misDay">Day:</label>
    <select class="selecto" id="misDay"></select>

	</td>
</tr>


<tr height="13"></tr>
<tr valign="top">
	<th colspan="2">Bilty # </th>
	<th>Cost</th>
	<th>Cartons</th>
	<th>Notes</th>
	<th colspan="2">Invoice Number</th>
</tr>
<tr valign="top" style="vertical-align: middle;" valign="middle"  >
	<td colspan="2" align="center" ><input required style="text-align:left;" readonly="yes" tabindex="-1" size="7" type="hidden"  class="datepicker cdatepicker" onblur="shiftdd();" name="disp_date" <%if ddc>0 then %> value="<%=dcc("dispatch_date")%>" <%else :%> value="<%=date()-1%>" <% end if%> ><input size="6" required type="text" name="bilty_no" <%if ddc>0 then %> value="<%=dcc("OrderDetail.biltyno")%>" <%else :%> value="" <% end if%>  onKeyPress="return isNumber(event)" style="min-height:32px; margin:auto;"></td>
	<td align="center"><input size="4" required type="text" name="bilty_cost" value="0" onKeyPress="return isNumber(event)" style="min-height:32px; margin:auto; text-align:right;"></td>
	<td align="center"><input size="4" required type="text" name="cartons" <%if ddc>0 then %> value="<%=dcc("OrderDetail.cartons")%>" <%else :%> value="" <% end if%> onKeyPress="return isNumber(event)" style="min-height:32px; margin:auto; text-align:right;"></td>
	<td align="center"><input size="7" required type="text" name="remarks" <%if ddc>0 then %> value="<%=dcc("dispatch_remarks")%>" <%else :%> value="Ok" <% end if%> style="min-height:32px; margin:auto; text-align:left;"></td>
	<td align="center" colspan="2"  ><input type="hidden" readonly="yes" tabindex="-1" class="datepicker cdatepicker" required style="text-align:left; position: inherit;" size="7" name="invoice_date" value="<%=date()-1%>" /><input size="7" onblur="showHint()" id="invoiceid" required type="text" name="invoice_no" value="0" onKeyPress="return isNumber(event)" style="min-height:32px; margin:auto; text-align:right;"></td>
</tr>

</table>
</div>

<table>
    <tr>
        <td tabindex="-1"><p style="font-weight: bold; min-height:21px; text-align:center" ><span id="txtHint"></span></p></td>
    </tr>
    <tr>
        <td align="center">            
            <input tabindex="11" type="Submit" style="text-align: center;" class="btn_aamir_new btn_aamir" value="Proceed"   id="button1" name="button1">
        </td>
    </tr>
</table>

<input type="hidden" name="txtchk" value="start">
<input type="hidden" name="ordernumber" value="<%=idd%>">

<%session("cdschk")=1%>
<%session("pd")=1%>
</form>
<% 
	end if
%>











<!--==========*=*=*=*=*=* Section for edit the entered Dispatch *=*=*=*=*============-->
<%
	else if request("dispatch")="3-01B - Dispatch-Edit" then

' Initial checking before proceed: if user has got basic rights
set role_rs = conn.execute("SELECT * FROM role AS rl WHERE rl.right_id='14-001' and rl.status='A' and rl.userid="&session("loginid")&"")
if role_rs.eof then
session("report_error") = "<img src=""../picture_library/failed.gif"" border=""0"" align=""middle"" style=""padding-right:10px;""><font face=verdana color=red size=2><b>Access Denied.</b> Please contact OSMS Administrator.</font></font><br><br>"
response.Redirect("index.asp#dispatch_section")
Response.End 
end if

' Initial checking before proceed: if order has not been dispatched fully
'Set ifful = conn.execute("select * from orders  where Orderid="&Request("ordernumber")&" ")
'session("ost")=ifful("status")
'If ifful("status")=2 then
'session("report_error") = "<img src=""../picture_library/failed.gif"" border=""0"" align=""middle"" style=""padding-right:10px;""><font face=verdana color=red size=2><b>Order # " & Request.Form("ordernumber") & "</b> has already been fully dispatched.</font></font><br><br>"
'response.Redirect("index.asp#dispatch_section")
'Response.End 
'end if

 

set chk_entry_exit = conn.execute("select * from Dispatches where Orderid="&Request.Form("ordernumber")&"  ")
while not chk_entry_exit.eof
c=c+1
chk_entry_exit.movenext
wend


'PENDING TRANSFER TO INVOICES FOR TRANSECTION OF DISPATCHES AND INVOICES
set in_orders= conn.Execute (" SELECT count(OrderDetail.Orderid) as tot_rec FROM OrderDetail,orders where OrderDetail.orderid=orders.Orderid and orders.status=1 and OrderDetail.Orderid="&Request("ordernumber")&" ")
'set in_invoices= conn.Execute (" SELECT count(Inv_OrderNO) as tot_rec FROM Invoices where Inv_type='PENDING' and Inv_OrderNO="&Request("ordernumber")&" and Inv_status is null ")
if in_invoices("tot_rec") = in_orders("tot_rec") then
conn.Execute "UPDATE orders INNER JOIN OrderDetail ON orders.Orderid = OrderDetail.orderid SET OrderDetail.pending_units = OrderDetail.units+OrderDetail.bonus, OrderDetail.dispatch_status = 'N', OrderDetail.type = 'PEN' WHERE orders.Orderid="&Request("ordernumber")&"  AND orders.status=1"
else
'conn.Execute "INSERT INTO Invoices ( Inv_OrderNO, Inv_Prdid, Inv_Packs, Inv_Price, Inv_Dist_id, Inv_Area_id, Inv_type, Inv_Dispatch_Date ) SELECT OrderDetail.orderid, OrderDetail.productid, OrderDetail.units+OrderDetail.bonus, OrderDetail.price, orders.tblDistId, orders.tblAreaID, 'PENDING' AS type, #"&fnewdate&"# FROM OrderDetail, orders WHERE OrderDetail.orderid="&Request("ordernumber")&" And OrderDetail.orderid=[orders].[Orderid] AND orders.status=1 "
end if
			
'UPDATE PENDING OF FORWARDED ORDER	
conn.Execute "UPDATE orders INNER JOIN OrderDetail ON orders.Orderid = OrderDetail.orderid SET OrderDetail.pending_units = OrderDetail.units+OrderDetail.bonus, OrderDetail.dispatch_status = 'N', OrderDetail.type = 'PEN' WHERE orders.status=1 and orders.Orderid="&Request("ordernumber")&" AND OrderDetail.disp_date Is Null AND OrderDetail.pending_date Is Null"
conn.Execute "UPDATE orders INNER JOIN OrderDetail ON orders.Orderid = OrderDetail.orderid SET OrderDetail.pending_units = OrderDetail.units+OrderDetail.bonus, OrderDetail.dispatch_status = 'N', OrderDetail.type = 'PEN' WHERE orders.status=3 and orders.Orderid="&Request("ordernumber")&" AND OrderDetail.disp_date Is Null AND OrderDetail.pending_date Is Null"
conn.Execute "UPDATE orders INNER JOIN OrderDetail ON orders.Orderid = OrderDetail.orderid SET OrderDetail.pending_units = OrderDetail.units+OrderDetail.bonus, OrderDetail.dispatch_status = 'N', OrderDetail.type = 'PEN' WHERE orders.status=8 and orders.Orderid="&Request("ordernumber")&" AND OrderDetail.disp_date Is Null AND OrderDetail.pending_date Is Null"
conn.Execute "UPDATE Dispatches INNER JOIN orders ON Dispatches.Orderid = orders.Orderid SET orders.disp_Date =Dispatches.dispatch_date where orders.Orderid="&Request("ordernumber")&""

'Retriving Value from Previous page
if len(Request("orderNumber")) <> 0 then
idd = Request("orderNumber")
end if
if Request("radio1") <> 0 then
idd = Request("radio1")
end if
if Request("radio2") <> 0 then
idd = Request("radio2")
end if

'ON ERROR RESUME NEXT
if idd <> 0 then


dim queryDispatch
queryDispatch="select * from orders,OrderDetail, Distributor, Area where orders.Orderid="&idd&" And orders.tblDistId=Distributor.DistId And orders.tblAreaID=Area.AreaID  "
response.write(queryDispatch)
'if (session("type")=4) then

'end if

Set rs = conn.execute(queryDispatch)
'Set rs = conn.execute("select * from orders,OrderDetail, Distributor, Area where orders.Orderid="&idd&" And orders.tblDistId=Distributor.DistId And orders.tblAreaID=Area.AreaID  ")
subareaid	=	rs("subareaid")
	if subareaid<>0 then
	Set rs2 = conn.execute("select * from SubArea where subAreaId="&subareaid&"  ")
	Set rs3 = conn.execute("select * from insti where partyId="&instiID&"  ")
	suban=rs2("AreaName")
	else
	suban="Not Available"
	end if

orderdd		=	rs("dd_amount")
instiID		=	rs("instiID")
	if instiID<>0 then
	Set rs3 = conn.execute("select * from insti where partyId="&instiID&"  ")
	instiname=rs3("partyName")
	else
	instiname="Not Available"
	end if

'dim status, status_comments, order_type
status			= Rs.Fields("orders.status")
status_comments = Rs.Fields("crem")
order_type		= Rs.Fields("orderType")
otype			= Rs.fields("orderType")
dd_amount		= Rs.Fields("dd_amount")
instruct		= Rs.Fields("instructions")
Month_PRD		= Rs.Fields("Period")
Period			= monthname(right(Rs.Fields("Period"),2))
Period			= Period & "<br>"& left(Rs.Fields("Period"),4)
'Calculate order value
prd_value	=0
order_value	=0

set rs_value = conn.execute("select * from OrderDetail where orderid="&idd&"")
rs_value.MoveFirst()
Do while not rs_value.eof 
	prd_value=rs_value.fields("value")
	order_value = order_value + prd_value
rs_value.MoveNext()
Loop

variance=0
variance=(orderdd-order_value)
%>

<table id="ssr">
<tr>
	<th>Order #</th>
	<td style=" letter-spacing:1px; font-family: Arial black, Arial; font-size:21px; color:#990000;"><%=Rs.Fields("orders.Orderid")%>	</td>
	<th>Sale Type</th>	
	<td style=" letter-spacing:1px; font-family: Arial black, Arial; font-size:21px; color:#990000;"><%=order_type%> Sales</td>
</tr>
<tr valign="top">
	<th>Sale Area /<br>Dispatch Area </th>
	<th>Distributor Name /<br>Institution Name</th>
	<th>Order Month</th>
	<th>Order Feeding Date/Time</th>
</tr>
<tr valign="top">
	<td><%=Rs.Fields("AreaName")%> / <br><%=suban%></td>
	<td><%=Rs.Fields("DistName")%> / <br><%=instiname%></td>	
	<td><%=Period%></td>
	<td><%=theDateformat(Rs.fields("FeedDate"),2)%> /<br> <%=formatDateTime(Rs.fields("FeedDate"),4)%></td>	
</tr>
<!--<tr valign="top">
	<th>Payment mode /<br>Instrument #</th>
	<th>Enclosed /<br>Payment (Rs.)</th>
	<th>Order Value (Rs.)</th>
	<th>Amount Variance (Rs.)</th>
</tr>
<tr valign="middle">
	<td><%=Rs.Fields("ddNumber")%></td>
	<td><%=FormatNumber(rs("dd_amount"),0)%></td>
	<td><%=FormatNumber(order_value,0)%></td>
	<% if variance<0 then %>
		<font color="#FF0000">
	<% else %>
		<font color="#000000">
	<% end if %>
	<td><%=FormatNumber(variance,0)%></td>
</tr>-->
</table>
</b>
</font>

<%	if status = 5 then%>
<table id="ssr">
<tr>
<td align="center">
<%Response.Write ("<font size='5' color='red'>CANCELLED ORDER</font><BR><font size='3' color='lightblue'>DUE TO FOLLOWING REASON</font><BR><font size='4' color='red'>"&status_comments)	%>
</td>
</tr>
</table>
<%	end if	%>
<%	
	set rs=Nothing
	set rs_value=nothing
%>
<br>
<form id="ssr" action="updatedispatch.asp"  name="dispatchfrm" method="post" >





<%' Checking what it is and why it is
'if request("selt") <> "" or request("selt") <>0 then
'response.Write "<h1><font color=red>" & (request("selt")) & "</h1></font>"
'response.end()
'end if
%>


<!--input type="hidden" name="entrytype" value="<%'=request("selt")%>" -->
<table id="ssr">
<thead>
<tr valign="top">
	<th>Sr. #					</th>
	<th>Product Name			</th>
	<!--<th>Price					</th>-->
	<!--<th>Base<br>Packs			</th>-->
	<!--<th>Bonus<br>Packs			</th>-->
	<th>Total<br>Packs			</th>
	<th>Value<br>(Rs.) 			</th>
	<th><font color="#993300">Pending<br>Packs</font></th>
	<th valign="middle">Batch No</th>
	<th>Goods<br>Transporter </th>
	<th>Dispatched<br>On Dated 	</th>
	<th>G.R#<br>(Bilty #)</th>
	<th>Bilty<br>Cost</th>
	<th>No.of<br>Cartons 			</th>
	<th>Dispatch<br>Notes 		</th>
	<th>Invoice<br>Date 		</th>
	<th>Invoice<br>Number 		</th>	
</tr>   
</thead>







<%
	Set rs = conn.execute("select * from OrderDetail, Products where orderid="&idd&" AND PrdID=productid ORDER BY prdName")

'Set rs = conn.execute("SELECT  * FROM OrderDetail, Products WHERE orderid="&idd&" AND PrdID=productid AND disp_date <> 'null') AND biltyno <> 'Null' ORDER BY prdName ;")

	counter=1
	sum=0
	val=0
	bases=0
	bonuses=0
	packs=0
	While Not Rs.Eof
%>
<tr<%if counter MOD 2 = 0 then%>bgcolor="#e7e7e7"<%end if%>>
	<td>					<%=counter%>							</td>
	<td align="left"><b>	<%=Rs.Fields("PrdName")%></b><input type="hidden" id="text2" name="pid<%=counter%>" value="<%=Rs("productid")%>">
							<%	if order_type = "INSTITUTIONAL" then
   								Response.Write ("<br><FONT SIZE='-1' COLOR='GRAY'>" & rs.fields("generic"))
   								'Response.Write " ( Packing of " &rs.fields("packing")&" )" 
   								end if
   							%>			
	<%'=FormatNumber(Rs.Fields("price"),2)%>		<!--remove the <td> because not need in form but other info is here -->
   	<%'=FormatNumber(Rs.Fields("units"),0)%>		<!--remove the <td> because not need in form but other info is here -->
   	<%                                         '<!--remove the <td> because not need in form but other info is here -->
   		'if Rs.Fields("bonus")> 0 then
'   		Response.Write (rs.fields("bonus"))
'   		else
'   		Response.Write ("-")
'   		end if
   	%>   				
   	<td align="right"><%=FormatNumber(Rs.Fields("units")+Rs.Fields("Bonus"),0)%></td>
   	<input type="hidden" id="t_units<%=counter%>" name="t_units<%=counter%>" value="<%=FormatNumber(Rs.Fields("units")+Rs.Fields("Bonus"),0)%>" size="5">
	<%	
   		val=rs.fields("value")
   		sum = sum+val
	%>
	<td align="right"><%=FormatNumber(val,0)%></td>
	<%' input for dispathment%>	
   	<%if rs("pending_units")<>0 then%>
   	<td><input style="color:#FF0000;" type="text" id="disp_unit<%=counter%>" name="disp_unit<%=counter%>" value="<%=rs("pending_units")%>" size="5" onKeyPress="return isNumber(event)"></td>
	<%else%>
   	<td><input style="color:#FF0000;" type="text" id="disp_unit<%=counter%>" name="disp_unit<%=counter%>" value="0" size="5" onKeyPress="return isNumber(event)"></td>
   	<%end if%>
   	<%set prd=conn.execute("select * from Products where PrdID="&Rs.Fields("productid")&"")%>
	<input type="hidden" name="prd_id<%=counter%>" value="<%=Rs("productid")%>">	
	<input type="hidden" name="disp_name<%=counter%>" value="<%=prd("PrdName")%>">
	
	<td>
		<%if rs("pending_units")<>0 then%>
		<input type="text" id="batch_no<%=counter%>" <%if rs("batchNo")>0 then%> value="<%=Rs("batchno")%>" <%else%> value="<%response.Write("N/A")%>"<%end if%>  name="batch_no<%=counter%>" size="4" title="Enter the relevent batch #" value="0">	
		<% else %>
		<input type="text" id="batch_no<%=counter%>" <%if rs("batchNo")>0 then%> value="<%=Rs("batchno")%>" <%else%> value="<%response.Write("N/A")%>"<%end if%>  name="batch_no<%=counter%>" size="4" title="Enter the relevent batch #" value="0">	
          <%
		'Response.Write (rs.fields("batchno"))
		end if %>
		
		</td>
	
	<td size="5" align="center">
	
	<select class="selecto" name="disp_adda<%=counter%>" style="width:150px;">
	<option size="5" title="<%=(rs("addaname"))%>" selected name="disp_adda<%=counter%>">
	<%if len(rs("addaname"))>3 then   %>
	<%response.Write(rs("addaname"))%>
	<%else%>
	<%set rs_adda = conn.execute ("select gt_name from goods_transporters where gt_id ="&rs("addaname")&"")%>
	<%response.Write(rs_adda("gt_name"))%>
	<%end if%>
	</option>
	<%  set rs_gt = conn.execute ("select * from goods_transporters where status=1 order by gt_name")
		rs_gt.MoveFirst()
		do while not rs_gt.eof
	%>
		<option title="<%=rs_st("gt_name")%>" value="<%=rs_gt("gt_id")%>"><%=rs_gt("gt_name")%></option>
	<%
		rs_gt.MoveNext()
		loop
	%>
	</td>
	
	<td><input style="text-align:left;" readonly="" size="11" type="text" class="datepicker" onblur="shiftdd();" name="disp_date<%=counter%>"  value="<%=rs("disp_date")%>">
	</td>
	<td>
	<input type="text" size="4" name="bilty_no<%=counter%>" value="<%=rs("biltyno")%>" onKeyPress="return isNumber(event)"></td>
	<td>
	<input type="text" size="4" name="bilty_cost<%=counter%>" value="<%=rs("bilty_chrgs")%>" onKeyPress="return isNumber(event)"></td>
	<td>
	<input type="text" size="4" name="cartons<%=counter%>" value="<%=rs("cartons")%>" value="" onKeyPress="return isNumber(event)"></td>
	<td>
	<input type="text" size="4" name="remarks<%=counter%>"  value="<%=rs("dispatch_remarks")%>"></td>
	<td>
	<input class="datepicker" style="text-align:left" size="11" readonly="yes" type="text" name="invoice_date<%=counter%>" value="<%=rs("invoice_date")%>"></td>
	<td>
	<input type="text" size="7" name="invoice_no<%=counter%>" value="<%=rs("invoice_no")%>"  value="0"  onKeyPress="return isNumber(event)"></td>

</tr>
<%
	bases=bases+Rs.Fields("units")
	bonuses=bonuses+Rs.Fields("Bonus")
	packs=packs+Rs.Fields("units")+Rs.Fields("Bonus")
	Rs.MoveNext
	counter=counter+1
	Wend	
%>
	
<%	
	if otype="General"then
	psum=0
	pval=0
				
	Set rs = conn.execute("select * from OrderDetail, Products where orderid="&idd&"  and PrdType=1 and PrdID=productid ORDER BY prdSequence")
	While Not Rs.Eof
 		 	'pval=rs.fields("units")*rs.fields("price")
 		 	pval=rs.fields("value")
   		 	psum = psum+pval
	Rs.MoveNext
	Wend
	%>
</tr>
<tr>
	<th colspan="3">PROMOTIONAL PRODUCTS TOTAL VALUE (Rs.)</th>
	<th id="tdordervalue_1"><%=FormatNumber(psum,0)%></th>
	</tr>
	<%	
		nsum=0
		nval=0
		Set rs = conn.execute("select * from OrderDetail, Products where orderid="&idd&"  and PrdType=5 and PrdID=productid ORDER BY prdSequence")
		While Not Rs.Eof
 			nval=rs.fields("value")
   			nsum = nsum+nval
		Rs.MoveNext
		Wend
%>
<%if nsum=<0 then %>
<%else%>
<tr>
	<th colspan="5">NON-PROMOTIONAL PRODUCTS TOTAL VALUE (Rs.)</th>	
	<th id="tdordervalue_2">		<%=FormatNumber(nsum,0)%></th>
</tr>
<tr>
	<td colspan="5" align="right">	GRAND TOTAL VALUE (Rs.)		</th>
	<td id="tdordervalue_3">		<%=FormatNumber(nsum+psum,0)%></th>
</tr>
<%end if%>
<%else	
	psum=0
	pval=0				
		Set rs = conn.execute("select * from OrderDetail, Products where orderid="&idd&"  and PrdID=productid ORDER BY prdname")
		While Not Rs.Eof
		'pval=rs.fields("units")*rs.fields("price")
		pval=rs.fields("value")
		unt=unt+rs.fields("units")
		psum = psum+pval
		Rs.MoveNext
		Wend
if otype="DX" then
%>
<tr>
	<th colspan="3">GRAND TOTAL VALUE (Rs.)</th>
	<th>		<%=FormatNumber(unt,0)%></th>
	<th>		</td>
	<th id="tdordervalue_3">		<%=FormatNumber(psum,0)%></th>
	<%if unt>=7600 then %>
	<%truck=unt/7600%>
	<%cott=unt/20%>
	<th><%="Number of Truck(s): "&round(truck,1)%></th>
	<%end if %>
</tr>
<%else%>
<tr>
	<th colspan="5">GRAND TOTAL VALUE (Rs.)</th>
	<th id="tdordervalue_3"><%=FormatNumber(psum,0)%></th>
</tr>
<%end if%>
<%end if%>
</table>
<br>

<%
	set maxid=conn.execute("select max(id) from Dispatches where Orderid="&idd&" ")
	set dcc= conn.execute("SELECT * FROM  orderdetail WHERE Orderid="&idd&" ")
%>

<td style=" border:none; "  colspan="2" " align="center">
<Input id="ma" Type=button value="Back & Feed Again" class="selectn" onClick="javascript:history.go(-1)" id=button1 name=button1  id="ma">
<input id="ma" type="submit" value="Proceed"  id="button1" name="button1" tabindex="-1"  class="btn_aamir_new btn_aamir">
</td>
			<input type="hidden" name="txtchk" value="start">
			<input type="hidden" name="ordernumber" value="<%=idd%>">
			<%session("cdschk")=1%>
			<%session("pd")=1%>
</form>
<br><br><br>			
<% 
	end if
%>




<%
	else if request("dispatch")="3-01C - Dispatch-Remove" then
'	response.write "Delete ok = " & request("dispatch")
'	response.End()

    Set ifful = conn.execute("select * from orders where Orderid="&Request.Form("ordernumber")&" ")
    Dim ordertDate
    ordertDate = cDate(ifful("disp_Date"))' Replace with order dispatch date
    Dim currentDate
    currentDate = Now
    oPeriod=Month(ordertDate) & Year(ordertDate)
    cPeriod=Month(currentDate) & Year(currentDate)

    If (session("loginid")=320 or session("loginid")=8) then
        'Response.write(session("loginid") & " Reached in restricted block... " & (oPeriod <> cPeriod))
        if (oPeriod <> cPeriod) Then
        Response.Write(" Month mismatch")
        Session("report_error") = "<img src=""../picture_library/failed.gif"" border=""0"" align=""middle"" style=""padding-right:10px;""><br><font face=verdana color=red size=2>Order # "& Request.Form("ordernumber") &" doesn't belong to current month ("& monthname(Month(currentDate),1) &"-"& Year(currentDate) &").<br>You are not authorized to edit/restore/reverse orders which belong to previously closed months.<br /><font color=black>You may contact MIS Department for further discussion.</font>"        
        Response.Redirect("index.asp")
		Response.End
        end If		
    End If

	conn.Execute "UPDATE orders INNER JOIN OrderDetail ON orders.Orderid = OrderDetail.orderid SET OrderDetail.pending_units = OrderDetail.units+OrderDetail.bonus, OrderDetail.dispatch_status = 'N', OrderDetail.batchNo = null, OrderDetail.invoice_date = null, OrderDetail.type = 'PEN', OrderDetail.pending_date=null,OrderDetail.disp_date=null , OrderDetail.biltyno=NULL ,OrderDetail.addaname=NULL , OrderDetail.cartons=NULL,  OrderDetail.bilty_chrgs = null,orders.status=1 ,orders.disp_Date=NULL ,OrderDetail.dispatch_entry_date=NULL,OrderDetail.invoice_no = Null, OrderDetail.dist_flag_date = Null, OrderDetail.dist_flag_month = Null, OrderDetail.dist_falg_entry = Null WHERE orders.Orderid="&request.form("ordernumber")&" "
	    
    conn.Execute "DELETE * FROM Invoices WHERE Inv_OrderNO="&request.form("ordernumber")&" "
		
		session("report_error") = "<img src=""../picture_library/succeeded.gif"" border=""0"" align=""middle"" style=""padding-right:10px;""><font face=verdana color=green size=2>Successfully deleted dispatch information for <b>Order # " & request.form("ordernumber") & "</b>.</font>"
		response.Redirect("index.asp#dispatch_section")
		response.End()
		
	end if
	end if
	end if
	
%>



</center>

<script>
	const misStartYear = 2022;
	const misEndYear = new Date().getFullYear();
	const misCurrentMonth = new Date().getMonth() + 1;
	const misCurrentDay = new Date().getDate();
	
	const misYearDropdown = document.getElementById("misYear");
	for (let year = misStartYear; year <= misEndYear; year++) {
		const option = document.createElement("option");
		option.value = year;
		option.textContent = year;
		misYearDropdown.appendChild(option);
	}
	misYearDropdown.value = misEndYear;

	function misGetDaysInMonth(year, month) {
		return new Date(year, month, 0).getDate();
	}

	function misUpdateDays() {
		const misYear = parseInt(document.getElementById("misYear").value);
		const misMonth = parseInt(document.getElementById("misMonth").value);
		const misDayDropdown = document.getElementById("misDay");
		misDayDropdown.innerHTML = "";
		const misDaysInMonth = misGetDaysInMonth(misYear, misMonth);
		for (let day = 1; day <= misDaysInMonth; day++) {
			const option = document.createElement("option");
			option.value = day;
			option.textContent = day;
			misDayDropdown.appendChild(option);
		}
		if (misMonth === misCurrentMonth && misYear === misEndYear && misCurrentDay <= misDaysInMonth) {
			misDayDropdown.value = misCurrentDay-1;
		}
		misUpdateSelectedDate();
	}

	function misUpdateSelectedDate() {
		const misYear = document.getElementById("misYear").value;
		const misMonth = document.getElementById("misMonth").value;
		const misDay = document.getElementById("misDay").value;

		if (misYear && misMonth && misDay) {
			const misFormattedDate = `${String(misMonth).padStart(2, '0')}\/${String(misDay).padStart(2, '0')}\/${misYear}`;
			
			// Select all input fields with class "datepicker" and set the value
			const datepickers = document.querySelectorAll(".cdatepicker");
			datepickers.forEach((input) => {
				input.value = misFormattedDate;
			});
		}
	}

	window.onload = function() {
		document.getElementById("misMonth").value = misCurrentMonth;
		misUpdateDays();
		document.getElementById("misDay").addEventListener("change", misUpdateSelectedDate);
	};
</script>


</body>
</html>
<%
set rs=Nothing
rs.close()


set rs2=Nothing
rs2.close()

set rs3=Nothing
rs3.close()

set maxid=Nothing
maxid.close()

set dcc=Nothing
dcc.close()

set in_invoices=Nothing
in_invoices.close()

set in_orders=Nothing
in_orders.close()

set chk_entry_exit=Nothing
chk_entry_exit.close()


set role_rs=Nothing
role_rs.close()

set rsDist=Nothing
rsDist.close()

set rsPrd=Nothing
rsPrd.close()

set rsSsr=Nothing
rsSsr.close()

set rsDist_recs=Nothing
rsDist_recs.close()

set rsPeriod=Nothing
rsPeriod.close()

set Area=Nothing
rsArea.close()

set ifful=Nothing
ifful.close()

set rs_adda=nothing
rs_adda.close()

set rs_gt=Nothing
rs_gt.close()

set rs_order=Nothing
rs_order.close()

set rs_st=Nothing
rs_st.close()

set rs_value=Nothing
rs_value.close()

set rs_fdate=Nothing
rs_fdate.close()

set rsDist_recs=Nothing
rsDist_recs.close()


%>