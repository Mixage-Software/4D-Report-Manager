nqr_current_col:=Selected list items:C379(nqr_lh_column)

If (nqr_current_col#0)
	QR DELETE COLUMN:C749(nqr_area;nqr_current_col)
	
	NQR_Get_lh_Column 
	NQR_Select_Column 
End if 
