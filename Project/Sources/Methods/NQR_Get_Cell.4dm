//%attributes = {"invisible":true}
C_BOOLEAN:C305($aff_op)
C_LONGINT:C283($break;$operator;$find)
C_TEXT:C284($text)

Case of 
	: (nqr_current_cc#0) & (nqr_current_cl#0)
		
		
		nqr_Computations:=Get indexed string:C510(14907;39)  //"Cell Computations"
		OBJECT SET VISIBLE:C603(*;"rectCol";False:C215)
		OBJECT SET VISIBLE:C603(*;"Border";False:C215)
		OBJECT SET VISIBLE:C603(*;"rectCel";True:C214)
		
		Case of 
			: (nqr_current_cl=1)  //heading
				$aff_op:=False:C215
				nqr_op_sum:=0
				nqr_op_average:=0
				nqr_op_mini:=0
				nqr_op_maxi:=0
				nqr_op_count:=0
				nqr_op_stddeviation:=0
				_nqr_oper_cell:=0
				nqr_formula_free:=""
				
			: (nqr_current_cl=2)  //detail
				$aff_op:=False:C215
				nqr_op_sum:=0
				nqr_op_average:=0
				nqr_op_mini:=0
				nqr_op_maxi:=0
				nqr_op_count:=0
				nqr_op_stddeviation:=0
				
				_nqr_oper_cell:=0
				nqr_formula_free:=""
				
			: (nqr_current_cl=nqr_nb_rows)  //footer
				$aff_op:=True:C214
				$break:=-3
				QR GET TOTALS DATA:C768(nqr_area;nqr_current_cc;$break;$operator;$text)
				Case of 
					: ($text#"")
						nqr_op_sum:=0
						nqr_op_average:=0
						nqr_op_mini:=0
						nqr_op_maxi:=0
						nqr_op_count:=0
						nqr_op_stddeviation:=0
						
						$find:=Find in array:C230(_nqr_oper_cell_format;$text)
						If ($find>0)
							_nqr_oper_cell:=$find
							nqr_formula_free:=""
						Else 
							_nqr_oper_cell:=0
							nqr_formula_free:=$text
						End if 
					Else 
						nqr_op_sum:=Num:C11($operator ?? 0)
						nqr_op_average:=Num:C11($operator ?? 1)
						nqr_op_mini:=Num:C11($operator ?? 2)
						nqr_op_maxi:=Num:C11($operator ?? 3)
						nqr_op_count:=Num:C11($operator ?? 4)
						nqr_op_stddeviation:=Num:C11($operator ?? 5)
						_nqr_oper_cell:=0
						nqr_formula_free:=""
				End case 
				
			Else 
				$aff_op:=True:C214
				$break:=nqr_current_cl-2
				QR GET TOTALS DATA:C768(nqr_area;nqr_current_cc;$break;$operator;$text)
				Case of 
					: ($text#"")
						nqr_op_sum:=0
						nqr_op_average:=0
						nqr_op_mini:=0
						nqr_op_maxi:=0
						nqr_op_count:=0
						nqr_op_stddeviation:=0
						$find:=Find in array:C230(_nqr_oper_cell_format;$text)
						If ($find>0)
							_nqr_oper_cell:=$find
							nqr_formula_free:=""
						Else 
							_nqr_oper_cell:=0
							nqr_formula_free:=$text
						End if 
					Else 
						nqr_op_sum:=Num:C11($operator ?? 0)
						nqr_op_average:=Num:C11($operator ?? 1)
						nqr_op_mini:=Num:C11($operator ?? 2)
						nqr_op_maxi:=Num:C11($operator ?? 3)
						nqr_op_count:=Num:C11($operator ?? 4)
						nqr_op_stddeviation:=Num:C11($operator ?? 5)
						_nqr_oper_cell:=0
						nqr_formula_free:=""
				End case 
		End case 
		
		
		OBJECT SET ENABLED:C1123(*;"@_BreakSettings@";$aff_op)
		OBJECT SET ENABLED:C1123(*;"formula_button@";$aff_op)
		OBJECT SET ENTERABLE:C238(nqr_formula_free;$aff_op)
		OBJECT SET VISIBLE:C603(*;"cb2Cache@";$aff_op)
		
End case 
