C_LONGINT:C283($evt)
C_TEXT:C284($text;$name)
C_LONGINT:C283($table;$field;$subfield;$type;$column)
C_LONGINT:C283($position)
C_LONGINT:C283($list_field;$ref_field)
C_POINTER:C301($source;$fieldptr)

$evt:=Form event code:C388
Case of 
	: ($evt=On Clicked:K2:4)
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
				C_LONGINT:C283($ref_field)
				$position:=Selected list items:C379($list_field)
				If ($position>0) & ($position<=Count list items:C380($list_field))
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
									SELECT LIST ITEMS BY POSITION:C381($list_field;$position+1)
							End case 
						: ($table>0) & ($field>0) & ($subfield>0)
							$fieldptr:=Field:C253($table;$field;$subfield)
							$type:=Type:C295($fieldptr->)
							Case of 
								: ($type=Is subtable:K8:11)
								Else 
									$column:=QR Count columns:C764(nqr_area)+1
									
									QR INSERT COLUMN:C748(nqr_area;$column;$fieldptr)
									SELECT LIST ITEMS BY POSITION:C381($list_field;$position+1)
							End case 
					End case 
				End if 
				
				NQR_Get_lh_Column 
				NQR_Select_Column 
		End case 
End case 