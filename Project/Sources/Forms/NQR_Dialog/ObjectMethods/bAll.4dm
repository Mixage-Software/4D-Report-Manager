C_LONGINT:C283($position)
C_LONGINT:C283($ref_field)
C_LONGINT:C283($table;$field;$subfield;$list_field;$column;$type)
C_POINTER:C301($source;$fieldptr)
C_TEXT:C284($name;$text)

$source:=Focus object:C278
RESOLVE POINTER:C394($source;$name;$table;$field)

Case of 
	: ($name="nqr_lh_field@")
		Case of 
			: ($name="nqr_lh_field2")
				$list_field:=nqr_lh_field2
			: ($name="nqr_lh_field_detail2")
				$list_field:=nqr_lh_field_detail2
		End case 
		
		For ($position;1;Count list items:C380($list_field);1)
			
			GET LIST ITEM:C378($list_field;$position;$ref_field;$text)
			$table:=($ref_field & 0x00FFFFFF) >> 16
			$field:=$ref_field & 0xFFFF
			$subfield:=$ref_field >> 24
			
			Case of 
				: ($table>0) & ($field>0) & ($subfield=0)
					$fieldptr:=Field:C253($table;$field)
					$type:=Type:C295($fieldptr->)
					Case of 
						: ($type=Is subtable:K8:11)
						Else 
							$column:=QR Count columns:C764(nqr_area)+1
							QR INSERT COLUMN:C748(nqr_area;$column;$fieldptr)
							SELECT LIST ITEMS BY POSITION:C381($list_field;Selected list items:C379($list_field)+1)
					End case 
				: ($table>0) & ($field>0) & ($subfield>0)
					$fieldptr:=Field:C253($table;$field;$subfield)
					$type:=Type:C295($fieldptr->)
					Case of 
						: ($type=Is subtable:K8:11)
						Else 
							$column:=QR Count columns:C764(nqr_area)+1
							QR INSERT COLUMN:C748(nqr_area;$column;$fieldptr)
							SELECT LIST ITEMS BY POSITION:C381($list_field;Selected list items:C379($list_field)+1)
					End case 
			End case 
		End for 
		
		NQR_Get_lh_Column 
		NQR_Select_Column 
End case 