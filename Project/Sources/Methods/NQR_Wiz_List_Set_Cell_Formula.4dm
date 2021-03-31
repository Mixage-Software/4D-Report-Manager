//%attributes = {"invisible":true}
C_LONGINT:C283($i)
C_LONGINT:C283($operator;$break)
C_TEXT:C284($text)
C_TEXT:C284($text2)

Case of 
	: (nqr_current_cc#0) & (nqr_current_cl#0) & (FORM Get current page:C276=5)
		Case of 
			: (nqr_operator=-1)
				$operator:=0
				$text:=_nqr_oper_cell_format{_nqr_oper_cell}
			: (nqr_operator=-2)
				$operator:=0
				$text:=$1
			Else 
				$operator:=nqr_op_sum+(nqr_op_average*2)+(nqr_op_mini*4)+(nqr_op_maxi*8)+(nqr_op_count*16)+(nqr_op_stddeviation*32)
				$text:=""
		End case 
		Case of 
			: (nqr_current_cl=1)  //header
				
				
			: (nqr_current_cl=2)  //detail
				
				
			: (nqr_current_cl=nqr_nb_rows)  //footer
				$break:=-3
				If ($operator#0)
					QR SET TOTALS DATA:C767(nqr_area;nqr_current_cc;$break;$operator)
				Else 
					QR SET TOTALS DATA:C767(nqr_area;nqr_current_cc;$break;$operator)
					QR SET TOTALS DATA:C767(nqr_area;nqr_current_cc;$break;$text)
				End if 
				
			Else 
				$break:=nqr_current_cl-2
				If ($operator#0)
					QR SET TOTALS DATA:C767(nqr_area;nqr_current_cc;$break;$operator)
				Else 
					QR SET TOTALS DATA:C767(nqr_area;nqr_current_cc;$break;$operator)
					QR SET TOTALS DATA:C767(nqr_area;nqr_current_cc;$break;$text)
				End if 
		End case 
		NQR_List_Get_Selection 
		
	: (nqr_current_col#0)
		Case of 
			: (nqr_operator=-1)
				$operator:=0
				$text:=_nqr_oper_cell_format{_nqr_oper_cell}
			: (nqr_operator=-2)
				$operator:=0
				$text:=$1
			Else 
				$operator:=nqr_op_sum+(nqr_op_average*2)+(nqr_op_mini*4)+(nqr_op_maxi*8)+(nqr_op_count*16)+(nqr_op_stddeviation*32)
				$text:=""
		End case 
		
		For ($i;0;Size of array:C274(_nqr_col);1)
			If ($i=0)
				$break:=-3
			Else 
				$break:=$i
			End if 
			QR GET TOTALS DATA:C768(nqr_area;nqr_current_col;$break;$operator;$text2)
			Case of 
				: (nqr_operator=0)
					If (nqr_op_sum=0)
						$operator:=$operator ?- 0
					Else 
						$operator:=$operator ?+ 0
					End if 
				: (nqr_operator=1)
					If (nqr_op_average=0)
						$operator:=$operator ?- 1
					Else 
						$operator:=$operator ?+ 1
					End if 
				: (nqr_operator=2)
					If (nqr_op_mini=0)
						$operator:=$operator ?- 2
					Else 
						$operator:=$operator ?+ 2
					End if 
				: (nqr_operator=3)
					If (nqr_op_maxi=0)
						$operator:=$operator ?- 3
					Else 
						$operator:=$operator ?+ 3
					End if 
				: (nqr_operator=4)
					If (nqr_op_count=0)
						$operator:=$operator ?- 4
					Else 
						$operator:=$operator ?+ 4
					End if 
				: (nqr_operator=5)  //standard deviation
					If (nqr_op_stddeviation=0)
						$operator:=$operator ?- 5
					Else 
						$operator:=$operator ?+ 5
					End if 
			End case 
			If ($text="")
				QR SET TOTALS DATA:C767(nqr_area;nqr_current_col;$break;$text)
				QR SET TOTALS DATA:C767(nqr_area;nqr_current_col;$break;$operator)
			Else 
				QR SET TOTALS DATA:C767(nqr_area;nqr_current_col;$break;$operator)
				QR SET TOTALS DATA:C767(nqr_area;nqr_current_col;$break;$text)
			End if 
		End for 
		NQR_List_Get_Selection 
		
		
	: (nqr_current_row#0)
		Case of 
			: (nqr_operator=-1)
				$operator:=0
				$text:=_nqr_oper_cell_format{_nqr_oper_cell}
			: (nqr_operator=-2)
				$operator:=0
				$text:=$1
			Else 
				$operator:=nqr_op_sum+(nqr_op_average*2)+(nqr_op_mini*4)+(nqr_op_maxi*8)+(nqr_op_count*16)+(nqr_op_stddeviation*32)
				$text:=""
		End case 
		
		If (nqr_current_row=nqr_nb_rows)
			$break:=-3
		Else 
			$break:=nqr_current_row-2
		End if 
		For ($i;1;QR Count columns:C764(nqr_area);1)
			QR GET TOTALS DATA:C768(nqr_area;$i;$break;$operator;$text2)
			Case of 
				: (nqr_operator=0)
					If (nqr_op_sum=0)
						$operator:=$operator ?- 0
					Else 
						$operator:=$operator ?+ 0
					End if 
				: (nqr_operator=1)
					If (nqr_op_average=0)
						$operator:=$operator ?- 1
					Else 
						$operator:=$operator ?+ 1
					End if 
				: (nqr_operator=2)
					If (nqr_op_mini=0)
						$operator:=$operator ?- 2
					Else 
						$operator:=$operator ?+ 2
					End if 
				: (nqr_operator=3)
					If (nqr_op_maxi=0)
						$operator:=$operator ?- 3
					Else 
						$operator:=$operator ?+ 3
					End if 
				: (nqr_operator=4)
					If (nqr_op_count=0)
						$operator:=$operator ?- 4
					Else 
						$operator:=$operator ?+ 4
					End if 
				: (nqr_operator=5)
					If (nqr_op_stddeviation=0)
						$operator:=$operator ?- 5
					Else 
						$operator:=$operator ?+ 5
					End if 
			End case 
			If ($text="")
				QR SET TOTALS DATA:C767(nqr_area;$i;$break;$text)
				QR SET TOTALS DATA:C767(nqr_area;$i;$break;$operator)
			Else 
				QR SET TOTALS DATA:C767(nqr_area;$i;$break;$operator)
				QR SET TOTALS DATA:C767(nqr_area;$i;$break;$text)
			End if 
		End for 
		NQR_List_Get_Selection 
		
End case 







