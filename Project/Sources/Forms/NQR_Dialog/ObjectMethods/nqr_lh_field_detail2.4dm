C_LONGINT:C283($evt)
C_LONGINT:C283($position;$table;$field;$subfield;$ref_field;$column)
C_POINTER:C301($fieldptr)
C_TEXT:C284($text)

$evt:=Form event code:C388
Case of 
	: ($evt=On Double Clicked:K2:5)
		C_LONGINT:C283($ref_field)
		$position:=Selected list items:C379(nqr_lh_field_detail2)
		If ($position>0)
			GET LIST ITEM:C378(nqr_lh_field_detail2;$position;$ref_field;$text)
			$table:=($ref_field & 0x00FFFFFF) >> 16
			$field:=$ref_field & 0xFFFF
			$subfield:=$ref_field >> 24
			
			Case of 
				: ($table>0) & ($field>0) & ($subfield=0)
					$fieldptr:=Field:C253($table;$field)
					$column:=QR Count columns:C764(nqr_area)+1
					
					QR INSERT COLUMN:C748(nqr_area;$column;$fieldptr)
					
				: ($table>0) & ($field>0) & ($subfield>0)
					$fieldptr:=Field:C253($table;$field;$subfield)
					$column:=QR Count columns:C764(nqr_area)+1
					
					QR INSERT COLUMN:C748(nqr_area;$column;$fieldptr)
					
			End case 
		End if 
		NQR_Get_lh_Column 
End case 
