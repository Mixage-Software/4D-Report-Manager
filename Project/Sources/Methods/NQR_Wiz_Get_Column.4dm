//%attributes = {"invisible":true}
C_LONGINT:C283($operator)
C_LONGINT:C283($i;$find)
C_LONGINT:C283($break)
C_TEXT:C284($text)

Case of 
	: (FORM Get current page:C276=5)
		
		nqr_Computations:=Get indexed string:C510(14907;40)  //"Column computations"
		OBJECT SET VISIBLE:C603(*;"rectCol";True:C214)
		OBJECT SET VISIBLE:C603(*;"Border";False:C215)
		OBJECT SET VISIBLE:C603(*;"rectCel";False:C215)
		
		OBJECT SET ENABLED:C1123(*;"formula_button@";True:C214)
		OBJECT SET ENTERABLE:C238(nqr_formula_free;True:C214)
		OBJECT SET VISIBLE:C603(*;"cb2Cache@";True:C214)
		
		nqr_op_sum:=-1
		nqr_op_average:=-1
		nqr_op_mini:=-1
		nqr_op_maxi:=-1
		nqr_op_count:=-1
		nqr_op_stddeviation:=-1
		_nqr_oper_cell:=-1
		nqr_formula_free:=Char:C90(1)
		QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
		
		For ($i;0;Size of array:C274(_nqr_col);1)
			If ($i=0)
				$break:=-3
			Else 
				$break:=$i
			End if 
			QR GET TOTALS DATA:C768(nqr_area;nqr_current_col;$break;$operator;$text)
			Case of 
				: ($text#"")
					$find:=Find in array:C230(_nqr_oper_cell_format;$text)
					If ($find>0)
						Case of 
							: (_nqr_oper_cell=-1)
								_nqr_oper_cell:=$find
							: (_nqr_oper_cell#$find)
								_nqr_oper_cell:=0
						End case 
						nqr_formula_free:=""
					Else 
						_nqr_oper_cell:=0
						Case of 
							: (nqr_formula_free=Char:C90(1))
								nqr_formula_free:=$text
							: (nqr_formula_free#$text)
								nqr_formula_free:=""
						End case 
					End if 
					Case of 
						: (nqr_op_sum=-1)
							nqr_op_sum:=0
						: (nqr_op_sum=1)
							nqr_op_sum:=2
					End case 
					Case of 
						: (nqr_op_average=-1)
							nqr_op_average:=0
						: (nqr_op_average=1)
							nqr_op_average:=2
					End case 
					Case of 
						: (nqr_op_mini=-1)
							nqr_op_mini:=0
						: (nqr_op_mini=1)
							nqr_op_mini:=2
					End case 
					Case of 
						: (nqr_op_maxi=-1)
							nqr_op_maxi:=0
						: (nqr_op_maxi=1)
							nqr_op_maxi:=2
					End case 
					Case of 
						: (nqr_op_count=-1)
							nqr_op_count:=0
						: (nqr_op_count=1)
							nqr_op_count:=2
					End case 
					Case of 
						: (nqr_op_stddeviation=-1)
							nqr_op_stddeviation:=0
						: (nqr_op_stddeviation=1)
							nqr_op_stddeviation:=2
					End case 
				Else 
					Case of 
						: (nqr_formula_free=Char:C90(1))
							nqr_formula_free:=""
					End case 
					Case of 
						: (_nqr_oper_cell=-1)
							_nqr_oper_cell:=0
						: (_nqr_oper_cell>0)
							_nqr_oper_cell:=0
					End case 
					Case of 
						: ($operator ?? 0) & (nqr_op_sum=-1)
							nqr_op_sum:=1
						: ($operator ?? 0) & (nqr_op_sum=0)
							nqr_op_sum:=2
						: (Not:C34($operator ?? 0)) & (nqr_op_sum=-1)
							nqr_op_sum:=0
						: (Not:C34($operator ?? 0)) & (nqr_op_sum=1)
							nqr_op_sum:=2
					End case 
					Case of 
						: ($operator ?? 1) & (nqr_op_average=-1)
							nqr_op_average:=1
						: ($operator ?? 1) & (nqr_op_average=0)
							nqr_op_average:=2
						: (Not:C34($operator ?? 1)) & (nqr_op_average=-1)
							nqr_op_average:=0
						: (Not:C34($operator ?? 1)) & (nqr_op_average=1)
							nqr_op_average:=2
					End case 
					Case of 
						: ($operator ?? 2) & (nqr_op_mini=-1)
							nqr_op_mini:=1
						: ($operator ?? 2) & (nqr_op_mini=0)
							nqr_op_mini:=2
						: (Not:C34($operator ?? 2)) & (nqr_op_mini=-1)
							nqr_op_mini:=0
						: (Not:C34($operator ?? 2)) & (nqr_op_mini=1)
							nqr_op_mini:=2
					End case 
					Case of 
						: ($operator ?? 3) & (nqr_op_maxi=-1)
							nqr_op_maxi:=1
						: ($operator ?? 3) & (nqr_op_maxi=0)
							nqr_op_maxi:=2
						: (Not:C34($operator ?? 3)) & (nqr_op_maxi=-1)
							nqr_op_maxi:=0
						: (Not:C34($operator ?? 3)) & (nqr_op_maxi=1)
							nqr_op_maxi:=2
					End case 
					Case of 
						: ($operator ?? 4) & (nqr_op_count=-1)
							nqr_op_count:=1
						: ($operator ?? 4) & (nqr_op_count=0)
							nqr_op_count:=2
						: (Not:C34($operator ?? 4)) & (nqr_op_count=-1)
							nqr_op_count:=0
						: (Not:C34($operator ?? 4)) & (nqr_op_count=1)
							nqr_op_count:=2
					End case 
					Case of 
						: ($operator ?? 5) & (nqr_op_stddeviation=-1)
							nqr_op_stddeviation:=1
						: ($operator ?? 5) & (nqr_op_stddeviation=0)
							nqr_op_count:=2
						: (Not:C34($operator ?? 5)) & (nqr_op_stddeviation=-1)
							nqr_op_stddeviation:=0
						: (Not:C34($operator ?? 5)) & (nqr_op_stddeviation=1)
							nqr_op_stddeviation:=2
					End case 
			End case 
			
		End for 
		If (_nqr_oper_cell>0) | ((nqr_formula_free#"") & (nqr_formula_free#Char:C90(1)))
			nqr_op_sum:=0
			nqr_op_average:=0
			nqr_op_mini:=0
			nqr_op_maxi:=0
			nqr_op_count:=0
			nqr_op_stddeviation:=0
		End if 
		
End case 
