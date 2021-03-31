//%attributes = {"invisible":true}
C_TEXT:C284($title)
C_LONGINT:C283($repeat;$visible;$size)
C_TEXT:C284($format)
C_LONGINT:C283($i)
C_LONGINT:C283($column)
C_TEXT:C284($field_new)

Case of 
	: (nqr_tr_2=1)
		OBJECT SET ENABLED:C1123(*;"Btn_p7@";True:C214)
		OBJECT SET VISIBLE:C603(*;"p7_@";True:C214)
		
		$column:=1
		QR GET INFO COLUMN:C766(nqr_area;$column;$title;$field_new;$visible;$size;$repeat;$format)
		nqr_tc_column:=NQR_VirtualField_GetName ($field_new)
		$column:=2
		QR GET INFO COLUMN:C766(nqr_area;$column;$title;$field_new;$visible;$size;$repeat;$format)
		nqr_tc_row:=NQR_VirtualField_GetName ($field_new)
		$column:=3
		QR GET INFO COLUMN:C766(nqr_area;$column;$title;$field_new;$visible;$size;$repeat;$format)
		nqr_tc_cell:=NQR_VirtualField_GetName ($field_new)
		
		If (nqr_tc_column#"")
			OBJECT SET ENABLED:C1123(nqr_Btn_p7_Col;False:C215)
			OBJECT SET VISIBLE:C603(*;"p7_col@";False:C215)
		End if 
		If (nqr_tc_row#"")
			OBJECT SET ENABLED:C1123(nqr_Btn_p7_row;False:C215)
			OBJECT SET VISIBLE:C603(*;"p7_row@";False:C215)
		End if 
		If (nqr_tc_cell#"")
			OBJECT SET ENABLED:C1123(nqr_Btn_p7_Cel;False:C215)
			OBJECT SET VISIBLE:C603(*;"p7_cel@";False:C215)
		End if 
		
		
		If (nqr_tc_column#"") & (nqr_tc_row#"") & (nqr_tc_cell#"")
			  //all the conditions are met one can pass the report to the following step
			OBJECT SET ENABLED:C1123(nqr_b_Step_Next;True:C214)
			nqr_step_following_ok:=True:C214
			OBJECT SET RGB COLORS:C628(*;"step_"+String:C10($i);0x0000)  // Black
		Else 
			  //all conditions are not met, remain on the current step
			OBJECT SET ENABLED:C1123(nqr_b_Step_Next;False:C215)
			nqr_step_following_ok:=False:C215
			OBJECT SET RGB COLORS:C628(*;"step_"+String:C10($i);0x007F7F7F)  //Grey
			For ($i;nqr_step_current+1;10)
				Get pointer:C304("nqr_step_"+String:C10($i))->:=""
				OBJECT SET VISIBLE:C603(*;"bttn"+String:C10($i);False:C215)
				Get pointer:C304("nqr_bttn"+String:C10($i))->:=0
			End for 
			nqr_step_maximum:=nqr_step_current
		End if 
End case 
