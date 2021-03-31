C_LONGINT:C283($column)
For ($column;QR Count columns:C764(nqr_area);1;-1)
	QR DELETE COLUMN:C749(nqr_area;$column)
End for 
nqr_current_col:=0

NQR_Get_lh_Column 