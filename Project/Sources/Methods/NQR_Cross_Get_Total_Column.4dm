//%attributes = {"invisible":true}
C_LONGINT:C283($operator)
C_TEXT:C284($text)
Case of 
	: (nqr_tr_2=1)
		
		QR GET TOTALS DATA:C768(nqr_area;1;3;$operator;nqr_title_total_columns)
		
		nqr_with_total_columns:=False:C215
		QR GET TOTALS DATA:C768(nqr_area;2;3;$operator;$text)
		Case of 
			: ($text#"")
				nqr_op_sum:=0
				nqr_op_average:=0
				nqr_op_mini:=0
				nqr_op_maxi:=0
				nqr_op_count:=0
				nqr_op_stddeviation:=0
			Else 
				nqr_op_sum:=Num:C11($operator ?? 0)
				nqr_op_average:=Num:C11($operator ?? 1)
				nqr_op_mini:=Num:C11($operator ?? 2)
				nqr_op_maxi:=Num:C11($operator ?? 3)
				nqr_op_count:=Num:C11($operator ?? 4)
				nqr_op_stddeviation:=Num:C11($operator ?? 5)
				nqr_with_total_columns:=($operator#0)
		End case 
		QR SET SELECTION:C794(nqr_area;2;3;2;3)
		
		
End case 
