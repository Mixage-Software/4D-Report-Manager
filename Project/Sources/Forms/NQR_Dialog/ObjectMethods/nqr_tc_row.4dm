C_LONGINT:C283($evt)
C_LONGINT:C283($column;$element;$process;$size;$table;$field;$subfield;$ref_field;$list_field;$type;$repeat;$visible;$ref)
C_POINTER:C301($source;$fieldptr)
C_TEXT:C284($title;$name;$text;$format;$texte;$field_old)
$column:=2

$evt:=Form event code:C388
Case of 
	: ($evt=On Drop:K2:12)
		_O_DRAG AND DROP PROPERTIES:C607($source;$element;$process)
		RESOLVE POINTER:C394($source;$name;$table;$field)
		OBJECT SET ENABLED:C1123(nqr_Btn_p7_Col;False:C215)
		OBJECT SET VISIBLE:C603(*;"p7_col@";False:C215)
		Case of 
			: ($name="nqr_lh_field@")
				Case of 
					: ($name="nqr_lh_field3")
						$list_field:=nqr_lh_field3
					: ($name="nqr_lh_field_detail3")
						$list_field:=nqr_lh_field_detail3
				End case 
				GET LIST ITEM:C378($list_field;Selected list items:C379($list_field);$ref_field;$text)
				$table:=($ref_field & 0x00FFFFFF) >> 16
				$field:=$ref_field & 0xFFFF
				$subfield:=$ref_field >> 24
				
				Case of 
					: ($table>0) & ($field>0) & ($subfield=0)
						$fieldptr:=Field:C253($table;$field)
						$type:=Type:C295($fieldptr->)
						If ($type=Is subtable:K8:11)
						Else 
							QR GET INFO COLUMN:C766(nqr_area;$column;$title;$field_old;$visible;$size;$repeat;$format)
							QR SET INFO COLUMN:C765(nqr_area;$column;"";$fieldptr;$visible;$size;$repeat;$format)
						End if 
						NQR_Cross_Get_tc_lc 
						
					: ($table>0) & ($field>0) & ($subfield>0)
						
						BEEP:C151
				End case 
		End case 
		
	: ($evt=On Drag Over:K2:13)
		_O_DRAG AND DROP PROPERTIES:C607($source;$element;$process)
		RESOLVE POINTER:C394($source;$name;$table;$field)
		$0:=-1
		
		Case of 
			: ($name="nqr_lh_field@")
				Case of 
					: ($name="nqr_lh_field3")
						$list_field:=nqr_lh_field3
					: ($name="nqr_lh_field_detail3")
						$list_field:=nqr_lh_field_detail3
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
		
	: ($evt=On Clicked:K2:4) & (Contextual click:C713)
		$texte:=Get indexed string:C510(14907;103)+";"
		$ref:=Pop up menu:C542($texte)
		Case of 
			: ($ref=1)
				QR GET INFO COLUMN:C766(nqr_area;$column;$title;$field_old;$visible;$size;$repeat;$format)
				QR SET INFO COLUMN:C765(nqr_area;$column;"";" ";$visible;$size;$repeat;$format)
				OBJECT SET ENABLED:C1123(nqr_Btn_p7_row;True:C214)
				OBJECT SET VISIBLE:C603(*;"p7_row@";True:C214)
				NQR_Cross_Get_tc_lc 
		End case 
End case 
