C_LONGINT:C283($column)
C_TEXT:C284($text)
If (Selected list items:C379(nqr_lh_sort2)>0)
	
	GET LIST ITEM:C378(nqr_lh_sort2;Selected list items:C379(nqr_lh_sort2);$column;$text)
	QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
	
	If ($column>0) & ($column<=Size of array:C274(_nqr_col))
		DELETE FROM ARRAY:C228(_nqr_col;$column;1)
		DELETE FROM ARRAY:C228(_nqr_order;$column;1)
		QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
		NQR_List_Get_Sorts 
	End if 
End if 