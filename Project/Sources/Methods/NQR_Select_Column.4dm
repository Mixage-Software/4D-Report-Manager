//%attributes = {"invisible":true}
If (nqr_current_col#0)
	  //the current column is known 
	QR SET SELECTION:C794(nqr_area;nqr_current_col;0;nqr_current_col;nqr_nb_rows)  //set the current column
Else 
	  //the current column is unknown 
	QR SET SELECTION:C794(nqr_area;-1;-1;-1;-1)  //no selection
End if 