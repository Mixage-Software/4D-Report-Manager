C_LONGINT:C283($evt)
C_LONGINT:C283($t)
C_LONGINT:C283($find)
C_LONGINT:C283($repeat;$hide;$size)
C_LONGINT:C283($column;$type)
  //C_POINTER($source;$field_old)
C_TEXT:C284($title)
C_TEXT:C284($format)
C_TEXT:C284($fieldobj;$text)

$evt:=Form event code:C388
Case of 
	: ($evt=On Double Clicked:K2:5)
		GET LIST ITEM:C378(nqr_lh_column2;Selected list items:C379(nqr_lh_column2);$column;$text)
		QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
		QR GET INFO COLUMN:C766(nqr_area;$column;$title;$fieldobj;$hide;$size;$repeat;$format)
		$type:=NQR_VirtualField_GetType ($fieldobj)
		If ($type#Is text:K8:3) & ($type#Is picture:K8:10)
			$find:=Find in array:C230(_nqr_col;$column)
			If ($find<0)
				$t:=Size of array:C274(_nqr_col)+1
				INSERT IN ARRAY:C227(_nqr_col;$t)
				INSERT IN ARRAY:C227(_nqr_order;$t)
				_nqr_col{$t}:=$column
				_nqr_order{$t}:=1
				QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
				NQR_List_Get_Sorts 
			Else 
				SELECT LIST ITEMS BY POSITION:C381(nqr_lh_sort2;$find)
			End if 
		End if 
		
End case 