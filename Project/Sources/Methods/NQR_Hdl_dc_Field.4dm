//%attributes = {"invisible":true}
C_POINTER:C301($1;$pList)

C_LONGINT:C283($evt)
C_TEXT:C284($title;$field_old)
C_POINTER:C301($fieldptr)
C_LONGINT:C283($position;$ref_field;$table;$field;$subfield;$column;$type;$visible;$size;$repeat)
C_TEXT:C284($text;$format)

$pList:=$1

$evt:=Form event code:C388
Case of 
	: ($evt=On Double Clicked:K2:5) & (nqr_tr_1=1)
		C_LONGINT:C283($ref_field)
		$position:=Selected list items:C379($pList->)
		If ($position>0)
			GET LIST ITEM:C378($pList->;$position;$ref_field;$text)
			$table:=($ref_field & 0x00FFFFFF) >> 16
			$field:=$ref_field & 0xFFFF
			$subfield:=$ref_field >> 24
			$column:=QR Count columns:C764(nqr_area)+1
			Case of 
				: ($table>0) & ($field>0) & ($subfield=0)
					$fieldptr:=Field:C253($table;$field)
					$type:=Type:C295($fieldptr->)
					If ($type=Is subtable:K8:11)
					Else 
						QR INSERT COLUMN:C748(nqr_area;$column;$fieldptr)
					End if 
					
				: ($table>0) & ($field>0) & ($subfield>0)
					$fieldptr:=Field:C253($table;$field;$subfield)
					$type:=Type:C295($fieldptr->)
					If ($type=Is subtable:K8:11)
					Else 
						QR INSERT COLUMN:C748(nqr_area;$column;$fieldptr)
					End if 
					
			End case 
		End if 
		NQR_List_Get_Selection 
		
	: ($evt=On Double Clicked:K2:5) & (nqr_tr_2=1)
		GET LIST ITEM:C378($pList->;Selected list items:C379($pList->);$ref_field;$text)
		$table:=($ref_field & 0x00FFFFFF) >> 16
		$field:=$ref_field & 0xFFFF
		$subfield:=$ref_field >> 24
		Case of 
			: (nqr_tc_column="")
				$column:=1
			: (nqr_tc_row="")
				$column:=2
			: (nqr_tc_cell="")
				$column:=3
			Else 
				$column:=3
		End case 
		QR GET INFO COLUMN:C766(nqr_area;$column;$title;$field_old;$visible;$size;$repeat;$format)
		Case of 
			: ($table>0) & ($field>0) & ($subfield=0)
				$fieldptr:=Field:C253($table;$field)
				$type:=Type:C295($fieldptr->)
				If ($type=Is subtable:K8:11)
				Else 
					QR SET INFO COLUMN:C765(nqr_area;$column;"";$fieldptr;$visible;$size;$repeat;$format)
				End if 
				
			: ($table>0) & ($field>0) & ($subfield>0)
				$fieldptr:=Field:C253($table;$field;$subfield)
				$type:=Type:C295($fieldptr->)
				If ($type=Is subtable:K8:11)
				Else 
					QR SET INFO COLUMN:C765(nqr_area;$column;"";$fieldptr;$visible;$size;$repeat;$format)
				End if 
				
		End case 
		NQR_Cross_Get_tc_lc 
End case 