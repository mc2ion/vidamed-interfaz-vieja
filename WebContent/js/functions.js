function addRowForChild(tableId) {
	var tblObj = document.getElementById(tableId);
	var tblObjBotonera = document.getElementById('botonP');

var no_of_rows = tblObj.rows.length;

// to make visible of the header row of the table , if the table has atleast one row
if(no_of_rows==1){
     tblObj.style.visibility="visible";
 tblObjBotonera.style.display="inline";
}
// to insert one row of the table
    var row_in_table = tblObj.insertRow(no_of_rows);
   
//to insert the first column (for SNO)
 var column1 = row_in_table.insertCell(0);
 column1.style.textAlign='center';
 
  if (no_of_rows==1)  
     var rno=1;
 else
    var rno=eval(tblObj.rows[no_of_rows-1].cells[0].innerHTML) +1;
  
  column1.innerHTML = rno;
//to insert the second column (for textbox to accept name)
var column2 = row_in_table.insertCell(1);
var element2 = document.createElement("select");
element2.setAttribute("name", "nameChild"); //to set name of the text box
element2.style.width="100%";
var option = document.createElement("option");
element2.options[0] = new Option("Seleccionar", "-");
element2.options[1] = new Option("Ibuprofeno", 1);
element2.options[2] = new Option("Acetaminofen", 2);
element2.options[3] = new Option("Morfina", 2);
            column2.appendChild(element2);
            
            
 //to insert the second column (for textbox to accept age)
var column3 = row_in_table.insertCell(2);
var element3 = document.createElement("input");
element3.setAttribute("name", "ageChild");
element3.setAttribute("size", "4");
column3.style.textAlign='center';
element3.type = "text";
column3.appendChild(element3);


// to insert the fifth column (for check box )           
var column4 = row_in_table.insertCell(3);
column4.style.textAlign='center';
 var element4 = document.createElement("input");
element4.type="checkbox";
column4.appendChild(element4);
 }




function deleteRowChild(tableId) {
	var tblObj = document.getElementById(tableId);
	var tblObjBotonera = document.getElementById('botonP');

	var no_of_rows = tblObj.rows.length;
	var i=0;
	while (i<no_of_rows)
	
	{
		var row_in_table = tblObj.rows[i];
		var chkbox = row_in_table.cells[3].childNodes[0];
		if( chkbox !=null &&  chkbox.checked==true) {
			tblObj.deleteRow(i);
			no_of_rows--;
			i--;
	
				// to hide the table heading , if there is no row
			if(no_of_rows<=1){ 
				tblObj.style.visibility="hidden";
			tblObjBotonera.style.display='none';
	            	
			}
		}
		i++;
	}
	arrangeSno(tableId);

} 

/** Agrega los doctores en protocolos **/
   
function addRowForDoctor(tableId) {
	var tblObj = document.getElementById(tableId);
	
	var no_of_rows = tblObj.rows.length;

	// to make visible of the header row of the table , if the table has atleast one row
	if(no_of_rows==1){
	     tblObj.style.visibility="visible";
	}
	
	// to insert one row of the table
    var row_in_table = tblObj.insertRow(no_of_rows);
   
   	
	//to insert the second column (for textbox to accept name)
	var column1 = row_in_table.insertCell(0);
	var element1 = document.createElement("select");
	element1.setAttribute("name", "personalType"); //to set name of the text box
	element1.setAttribute("id", "personalType" + no_of_rows); //to set name of the text box
	element1.style.width="100%";
	var option = document.createElement("option");
	element1.options[0] = new Option("Seleccionar", "-");
	element1.options[1] = new Option("Cirujano Ayudante", 1);
	element1.options[2] = new Option("Anestesiologo", 2);
	element1.options[3] = new Option("Instrumentista", 3);
	element1.options[4] = new Option("Enfermera Circulante", 4);
	element1.setAttribute("onchange", "changePrice("+ no_of_rows+");");
    column1.appendChild(element1);
    
	 //to insert the second column (for textbox to accept age)
	var column3 = row_in_table.insertCell(1);
	var element1 = document.createElement("select");
	element1.setAttribute("name", "cedType"); //to set name of the text box
	var option = document.createElement("option");
	element1.options[0] = new Option("V", "V-");
	element1.options[1] = new Option("E", "E-");
	column3.appendChild(element1);
	var element3 = document.createElement("input");
	element3.setAttribute("name", "personalCed");
	element3.setAttribute("size", "20");
	element3.type = "text";
	column3.appendChild(element3);
	
	 //to insert the second column (for textbox to accept age)
	var column3 = row_in_table.insertCell(2);
	column3.innerHTML = "Bs. ";
	var element3 = document.createElement("input");
	element3.setAttribute("name", "personalPrice");
	element3.setAttribute("id", "personalPrice" + no_of_rows );
	element3.setAttribute("size", "20");
	element3.type = "text";
	column3.appendChild(element3);

	// to insert the fifth column (for check box )           
	var column4 = row_in_table.insertCell(3);
	var element4 = document.createElement("input");
	element4.type="checkbox";
	column4.appendChild(element4);
		
	
 }

function deleteRowForDoctor(tableId) {
	var tblObj = document.getElementById(tableId);
	
	var no_of_rows = tblObj.rows.length;
	var i=0;
	while (i<no_of_rows)
	{
		var row_in_table = tblObj.rows[i];
		var chkbox = row_in_table.cells[3].childNodes[0];
		if( chkbox !=null &&  chkbox.checked==true) {
			tblObj.deleteRow(i);
			no_of_rows--;
			i--;
	
		// to hide the table heading , if there is no row
			if(no_of_rows<=1){ 
				tblObj.style.visibility="hidden";
				tblObjBotonera.style.display='none';
			}
		}
	i++;
	}
	arrangeSno(tableId);

} 

function changePrice(id){
	if ($("#personalType" + id).val() == 1)
		$('#personalPrice' + id).val("6521");
	else if ($("#personalType" + id).val() == 2)
		$('#personalPrice' + id).val("4376");
	else if ($("#personalType" + id).val() == 3)
		$('#personalPrice' + id).val("2376");
	else if ($("#personalType" + id).val() == 4)
		$('#personalPrice' + id).val("2100");
}