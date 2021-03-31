C_LONGINT:C283($evt)
C_TEXT:C284($title)
C_TEXT:C284($field_old)
C_POINTER:C301($fieldptr)

C_LONGINT:C283($repeat;$visible;$size;$ref_field;$table;$field;$subfield;$column)
C_TEXT:C284($format;$text)


$evt:=Form event code:C388
Case of 
	: ($evt=On Double Clicked:K2:5)
		GET LIST ITEM:C378(nqr_lh_field3;Selected list items:C379(nqr_lh_field3);$ref_field;$text)
		$table:=($ref_field & 0x00FFFFFF) >> 16
		$field:=$ref_field & 0xFFFF
		$subfield:=$ref_field >> 24
		
		Case of 
			: ($table>0) & ($field>0) & ($subfield=0)
				$fieldptr:=Field:C253($table;$field)
				Case of 
					: (nqr_tc_column="")
						$column:=1
						OBJECT SET ENABLED:C1123(nqr_Btn_p7_Col;False:C215)
						OBJECT SET VISIBLE:C603(*;"p7_col@";False:C215)
					: (nqr_tc_row="")
						$column:=2
						OBJECT SET ENABLED:C1123(nqr_Btn_p7_row;False:C215)
						OBJECT SET VISIBLE:C603(*;"p7_row@";False:C215)
					: (nqr_tc_cell="")
						$column:=3
						OBJECT SET ENABLED:C1123(nqr_Btn_p7_Cel;False:C215)
						OBJECT SET VISIBLE:C603(*;"p7_cel@";False:C215)
					Else 
						$column:=3
						OBJECT SET ENABLED:C1123(nqr_Btn_p7_Cel;False:C215)
						OBJECT SET VISIBLE:C603(*;"p7_cel@";False:C215)
				End case 
				QR GET INFO COLUMN:C766(nqr_area;$column;$title;$field_old;$visible;$size;$repeat;$format)
				QR SET INFO COLUMN:C765(nqr_area;$column;"";$fieldptr;$visible;$size;$repeat;$format)
				
				NQR_Cross_Get_tc_lc 
				
			: ($table>0) & ($field>0) & ($subfield>0)
				
				BEEP:C151
		End case 
End case 

NQR_View_Fields 