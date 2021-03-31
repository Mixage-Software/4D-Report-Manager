C_LONGINT:C283($evt)
C_LONGINT:C283($element;$process;$position;$table;$field;$subfield;$column;$type;$hide;$size;$repeat)
C_LONGINT:C283($list_field;$ref_field)
C_POINTER:C301($fieldptr;$source)
C_TEXT:C284($name;$text;$title;$format;$field_old)

$evt:=Form event code:C388
Case of 
	: ($evt=On Drop:K2:12)
		_O_DRAG AND DROP PROPERTIES:C607($source;$element;$process)
		RESOLVE POINTER:C394($source;$name;$table;$field)
		
		Case of 
			: ($source=Self:C308)
				$column:=Drop position:C608
				If ($column#-1)
					QR GET INFO COLUMN:C766(nqr_area;$element;$title;$field_old;$hide;$size;$repeat;$format)
					QR DELETE COLUMN:C749(nqr_area;$element)
					QR INSERT COLUMN:C748(nqr_area;$column;$field_old)
					QR SET INFO COLUMN:C765(nqr_area;$column;$title;$field_old;$hide;$size;$repeat;$format)
					NQR_Get_lh_Column 
				End if 
				
			: ($name="nqr_lh_field@")
				Case of 
					: ($name="nqr_lh_field2")
						$list_field:=nqr_lh_field2
					: ($name="nqr_lh_field_detail2")
						$list_field:=nqr_lh_field_detail2
				End case 
				$position:=Selected list items:C379($list_field)
				If ($position>0)
					GET LIST ITEM:C378($list_field;$position;$ref_field;$text)
					$table:=($ref_field & 0x00FFFFFF) >> 16
					$field:=$ref_field & 0xFFFF
					$subfield:=$ref_field >> 24
					
					Case of 
						: ($table>0) & ($field>0) & ($subfield=0)
							$fieldptr:=Field:C253($table;$field)
							$column:=QR Count columns:C764(nqr_area)+1
							
							QR INSERT COLUMN:C748(nqr_area;$column;$fieldptr)
							SELECT LIST ITEMS BY POSITION:C381($list_field;$position+1)
							
						: ($table>0) & ($field>0) & ($subfield>0)
							$fieldptr:=Field:C253($table;$field;$subfield)
							$column:=QR Count columns:C764(nqr_area)+1
							QR INSERT COLUMN:C748(nqr_area;$column;$fieldptr)
							SELECT LIST ITEMS BY POSITION:C381($list_field;$position+1)
							
					End case 
				End if 
				NQR_Get_lh_Column 
		End case 
		
	: ($evt=On Drag Over:K2:13)
		_O_DRAG AND DROP PROPERTIES:C607($source;$element;$process)
		RESOLVE POINTER:C394($source;$name;$table;$field)
		$0:=-1
		
		Case of 
			: ($source=Self:C308)
				$0:=0
			: ($name="nqr_lh_field@")
				Case of 
					: ($name="nqr_lh_field2")
						$list_field:=nqr_lh_field2
					: ($name="nqr_lh_field_detail2")
						$list_field:=nqr_lh_field_detail2
				End case 
				If (Selected list items:C379($list_field)>0)
					GET LIST ITEM:C378($list_field;Selected list items:C379($list_field);$ref_field;$text)
					$table:=($ref_field & 0x00FFFFFF) >> 16
					$field:=$ref_field & 0xFFFF
					$subfield:=$ref_field >> 24
					
					If ($table>0) & ($field>0)
						If ($subfield=0)
							$type:=Type:C295(Field:C253($table;$field)->)
							Case of 
								: ($type=Is subtable:K8:11)
								Else 
									$0:=0
							End case 
						Else 
							$0:=0
						End if 
					End if 
				End if 
		End case 
		
End case 

nqr_current_col:=Selected list items:C379(nqr_lh_column)
NQR_Select_Column 