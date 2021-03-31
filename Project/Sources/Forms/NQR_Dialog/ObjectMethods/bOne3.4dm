C_LONGINT:C283($column)
C_TEXT:C284($text)
C_TEXT:C284($title)
C_LONGINT:C283($repeat;$hide;$size;$find;$type)
C_TEXT:C284($format;$field)

GET LIST ITEM:C378(nqr_lh_column2;Selected list items:C379(nqr_lh_column2);$column;$text)
QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)

$find:=Find in array:C230(_nqr_col;$column)
Case of 
	: ($column=0)
	: ($find<0)
		QR GET INFO COLUMN:C766(nqr_area;$column;$title;$field;$hide;$size;$repeat;$format)
		$type:=NQR_VirtualField_GetType ($field)
		If ($type#Is text:K8:3) & ($type#Is picture:K8:10) & (Position:C15("'";$field)<=0)
			APPEND TO ARRAY:C911(_nqr_col;$column)
			APPEND TO ARRAY:C911(_nqr_order;1)
			QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
			SELECT LIST ITEMS BY POSITION:C381(nqr_lh_column2;Selected list items:C379(nqr_lh_column2)+1)
			NQR_List_Get_Sorts 
		End if 
	Else 
		SELECT LIST ITEMS BY POSITION:C381(nqr_lh_sort2;$find)
End case 
