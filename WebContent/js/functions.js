function addRowForChild(tableId, colArray, idArray) {
	count++;
	iaux++;
	
	ies.push(iaux);
	
	document.getElementById('countrows').value = count;
	//alert(ies);
	document.getElementById('activeies').value = ies;
	var tblObj = document.getElementById(tableId);
	var tblObjBotonera = document.getElementById('botonP');
	var no_of_rows = tblObj.rows.length;

	// to make visible of the header row of the table , if the table has atleast one row
	if(no_of_rows==1){
		tblObj.style.visibility="visible";
		//tblObjBotonera.style.display="inline";
	}
	// to insert one row of the table
		var row_in_table = tblObj.insertRow(no_of_rows);
	   
	//to insert the second column (for textbox to accept name)
	var column2 = row_in_table.insertCell(0);
	var element2 = document.createElement("select");
	element2.setAttribute("name", "supply"+iaux);
	element2.setAttribute("id", "supply"+iaux);//to set name of the text box
	element2.style.width="100%";
	var option = document.createElement("option");
	element2.options[0] = new Option("Seleccionar", "-");
	for ( i = 1; i <= colArray.length; i++){
		element2.options[i] = new Option(colArray[i-1], idArray[i-1]);
		
	}
	column2.appendChild(element2);
				
				
	 //to insert the second column
	var column3 = row_in_table.insertCell(1);
	var element3 = document.createElement("input");
	element3.setAttribute("name", "amount"+iaux);
	element3.setAttribute("id", "amount"+iaux);
	element3.setAttribute("size", "4");
	column3.style.textAlign='center';
	element3.type = "text";
	column3.appendChild(element3);


	// to insert the fifth column (for check box )           
	var column4 = row_in_table.insertCell(2);
	column4.style.textAlign='center';
	 var element4 = document.createElement("input");
	element4.type="checkbox";
	column4.appendChild(element4);
 }
 
 




function deleteRowChild(tableId, colArray, idArray) {
	var tblObj = document.getElementById(tableId);
	var tblObjBotonera = document.getElementById('botonP');

	var no_of_rows = tblObj.rows.length;
	var i=0;
	while (i<no_of_rows)
	{
		var row_in_table = tblObj.rows[i];
		var chkbox = row_in_table.cells[2].childNodes[0];
		if( chkbox !=null &&  chkbox.checked==true) {
			tblObj.deleteRow(i);
			var nm = row_in_table.cells[0].childNodes[0].getAttribute('name');
			nm = nm.substring(6);
			var indx = ies.indexOf(parseInt(nm));
			ies.splice(indx,1);
			no_of_rows--;
			i--;
			count--;
			
			document.getElementById('activeies').value = ies;
			document.getElementById('countrows').value = count;
			
			if (row_in_table.cells[0].childNodes[3] != null){
				var id = row_in_table.cells[0].childNodes[3].innerHTML;
				var input = document.createElement("input");
				input.setAttribute("type", "hidden");
				input.setAttribute("name", "deleted");
				input.setAttribute("value", id);
				
				//append to form element that you want .
				document.getElementById("form").appendChild(input);
			}
			//deleted.push(id);
			document.getElementById('countrows').value = count;
			console.log(count);
			// to hide the table heading , if there is no row
			if(no_of_rows<=1){ 
				tblObj.style.visibility="hidden";
			    //tblObjBotonera.style.display='none';
	            	
			}
		}
		i++;
	}
	//arrangeSno(tableId);

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
	element1.options[4] = new Option("Instrumental Especial", 5);
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
	//arrangeSno(tableId);

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