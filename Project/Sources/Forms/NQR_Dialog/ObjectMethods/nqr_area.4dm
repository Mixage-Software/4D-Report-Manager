C_LONGINT:C283($0)

C_LONGINT:C283($evt)
C_TEXT:C284($title;$title_new)
C_TEXT:C284($field_old)
C_TEXT:C284($name)
C_LONGINT:C283($table;$field;$type;$column;$visible;$size;$repeat)
C_POINTER:C301($source;$fieldptr)
C_LONGINT:C283($list_field;$ref_field;$subfield)
C_LONGINT:C283($element;$process;$find_field;$find_sub_field;$find)
C_TEXT:C284($text;$format)


C_BOOLEAN:C305(nqr_area_is_focused)
$evt:=Form event code:C388
Case of 
	: ($evt=On Getting Focus:K2:7)
		nqr_area_is_focused:=True:C214
		GOTO OBJECT:C206(gFontPicker)
		
	: ($evt=On Losing Focus:K2:8)
		nqr_area_is_focused:=False:C215
		
	: ($evt=On Data Change:K2:15)  // **BUG** NOT CALLED WHEN CLICKING A LIST REPORT COLUMN :(
		If (nqr_area_is_focused)
			NQR_OnAreaDataChange 
		End if 
		
		
	: ($evt=On Drag Over:K2:13)
		Case of 
			: (FORM Get current page:C276=1) & (nqr_cb_5=1)  //we are in column one
				$0:=-1  //refuse
				
			: (FORM Get current page:C276=1)
				_O_DRAG AND DROP PROPERTIES:C607($source;$element;$process)
				RESOLVE POINTER:C394($source;$name;$table;$field)
				$0:=-1  //default refuse
				Case of 
					: ($name="nqr_lh_field@")
						$list_field:=$source->
						GET LIST ITEM:C378($list_field;Selected list items:C379($list_field);$ref_field;$text)
						If ($ref_field>0)  //treat only if it is a field and not a dependent table (which would be negative in reference)
							$table:=($ref_field & 0x00FFFFFF) >> 16  //get the table number
							$field:=$ref_field & 0xFFFF  //get the field number
							$subfield:=$ref_field >> 24  //get the subfield number
							If ($table>0) & ($field>0)  //it is a field or subfield
								If ($subfield=0)  //is a field
									$type:=Type:C295(Field:C253($table;$field)->)
								Else   //is a subfield
									If (nqr_tr_1=1)
										$type:=Type:C295(Field:C253($table;$field;$subfield)->)
									Else 
										$type:=Is subtable:K8:11  //sub fields are not authorized in cross table reports
									End if 
								End if 
								If ($type=Is subtable:K8:11)  //subtables cannot be accepted
								Else 
									$0:=0  //return OK
								End if 
							End if 
							
						End if 
				End case 
				
			: (FORM Get current page:C276=7)
				$0:=-1
				
				
				
			Else 
				
		End case 
		
		
	: ($evt=On Drop:K2:12) & (nqr_tr_1=1)  //list type report
		  //get the properties of the object source
		_O_DRAG AND DROP PROPERTIES:C607($source;$element;$process)
		RESOLVE POINTER:C394($source;$name;$table;$field)
		
		Case of 
			: ($name="nqr_lh_field@")
				$list_field:=$source->
				  //get the list information
				GET LIST ITEM:C378($list_field;Selected list items:C379($list_field);$ref_field;$text)
				If ($ref_field>0)  //treat only if it is a field and not a dependent table (which would be negative in reference)
					$table:=($ref_field & 0x00FFFFFF) >> 16  //get the table number
					$field:=$ref_field & 0xFFFF  //get the field number
					$subfield:=$ref_field >> 24  //get the sub field number
					If ($table>0) & ($field>0)  //it is a field or subfield
						If ($subfield=0)  //is not a subfield
							$fieldptr:=Field:C253($table;$field)
							$type:=Type:C295(Field:C253($table;$field)->)
							$find_field:=Find in array:C230(_nqr_field_id{$table};$field)
							$title_new:=_nqr_field{$table}{$find_field}
						Else   //is a field subfield
							$fieldptr:=Field:C253($table;$field;$subfield)
							$type:=Type:C295(Field:C253($table;$field;$subfield)->)
							GET FIELD TITLES:C804(Field:C253($table;$field)->;$_subfield;$_subfield_id)
							$find_field:=Find in array:C230(_nqr_field_id{$table};$field)
							$find_sub_field:=Find in array:C230($_subfield_id;$subfield)
							$title_new:=_nqr_field{$table}{$find_field}+"."+$_subfield{$find_sub_field}
						End if 
						$column:=QR Get drop column:C747(nqr_area)
						Case of 
							: ($type=Is subtable:K8:11)  //is a subtable, nothing to make
							: ($column>0)  //the number is positive ; add one column
								QR INSERT COLUMN:C748(nqr_area;$column;$fieldptr)
							: ($column<0)  //the number is negative ;  modify the column
								QR GET INFO COLUMN:C766(nqr_area;Abs:C99($column);$title;$field_old;$visible;$size;$repeat;$format)
								QR SET INFO COLUMN:C765(nqr_area;Abs:C99($column);$title_new;$fieldptr;$visible;$size;$repeat;$format)
								nqr_current_col:=Abs:C99($column)
								If ($type=Is text:K8:3) | ($type=Is picture:K8:10) | ($type=Is subtable:K8:11)  // these types are not sortable; the sorting should be removed
									QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
									$find:=Find in array:C230(_nqr_col;nqr_current_col)
									If ($find>0)
										DELETE FROM ARRAY:C228(_nqr_col;$find)
										DELETE FROM ARRAY:C228(_nqr_order;$find)
										QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
									End if 
								End if 
								NQR_Select_Column 
						End case 
						NQR_Get_lh_Column 
						NQR_List_Get_Sorts 
					End if 
				End if 
		End case 
		NQR_List_Get_Selection 
		
	: ($evt=On Drop:K2:12) & (nqr_tr_2=1)  //cross table report
		_O_DRAG AND DROP PROPERTIES:C607($source;$element;$process)
		RESOLVE POINTER:C394($source;$name;$table;$field)
		
		Case of 
			: ($name="nqr_lh_field@")
				$list_field:=$source->
				GET LIST ITEM:C378($list_field;Selected list items:C379($list_field);$ref_field;$text)
				$table:=($ref_field & 0x00FFFFFF) >> 16  //get the table number
				$field:=$ref_field & 0xFFFF  //get the field number
				$subfield:=$ref_field >> 24  //get the subfield number
				If ($table>0) & ($field>0) & ($subfield=0)  //subfields are not allowed in a cross table report
					$fieldptr:=Field:C253($table;$field)
					$type:=Type:C295($fieldptr->)
					If ($type=Is subtable:K8:11)
					Else 
						$column:=Abs:C99(QR Get drop column:C747(nqr_area))
						QR GET INFO COLUMN:C766(nqr_area;$column;$title;$field_old;$visible;$size;$repeat;$format)
						QR SET INFO COLUMN:C765(nqr_area;$column;"";$fieldptr;$visible;$size;$repeat;$format)
					End if 
					NQR_Cross_Set_tc_sort 
				End if 
		End case 
		
	Else 
		
		
		
End case 
