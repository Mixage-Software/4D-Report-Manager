//%attributes = {"invisible":true}
C_TEXT:C284($title)
C_LONGINT:C283($repeat;$hide;$size)
C_TEXT:C284($format)
C_LONGINT:C283($i)
C_LONGINT:C283(nqr_lh_column)
C_TEXT:C284($field)

  //Build the list of the columns for the quick report wizard
If (Is a list:C621(nqr_lh_column))
	CLEAR LIST:C377(nqr_lh_column;*)
End if 
nqr_lh_column:=New list:C375

For ($i;1;QR Count columns:C764(nqr_area))
	QR GET INFO COLUMN:C766(nqr_area;$i;$title;$field;$hide;$size;$repeat;$format)
	$field:=NQR_VirtualField_GetName ($field)
	APPEND TO LIST:C376(nqr_lh_column;$field;$i)
	SET LIST ITEM PROPERTIES:C386(nqr_lh_column;$i;False:C215;Plain:K14:1;"path:/RESOURCES/Images/Column.png")
End for 

  //selection of the element running according to the current column
If (nqr_current_col#0)
	SELECT LIST ITEMS BY POSITION:C381(nqr_lh_column;nqr_current_col)
Else 
	SELECT LIST ITEMS BY POSITION:C381(nqr_lh_column;Count list items:C380(nqr_lh_column)+1)
End if 

  // make a copy of the list
If (Is a list:C621(nqr_lh_column2))
	CLEAR LIST:C377(nqr_lh_column2;*)
End if 
nqr_lh_column2:=Copy list:C626(nqr_lh_column)

  //activate the buttons according to the element number of the column
If (Count list items:C380(nqr_lh_column)>0)
	OBJECT SET ENABLED:C1123(nqr_b_Step_Next;True:C214)
	nqr_step_following_ok:=True:C214
	OBJECT SET RGB COLORS:C628(*;"step_"+String:C10($i);0x0000)  // Black
Else 
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