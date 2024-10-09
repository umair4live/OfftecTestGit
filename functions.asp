

// This is only for the command for the local as well as for the online changes.
// This is only for the command for the local as well as for the online changes.


<script language="javascript">
function PreLoadWait()
{
if (document.getElementById) {  // DOM3 = IE5, NS6
document.getElementById('hidepage').style.visibility = 'hidden';
}
else
{
if (document.layers) {  // Netscape 4
document.hidepage.visibility = 'hidden';
}
else
{  // IE 4
document.all.hidepage.style.visibility = 'hidden';
}
}
}




function onlynumbers(e,name){
if(isNaN(e)){
alert('Only Numeric Entry');
document.getElementById(name).focus();
document.getElementById(name).value=0;
document.getElementById(name).style.background = "#FFFFCC";
return false;}   
}     

                        
function autoComplete (field, select, property, forcematch) {
	var found = false;
	for (var i = 0; i < select.options.length; i++) {
	if (select.options[i][property].toUpperCase().indexOf(field.value.toUpperCase()) == 0) {
		found=true; break;
		}
	}
	if (found) { select.selectedIndex = i; }
	else { select.selectedIndex = -1; }
	if (field.createTextRange) {
		if (forcematch && !found) {
			field.value=field.value.substring(0,field.value.length-1); 
			return;
			}
		var cursorKeys ="8;46;37;38;39;40;33;34;35;36;45;";
		if (cursorKeys.indexOf(event.keyCode+";") == -1) {
			var r1 = field.createTextRange();
			var oldValue = r1.text;
			var newValue = found ? select.options[i][property] : oldValue;
			if (newValue != field.value) {
				field.value = newValue;
				var rNew = field.createTextRange();
				rNew.moveStart('character', oldValue.length) ;
				rNew.select();
				}
			}
		}
	}



if (document.all)
{  
document.onkeydown = function ()
	{  
var key_f5 = 116; // 116 = F5  

if (key_f5==event.keyCode){  
event.keyCode = 2;  

return false;  
	}  
	}  
}  


function numbersonly(e){
var unicode=e.charCode? e.charCode : e.keyCode
if (unicode!=8){ //if the key isn't the backspace key (which we should allow)
if (unicode<48||unicode>57) //if not a number
return false //disable key press
}
}


	var ValueArray = new Array();
	var BonusArray = new Array();
	var BonusSch = new Array();
	var BonusUnits = new Array();
	var PType = new Array();
	var iType = new Array();
	var tot = new Array();
	var packing = new Array();
	var prdid = new Array();
	var distid= new Array();
	var PStatus= new Array();

	function MisCalculateTotal(){
	TotalVal = 0;
	for (i=1; i<=ValueArray.length-1; i++)
	{
		val = Math.round(document.getElementById("tdValue"+i).value,0);
		if (PType[i]!=5 && val!="" && val!=0){
			TotalVal += parseInt(val);
			}
		}
	document.new_order_form.ordervalue_1.value = TotalVal;
	document.getElementById("tdordervalue_1").innerHTML = TotalVal;

//********************************** FOR NON PROMOTIONAL TOTAL************************	
	TotalVal2 = 0;
	for (i=1; i<=ValueArray.length-1; i++)
	{
		val2 = Math.round(document.getElementById("tdValue"+i).value,0);
		if (PType[i]!=1 && val2!="" && val2!=0){
			TotalVal2 += parseInt(val2);
			}
		
	}
	document.new_order_form.ordervalue_2.value = TotalVal2;
	document.getElementById("tdordervalue_2").innerHTML = TotalVal2;

//********************************** FOR GRAND TOTAL************************	
	TotalVal3 = 0;
	for (i=1; i<=ValueArray.length-1; i++)
	{
		val3 = Math.round(document.getElementById("tdValue"+i).value,0);
		if (val3!="" && val3!=0){
			TotalVal3 += parseInt(val3);
			}
		
	}
	document.new_order_form.ordervalue_3.value = TotalVal3;
	document.getElementById("tdordervalue_3").innerHTML = TotalVal3;
}
function MisCalculate(unit, index) {
	    //stamp()

	    // ap stand for Actual Price/ Value
		//alert(abase);
	    var ap = 0
	    ap = Math.round((unit * ValueArray[index]) * 100) / 100;
	    // dp stand for Discounted Price/ Value
	    var dp = 0
	    dp = Math.round((unit * BonusArray[index]) * 100) / 100;
	    // bs stand for Bonus Scheme
	    var bs
	    bs = Math.round(((unit / BonusSch[index]) * BonusUnits[index]) * 100) / 100;

	    var bten = Math.round(((unit / 100) * 10) * 100) / 100;
	    // du stand for Discounted unit/ Packs
	    var du = 0
	    du = Math.round((dp / ValueArray[index]) * 100) / 100;

	    var dv = Math.round((Math.round(du, 0) * ValueArray[index]) * 100) / 100;
	    var eval = du * ValueArray[index]
			
		
	    // au stand for Actual unit/ Packs
	    var au = 0
	    au = unit
	    // bu stand for Bonus unit/ Packs bonusvalue
	    var bu = 0
	    bu = Math.round(unit - du, 0)
	    var bum = 0
	    bum = Math.round(unit - bu, 0)
	    // br stand for Bonus Rate
	    var br = 0
	    br = BonusArray[index]

		
// Umair Working for calculate total value for the base units

		var aunit, abonus, m
			
	        var Umbase = BonusSch[index]+0;
			
	        var UmBonus = BonusUnits[index]+0;
	
			var UMTotal = parseInt(Umbase) + parseInt(UmBonus);
			var UMRatio = UMTotal/100; 
		
	        m = unit % BonusSch[index];
	        //aunit=unit-m
	        //abonus=unit/BonusUnits[index]
	        abonus = unit / BonusSch[index] * BonusUnits[index];
			//alert(abonus);
	        Originalabase = (unit / (BonusSch[index] + BonusUnits[index]))*(BonusSch[index]);
	        abase = unit / UMTotal * parseInt(Umbase);
	       // alert(abase);
	         abonus = unit / UMTotal * parseInt(UmBonus);	
			 //alert(abonus);
			 
			 ap = Math.round((Math.round(abase) * ValueArray[index]) * 100) / 100;

		

	    if (BonusArray[index] > 0 && unit > 0) {
	

	        //document.getElementById("tdValue"+index).value = Math.round(dv);
	        document.getElementById("tdValue" + index).value = Math.round(eval);
	        document.getElementById("pvalue" + index).innerHTML = Math.round(eval);
			

	        document.getElementById("bonus_disc" + index).value = au + " Packs" + " @ " + br + " /Pack (" + Math.round(du, 0) + " Packs + " + bu + " Bonus )";
	        document.getElementById("unit_"+index).value = Math.round(du,0);
	        if (event.keyCode == 13) event.keyCode = 9;
	    }
	    else {
		

	        document.getElementById("bonus_disc" + index).value = "";
	        document.getElementById("tdValue" + index).value = "";
	        if (event.keyCode == 13) event.keyCode = 9;
	    }
	    if (BonusArray[index] <= 0 && unit >= 0) {
			
			document.getElementById("tdunit" + index).value = Math.round(abase);
	        document.getElementById("tdbonus" + index).value = Math.round(abonus);
	        document.getElementById("tdValue" + index).value = Math.round(ap);
	        document.getElementById("pvalue" + index).innerHTML = Math.round(ap);
	        if (event.keyCode == 13) event.keyCode = 9;
	        //CalculateTotal();
	    }

	    /*	if (BonusUnits[index]>0 && PStatus[index]=='OPEN' && unit>=BonusSch[index] )*/
	    if (BonusUnits[index] > 0 && PStatus[index] == 'OPEN' && unit >= 3) {
				       
	        document.getElementById("tdunit" + index).value = Math.round(abase);
	        document.getElementById("tdbonus" + index).value = Math.round(abonus);
		document.getElementById("tdunitv" + index).value = Math.round(abase);
		document.getElementById("tdbonusv" + index).value = Math.round(abonus);


			
	         var cheda = document.getElementById("unit_" + index).value;
			
	        document.getElementById("pbonus" + index).innerHTML = Math.round(abonus);
	        if  (event.keyCode == 13) event.keyCode = 9;
	        //document.getElementById("bonus_disc"+index).value = "Bonus Pack "+abonus ;
	    }

	    if (BonusUnits[index] > 0 && PStatus[index] == 'OPEN' && unit <= 2) {
//	        alert("less unit")
	        document.getElementById("pbonus" + index).innerHTML = 0;
	        document.getElementById("tdbonus" + index).value = 0;
	        if (event.keyCode == 13) event.keyCode = 9;
	        //document.getElementById("bonus_disc"+index).value = "Bonus Pack "+abonus ;
	    }

		
	    //Bonus for Greater then 500 units
	    //	if (BonusSch[index]=100)
	    //{
	    //var m=mod(150,100);

	    //var boneh =Math.round(((unit/500)*75));
	    //document.getElementById("tdbonus"+index).value = Math.round( bfive);
	    //}
	    // Bonus for less then 500 units

	    //if (BonusSch[index]=100 && unit>0 && unit<500)
	    //{
	    //document.getElementById("tdbonus"+index).value = Math.round(bten);
	    //}
	    var in_val, show_unit, bonus_unit, disc_rate, stockist;

	    disc_rate = 0;
	    in_val = 0;
	    show_unit = 0;
	    bonus_unit = 0;
	    disc_rate = document.getElementById("insti_price_" + index).value;
		stockist = document.getElementById("stockist").value;
		
//alert("called 1st");
	    if (disc_rate > 0 && unit > 0 && stockist == 'D') {
//		alert(unit);
	        in_val = disc_rate * Math.round(unit);
//			alert(disc_rate );
	        show_unit_actual = in_val / ValueArray[index];
			show_unit = in_val / ValueArray[index];
//			alert(show_unit+"- "+ValueArray[index]);
			show_unit=Math.round(show_unit);
//			alert(show_unit);
	        bonus_unit = unit - Math.round(show_unit, 0);
	        in_val=ValueArray[index]*show_unit;
			var base_unit_variance=show_unit_actual-show_unit;
			var variance = Math.round(base_unit_variance*100)/100;
			var base_value_variance=Math.round(disc_rate*variance); 

//			alert(in_val2);
			
	        document.getElementById("unit_" + index).value = Math.round(show_unit, 0);
	        document.getElementById("tdValue" + index).value = Math.round(in_val,1);
	        document.getElementById("pvalue" + index).innerHTML = Math.round(in_val);
	        document.getElementById("tdbonus" + index).value = bonus_unit;
	        document.getElementById("pbonus" + index).innerHTML = bonus_unit;
	        document.getElementById("bonus_disc" + index).value = +unit + " Packs" + " @" + disc_rate + " (" + Math.round(show_unit, 0) + "base + " + bonus_unit + "bonus)";
			document.getElementById("narrative_" + index).value = +variance + " base x " + disc_rate + " = Rs." + base_value_variance;
	        //CalculateTotal();
	    }

	    // for stokist		
	    var perage, dp;

	    perage = document.getElementById("perage").value;

	    if (stockist == 'S' && unit > 0 && disc_rate > 0 && perage > 0) {
		alert("less unit")
	        disc_rate = document.getElementById("insti_price_" + index).value;
	        dp = disc_rate - ((perage / 100) * disc_rate);

	        bunits = unit / BonusSch[index] * BonusUnits[index];
	        st_val = dp * unit;
	        show_unit = st_val / ValueArray[index];

	        document.getElementById("price_" + index).value = Math.round(dp * 100) / 100;
	        document.getElementById("tdValue" + index).value = Math.round(st_val);
	        document.getElementById("pvalue" + index).innerHTML = Math.round(st_val);
	        document.getElementById("tdbonus" + index).value = bunits;
	        document.getElementById("pbonus" + index).innerHTML = bunits;

	    }


	}
		
			
	
function alt(){
alert("Please Select Area Name , Distributor and Institutional if any ");
}

function CalculateTotal(){
	TotalVal = 0;
	for (i=1; i<=ValueArray.length-1; i++)
	{
		val = Math.round(document.getElementById("tdValue"+i).value,0);
		if (PType[i]!=5 && val!="" && val!=0){
			TotalVal += parseInt(val);
			}
		}
	document.new_order_form.ordervalue_1.value = TotalVal;
	document.getElementById("tdordervalue_1").innerHTML = TotalVal;

//********************************** FOR NON PROMOTIONAL TOTAL************************	
	TotalVal2 = 0;
	for (i=1; i<=ValueArray.length-1; i++)
	{
		val2 = Math.round(document.getElementById("tdValue"+i).value,0);
		if (PType[i]!=1 && val2!="" && val2!=0){
			TotalVal2 += parseInt(val2);
			}
		
	}
	document.new_order_form.ordervalue_2.value = TotalVal2;
	document.getElementById("tdordervalue_2").innerHTML = TotalVal2;

//********************************** FOR GRAND TOTAL************************	
	TotalVal3 = 0;
	for (i=1; i<=ValueArray.length-1; i++)
	{
		val3 = Math.round(document.getElementById("tdValue"+i).value,0);
		if (val3!="" && val3!=0){
			TotalVal3 += parseInt(val3);
			}
		
	}
	document.new_order_form.ordervalue_3.value = TotalVal3;
	document.getElementById("tdordervalue_3").innerHTML = TotalVal3;
}

//========================================== INSTITUTIONAL TOTAL==================
function CalculateTotal2(){
	TotalVal = 0;
	for (i=1; i<=PType.length-1; i++)
	{
		val = Math.round(document.getElementById("tdValue"+i).value,0);
		if (PType[i]!=5 && val!="" && val!=0){
			TotalVal += parseInt(val);
			}
		}
	//document.new_order_form.ordervalue_1.value = TotalVal;
	//document.getElementById("tdordervalue_1").innerHTML = TotalVal;

//********************************** FOR NON PROMOTIONAL TOTAL************************	
	TotalVal2 = 0;
	for (i=1; i<=PType.length-1; i++)
	{
		val2 = Math.round(document.getElementById("tdValue"+i).value,0);
		if (PType[i]!=1 && val2!="" && val2!=0){
			TotalVal2 += parseInt(val2);
			}
		
	}
	//document.new_order_form.ordervalue_2.value = TotalVal2;
	//document.getElementById("tdordervalue_2").innerHTML = TotalVal2;

//********************************** FOR GRAND TOTAL************************	
	TotalVal3 = 0;
	for (i=1; i<=PType.length-1; i++)
	{
		val3 = Math.round(document.getElementById("tdValue"+i).value,0);
		if (val3!="" && val3!=0){
			TotalVal3 += parseInt(val3);
			}
		
	}
	document.new_order_form.ordervalue_3.value = TotalVal3;
	document.getElementById("tdordervalue_3").innerHTML = TotalVal3;
}

//============================================================= for Dextorse Total===========
	function dxtotal(){
	TotalVal3 = 0;
	for (i=1; i<=PType.length-1; i++)
	{
		val3 = Math.round(document.getElementById("tdValue"+i).value,0);
		if (val3!="" && val3!=0){
			TotalVal3 += parseInt(val3);
			}
		
	}
	document.new_order_form.ordervalue_3.value = TotalVal3;
	document.getElementById("tdordervalue_3").innerHTML = TotalVal3;
	}
	
//============================================================= for UNIT ENTRY CHECKS AND CONVERSION ===========
	var i=0;
	
	
	function stamp()
	{
		
		if (i==0)
		{
//		alert(i);
		i=i+1;
		var md = new Date();
		var month = md.getMonth()+ 1
		var day = md.getDate()
		var year = md.getFullYear()
		var h= md.getHours()
		var m= md.getMinutes()
		var s=md.getSeconds()
		   
		//document.write(month + "/" + day + "/" + year)

		document.new_order_form.feedDate.value=month + "/" + day + "/" + year+" "+h+":"+m+":"+s ;
		document.getElementById("feedDate").innerHTML=month + "/" + day + "/" + year+" "+h+":"+m+":"+s ;
		
		}
	
	}
	function Calculate(unit, index) {
	    //stamp()

	    // ap stand for Actual Price/ Value
		//alert(abase);
	    var ap = 0
	    ap = Math.round((unit * ValueArray[index]) * 100) / 100;
	    // dp stand for Discounted Price/ Value
	    var dp = 0
	    dp = Math.round((unit * BonusArray[index]) * 100) / 100;
	    // bs stand for Bonus Scheme
	    var bs
	    bs = Math.round(((unit / BonusSch[index]) * BonusUnits[index]) * 100) / 100;

	    var bten = Math.round(((unit / 100) * 10) * 100) / 100;
	    // du stand for Discounted unit/ Packs
	    var du = 0
	    du = Math.round((dp / ValueArray[index]) * 100) / 100;

	    var dv = Math.round((Math.round(du, 0) * ValueArray[index]) * 100) / 100;
	    var eval = du * ValueArray[index]
			
		
	    // au stand for Actual unit/ Packs
	    var au = 0
	    au = unit
	    // bu stand for Bonus unit/ Packs bonusvalue
	    var bu = 0
	    bu = Math.round(unit - du, 0)
	    var bum = 0
	    bum = Math.round(unit - bu, 0)
	    // br stand for Bonus Rate
	    var br = 0
	    br = BonusArray[index]

		
// Umair Working for calculate total value for the base units

		var aunit, abonus, m
			
	        var Umbase = BonusSch[index]+0;
			
	        var UmBonus = BonusUnits[index]+0;
	
			var UMTotal = parseInt(Umbase) + parseInt(UmBonus) 

	        m = unit % BonusSch[index];
	        //aunit=unit-m
	        //abonus=unit/BonusUnits[index]
	        abonus = unit / BonusSch[index] * BonusUnits[index];
	        Originalabase = (unit / (BonusSch[index] + BonusUnits[index]))*(BonusSch[index]);
	        abase = unit / UMTotal * parseInt(Umbase);
	      //  alert(abase);
	         abonus = unit / UMTotal * parseInt(UmBonus);	
			 
			 ap = Math.round((Math.round(abase) * ValueArray[index]) * 100) / 100;


	    if (BonusArray[index] > 0 && unit > 0) {

	        //document.getElementById("tdValue"+index).value = Math.round(dv);
	        document.getElementById("tdValue" + index).value = Math.round(eval);
	        document.getElementById("pvalue" + index).innerHTML = Math.round(eval);
	        document.getElementById("bonus_disc" + index).value = au + " Packs" + " @ " + br + " /Pack (" + Math.round(du, 0) + " Packs + " + bu + " Bonus )";
	        document.getElementById("unit_"+index).value = Math.round(du,0);
	        if (event.keyCode == 13) event.keyCode = 9;
	    }
	    else {
	        document.getElementById("bonus_disc" + index).value = "";
	        document.getElementById("tdValue" + index).value = "";
	        if (event.keyCode == 13) event.keyCode = 9;
	    }
	    if (BonusArray[index] <= 0 && unit >= 0) {
	        document.getElementById("tdValue" + index).value = Math.round(ap);
	        document.getElementById("pvalue" + index).innerHTML = Math.round(ap);
	        if (event.keyCode == 13) event.keyCode = 9;
	        //CalculateTotal();
	    }

	    /*	if (BonusUnits[index]>0 && PStatus[index]=='OPEN' && unit>=BonusSch[index] )*/
	    if (BonusUnits[index] > 0 && PStatus[index] == 'OPEN' && unit >= 3) {
	       
	        document.getElementById("tdunit" + index).value = Math.round(abase);
	        document.getElementById("tdbonus" + index).value = Math.round(abonus);
			
	         var cheda = document.getElementById("unit_" + index).value;
			
	        document.getElementById("pbonus" + index).innerHTML = Math.round(abonus);
	        if  (event.keyCode == 13) event.keyCode = 9;
	        //document.getElementById("bonus_disc"+index).value = "Bonus Pack "+abonus ;
	    }

	    if (BonusUnits[index] > 0 && PStatus[index] == 'OPEN' && unit <= 2) {
//	        alert("less unit")
	        document.getElementById("pbonus" + index).innerHTML = 0;
	        document.getElementById("tdbonus" + index).value = 0;
	        if (event.keyCode == 13) event.keyCode = 9;
	        //document.getElementById("bonus_disc"+index).value = "Bonus Pack "+abonus ;
	    }

		
	    //Bonus for Greater then 500 units
	    //	if (BonusSch[index]=100)
	    //{
	    //var m=mod(150,100);

	    //var boneh =Math.round(((unit/500)*75));
	    //document.getElementById("tdbonus"+index).value = Math.round( bfive);
	    //}
	    // Bonus for less then 500 units

	    //if (BonusSch[index]=100 && unit>0 && unit<500)
	    //{
	    //document.getElementById("tdbonus"+index).value = Math.round(bten);
	    //}
	    var in_val, show_unit, bonus_unit, disc_rate, stockist;

	    disc_rate = 0;
	    in_val = 0;
	    show_unit = 0;
	    bonus_unit = 0;
	    disc_rate = document.getElementById("insti_price_" + index).value;
		stockist = document.getElementById("stockist").value;
		
//alert("called 1st");
	    if (disc_rate > 0 && unit > 0 && stockist == 'D') {
//		alert(unit);
	        in_val = disc_rate * Math.round(unit);
//			alert(disc_rate );
	        show_unit_actual = in_val / ValueArray[index];
			show_unit = in_val / ValueArray[index];
//			alert(show_unit+"- "+ValueArray[index]);
			show_unit=Math.round(show_unit);
//			alert(show_unit);
	        bonus_unit = unit - Math.round(show_unit, 0);
	        in_val=ValueArray[index]*show_unit;
			var base_unit_variance=show_unit_actual-show_unit;
			var variance = Math.round(base_unit_variance*100)/100;
			var base_value_variance=Math.round(disc_rate*variance); 

//			alert(in_val2);
			
	        document.getElementById("unit_" + index).value = Math.round(show_unit, 0);
	        document.getElementById("tdValue" + index).value = Math.round(in_val,1);
	        document.getElementById("pvalue" + index).innerHTML = Math.round(in_val);
	        document.getElementById("tdbonus" + index).value = bonus_unit;
	        document.getElementById("pbonus" + index).innerHTML = bonus_unit;
	        document.getElementById("bonus_disc" + index).value = +unit + " Packs" + " @" + disc_rate + " (" + Math.round(show_unit, 0) + "base + " + bonus_unit + "bonus)";
			document.getElementById("narrative_" + index).value = +variance + " base x " + disc_rate + " = Rs." + base_value_variance;
	        //CalculateTotal();
	    }

	    // for stokist		
	    var perage, dp;

	    perage = document.getElementById("perage").value;

	    if (stockist == 'S' && unit > 0 && disc_rate > 0 && perage > 0) {
		alert("less unit")
	        disc_rate = document.getElementById("insti_price_" + index).value;
	        dp = disc_rate - ((perage / 100) * disc_rate);

	        bunits = unit / BonusSch[index] * BonusUnits[index];
	        st_val = dp * unit;
	        show_unit = st_val / ValueArray[index];

	        document.getElementById("price_" + index).value = Math.round(dp * 100) / 100;
	        document.getElementById("tdValue" + index).value = Math.round(st_val);
	        document.getElementById("pvalue" + index).innerHTML = Math.round(st_val);
	        document.getElementById("tdbonus" + index).value = bunits;
	        document.getElementById("pbonus" + index).innerHTML = bunits;

	    }


	}
		
		
		

//===================================================================================================================================================================================================================
// calculation only for EXPORT ORDERS

function export_total(unit,index){

var units_txt	=document.getElementById("unit_"+index);
var price=document.getElementById("price_"+index).value ;
var price_txt	=document.getElementById("price_"+index);

if(isNaN(unit) || isNaN(price))

{
alert('Only Numeric Entry');
units_txt.focus();
document.getElementById("unit_"+index).value=0;
document.getElementById("price_"+index).value=0;
units_txt.style.background = "#FFFFCC";  
price_txt.style.background = "#FFFFCC";  
return false;
}
else
{
				
	unt=document.getElementById("unit_"+index).value;
	
	// if packing empty
	val = price * unit;
	document.getElementById("tdValue"+index).value = Math.round(val);
	document.getElementById("pvalue"+index).innerHTML = Math.round(val);	

}
					
		}
// calculation only for Institutional Orders
function price_Calc_i(unit,index){
stamp()
		document.getElementById("prd_remarks"+index).value ="";
			var price,val,ur,act_u,pr,dsc,ads,unt
			pr="";
					price=0;
					pck=document.getElementById("pack_"+index).value;
					
					unt=document.getElementById("unit_"+index).value;
					price=document.getElementById("price_"+index).value 
					pr=document.getElementById("prd_remarks"+index).value 
					dsc=document.getElementById("d_"+index).value 
					// if packing empty
					val = price * unit

					
					document.getElementById("tdValue"+index).value = Math.round(val);
					//document.getElementById("bonus_disc"+index).value = "Actual Order is "+au+" Packs"+" @ "+br+" per Pack ("+Math.round(du,0)+" Packs + "+bu+" Bonus )";
		
		// if discounted
		if (dsc>0)
		{
		
		ads=val-((dsc/100)*val)
			ads2=price-((dsc/100)*price)
				ur=ads2*packing[index];
					act_u=unit/packing[index];
					document.getElementById("unit_"+index).value = Math.round(act_u,2);
				document.getElementById("price_"+index).value = ur;
			document.getElementById("tdValue"+index).value = Math.round(ads);
		document.getElementById("prd_remarks"+index).value = unit+" Units"+" @ Rs. "+price+" (Pack Size: "+packing[index]+" ) @ "+pr+dsc+"% Discounted";
		
		}
		
		
		// if packing >0 
		if (pck>0 && unit>0 && dsc<=0)
		{
		ur=price*pck;
			act_u=unit/pck;
				document.getElementById("unit_"+index).value = Math.round(act_u,2);
			document.getElementById("price_"+index).value = ur;
		document.getElementById("prd_remarks"+index).value = unit+" Units"+" @ Rs "+price+" (Pack Size: "+pck+" ) "+pr;
		}
		
		
		if (pck>0 && distid[index]==138 && prdid[index]==163)
		{
		ur=price*5;
			act_u=unit/5;
				document.getElementById("unit_"+index).value = Math.round(act_u,2);
			document.getElementById("price_"+index).value = ur;
		document.getElementById("prd_remarks"+index).value = unit+" Units"+" @ Rs."+price+" (Pack Size: "+5+" ) "+pr;
		}
		
					
		}


 // calculation only for DX and SP Orders
  function price_Calc(unit,index)
 
 {
 stamp()
			var price,val,ur,act_u
			price=document.getElementById("price_"+index).value 
			val=price*unit
			document.getElementById("tdValue"+index).value = Math.round(val);
					
  }
  
function Action()
{	
	document.new_order_form.action = 'empty_product_in_order.asp';
	document.new_order_form.submit;  
}
function Action2()
{	
	document.new_order_form.action = '../replacment/empty_product_in_order_rplc.asp';
	document.new_order_form.submit;  
}	
		
function tes(){
	var userName
		userName = prompt("Please enter your name", "")
	document.write("Hello " + userName + " welcome to my page.")
}



function expandcontract(tbodyid,ClickIcon) {
	if (document.getElementById(ClickIcon).innerHTML == "+")
	{
		document.getElementById(tbodyid).style.display = "";
		document.getElementById(ClickIcon).innerHTML = "-";
	} 
		else
		{
			document.getElementById(tbodyid).style.display = "none";
			document.getElementById(ClickIcon).innerHTML = "+";
		}
		
		}

function confirmSubmit()	{
			var agree=confirm("Are you sure you want to VIEW this order?");
		if (agree==true)
					return true ;
			else
					return false ;
}
// ###############################################
// #################### EDIT ORDER
function edit()
{
var agree=confirm("Are you sure you want to EDIT this order?");

if (agree==true)

	return true ;
else
	return false ;
}

// ###############################################
// #################### CANCEL ORDER
function cancel()
{
var agree=confirm("Are you sure you want to CANCEL this order? Clik OK to Proceed");

if (agree)

	return true ;
else
	return false ;
}
// ###############################################
// #################### ON CHANGE DROP DOWN
function OnChange(dropdown)

{
    var myindex  = dropdown.selectedIndex;
    var SelValue = dropdown.options[myindex].value;
    alert(selValue);
    return true;
}


function AD()
{
	if(document.DropDown.reason[0].checked == true)
	 {
		document.DropDown.action = 'index.ASP';
	 }
	 
	if(document.DropDown.reason[1].checked == true) 
	{
		document.DropDown.action = 'new_order.asp';
		document.DropDown.method = 'post';
	}
	
	if(document.DropDown.reason[2].checked == true)
	{
		document.DropDown.action = 'http://yahoo.com';
	}
	
return true;
}
// -->

function toggle(theDiv)
  
  {
		var elem = document.getElementById(theDiv);
		elem.style.display = (elem.style.display == "none")?"":"none";
  }


function ac(form,orders)

{		
		var radio2
		var val=form.AreaID.options[form.AreaID.options.selectedIndex].value;
		self.location='orders_searching.asp?radio2=' + orders + '&AreaID='+val ;
}	

count=0

		
function reload(form)

{
		var val=form.dept.options[form.dept.options.selectedIndex].value;
		self.location='main_page.asp?dept=' + val ;

}

function reload2(form)

{
		var val=form.dept2.options[form.dept2.options.selectedIndex].value;
		self.location='main_page.asp?dept2=' + val ;

}

function reload3(form)

{
		var val=form.dept3.options[form.dept3.options.selectedIndex].value;
		self.location='main_page.asp?dept3=' + val ;

}

function reload4(form)

{
		var val=form.dept4.options[form.dept4.options.selectedIndex].value;
		self.location='main_page.asp?dept4=' + val ;
}

function reload5(form)

{
		var val=form.dept5.options[form.dept5.options.selectedIndex].value;
		self.location='main_page.asp?dept5=' + val ;

}
function refreshfrm(form){

//alert("you are going to assign Bonus Scheme of "+form);
var val=form.bsch.options[form.bsch.options.selectedIndex].value;
		self.location='index.asp?bsch=' + val ;

	
}
// open window with argument
function ow(val)
{
window.open('viewOrder.asp?radio1=' + val , "DEVELOPER", "toolbar=no,directories=no,status=no,menubar=no, scrollbars=yes,resizable=yes,copyhistory=no")
}

function owrpt(val)
{
window.open('../ordery/viewOrder.asp?radio1=' + val , "DEVELOPER", "toolbar=no,directories=no,status=no,menubar=no, scrollbars=yes,resizable=yes,copyhistory=no")
}

function owp(val)
{
window.open('pendingDetail.asp?pdetail=' + val , "DEVELOPER", "location=no,directories=no,status=no,menubar=no, scrollbars=yes,resizable=yes,copyhistory=no")
}

//////////// sorting 
function reSort(val)
{
	if (val==0){document.new_order_form.sortBy.value=11;}
	if (val==11){document.new_order_form.sortBy.value=0;}
	
	document.new_order_form.action='new_order.asp';
	document.new_order_form.submit();
	
}

function reSort4viewselected(val,v)
{
	if (val==0){document.doSort.sortBy.value=11;}
	if (val==11){document.doSort.sortBy.value=0;}
	
	self.location='viewOrder4selected.asp?orderNumber=' +v+ '&sortBy='+val ;

	
	
}
function reSort4view(val,v)
{
	if (val==0){document.doSort.sortBy.value=11;}
	if (val==11){document.doSort.sortBy.value=0;}
	
	self.location='viewOrder.asp?radio1=' +v+ '&sortBy='+val ;

}


//for multiple actoin on radio button selection report index,1-08,1-08b etc
function mulfun()
{
if (document.multy.mlty[0].checked==true)
	{
	document.multy.action="1-08.asp";
	}
	else if (document.multy.mlty[1].checked==true)
	{
		document.multy.action="1-08b.asp";
	}
return true;
}

function isNotQuoteKey(evt)
{
var charCode = (evt.which) ? evt.which : event.keyCode
if (charCode==34 || charCode==39) {/*alert(charCode);*/ return false;}
return true;
}
function isNumberKey(evt)	//Checks if being entered values contain ONLY NUMERIC
{
var charCode = (evt.which) ? evt.which : event.keyCode
if (charCode > 31 && (charCode < 48 || charCode > 57))
return false;

return true;
}

function isNumbersKey(evt)	//Checks if being entered values contains NUMBERS & DECIMAL only
{
var charCode = (evt.which) ? evt.which : event.keyCode
if ((charCode < 46 || charCode > 46) && (charCode < 48 || charCode > 57))
return false;

return true;
}


</script>

