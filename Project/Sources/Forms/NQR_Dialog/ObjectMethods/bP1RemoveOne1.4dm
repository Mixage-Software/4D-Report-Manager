C_LONGINT:C283($pos_item)
QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
$pos_item:=Selected list items:C379(nqr_lh_sort)
If ($pos_item>0) & ($pos_item<=Count list items:C380(nqr_lh_sort)) & ($pos_item<=Size of array:C274(_nqr_order))
	DELETE FROM ARRAY:C228(_nqr_order;$pos_item;1)
	DELETE FROM ARRAY:C228(_nqr_col;$pos_item;1)
	QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
	nqr_current_col:=0
	NQR_List_Get_Sorts 
	NQR_List_Select_Sorts ($pos_item)
	NQR_Select_Column 
End if 