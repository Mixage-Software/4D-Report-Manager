//%attributes = {"invisible":true}
C_LONGINT:C283($operator)
C_TEXT:C284($text)
Case of 
	: (nqr_tr_2=1)
		
		
		$operator:=nqr_op_sum+(nqr_op_average*2)+(nqr_op_mini*4)+(nqr_op_maxi*8)+(nqr_op_count*16)+(nqr_op_stddeviation*32)
		$text:=""
		If ($operator#0)
			QR SET TOTALS DATA:C767(nqr_area;2;3;$operator)
			nqr_with_total_columns:=True:C214
		Else 
			QR SET TOTALS DATA:C767(nqr_area;2;3;$operator)
			QR SET TOTALS DATA:C767(nqr_area;2;3;$text)
			nqr_with_total_columns:=False:C215
		End if 
		QR SET SELECTION:C794(nqr_area;2;3;2;3)
		
		
End case 
