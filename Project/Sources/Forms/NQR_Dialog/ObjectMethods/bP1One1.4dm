C_BOOLEAN:C305($present)
C_LONGINT:C283($column)
C_TEXT:C284($text)
C_TEXT:C284($title;$name)
C_LONGINT:C283($repeat;$hide;$size;$table;$field;$subfield;$type)
C_TEXT:C284($format;$table_name;$field_name;$fieldobj)
C_LONGINT:C283($i;$find)
C_LONGINT:C283($list_field;$t;$ref_field)
C_POINTER:C301($source)


$source:=Focus object:C278  //get the focus object
RESOLVE POINTER:C394($source;$name;$table;$field)  //what is its name
  //set the references based upon the list chosen
Case of 
	: ($name="nqr_lh_field")
		$list_field:=nqr_lh_field
	: ($name="nqr_lh_field_detail")
		$list_field:=nqr_lh_field_detail
	Else   //if the focus is not on a list of fields, take the first object
		$name:="nqr_lh_field"
		$list_field:=nqr_lh_field
End case 

Case of 
	: (Selected list items:C379($list_field)<=0) | (Selected list items:C379($list_field)>Count list items:C380($list_field))
		  //the element is not selected; nothing to make
	: (nqr_cb_5=1)  //we are in the case one column
		$column:=Selected list items:C379($list_field)
		If ($column>0) & ($column<=Count list items:C380($list_field))
			QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
			$find:=Find in array:C230(_nqr_col;$column)
			If ($find<0)
				APPEND TO ARRAY:C911(_nqr_col;$column)
				APPEND TO ARRAY:C911(_nqr_order;1)
				QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
				NQR_List_Get_Sorts 
				NQR_List_Select_Sorts ($t)
				NQR_Select_Column 
			End if 
		End if 
		
	Else   //normal case
		  //get the referebce to the selected element
		GET LIST ITEM:C378($list_field;Selected list items:C379($list_field);$ref_field;$text)
		If ($ref_field>0)  //treat only if it is a field and not a dependent table (which would be negative in reference)
			$table:=($ref_field & 0x00FFFFFF) >> 16  //get the table number
			$field:=$ref_field & 0xFFFF  //get the field number
			$subfield:=$ref_field >> 24  //get the sub field number
			
			Case of 
				: ($field>0) & ($subfield=0)
					$type:=Type:C295(Field:C253($table;$field)->)
					If ($table>0) & ($field>0) & ($type#Is text:K8:3) & ($type#Is picture:K8:10) & ($type#Is subtable:K8:11)
						QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
						
						  //the column for the sort critera already exists
						$present:=False:C215  //initializate the answer
						
						$table_name:=Table name:C256($table)
						$field_name:=Field name:C257($table;$field)
						
						  //loop on the group of columns
						For ($i;1;QR Count columns:C764(nqr_area);1)
							  //get the infos regarding the contents of the column
							QR GET INFO COLUMN:C766(nqr_area;$i;$title;$fieldobj;$hide;$size;$repeat;$format)
							  //comparison of the contents of the field which will be used as the sort criteria
							Case of 
								: ($fieldobj#("["+$table_name+"]"+$field_name))
									  //this is not a good field; nothing to make
								Else 
									$present:=True:C214  //this is a good field
									$column:=$i  //stop the loop
							End case 
						End for 
						  //prepare the answer
						Case of 
							: ($present=True:C214)  //the column already exists: add to the sorting
								If (Find in array:C230(_nqr_col;$column)<0)  //the column is not already sorted
									APPEND TO ARRAY:C911(_nqr_col;$column)
									APPEND TO ARRAY:C911(_nqr_order;1)
									QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
									NQR_List_Get_Sorts 
									NQR_List_Select_Sorts ($t)
									NQR_Select_Column 
								End if 
								
							: ($present=False:C215)  //the column does not exist: add the column to the report then the sort order
								$column:=QR Count columns:C764(nqr_area)+1
								QR INSERT COLUMN:C748(nqr_area;$column;Field:C253($table;$field))
								APPEND TO ARRAY:C911(_nqr_col;$column)
								APPEND TO ARRAY:C911(_nqr_order;1)
								QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
								NQR_List_Get_Sorts 
								NQR_List_Select_Sorts ($t)
								NQR_Select_Column 
						End case 
						SELECT LIST ITEMS BY POSITION:C381($list_field;Selected list items:C379($list_field)+1)
						
					End if 
					
				: ($field>0) & ($subfield>0)
					  //  Nothing to make in this case subfields are not sortable
			End case 
		End if 
End case 
