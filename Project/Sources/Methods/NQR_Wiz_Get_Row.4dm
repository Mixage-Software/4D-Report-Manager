//%attributes = {"invisible":true}
C_BOOLEAN:C305($aff_op)
C_LONGINT:C283($operator;$break)
C_LONGINT:C283($i;$find)
C_TEXT:C284($text)
Case of 
	: (FORM Get current page:C276=5)
		
		nqr_Computations:=Get indexed string:C510(14907;41)  //"Column computations"
		OBJECT SET VISIBLE:C603(*;"rectCol";False:C215)
		OBJECT SET VISIBLE:C603(*;"Border";True:C214)
		OBJECT SET VISIBLE:C603(*;"rectCel";False:C215)
		
		nqr_op_sum:=-1
		nqr_op_average:=-1
		nqr_op_mini:=-1
		nqr_op_maxi:=-1
		nqr_op_count:=-1
		nqr_op_stddeviation:=-1
		_nqr_oper_cell:=-1
		nqr_formula_free:=Char:C90(1)
		Case of 
			: (nqr_current_row=1)  //header
				$aff_op:=False:C215
				nqr_op_sum:=0
				nqr_op_average:=0
				nqr_op_mini:=0
				nqr_op_maxi:=0
				nqr_op_count:=0
				nqr_op_stddeviation:=0
				_nqr_oper_cell:=0
				nqr_formula_free:=""
			: (nqr_current_row=2)  //detail
				$aff_op:=False:C215
				nqr_op_sum:=0
				nqr_op_average:=0
				nqr_op_mini:=0
				nqr_op_maxi:=0
				nqr_op_count:=0
				nqr_op_stddeviation:=0
				_nqr_oper_cell:=0
				nqr_formula_free:=""
			Else 
				$aff_op:=True:C214
				If (nqr_current_row=nqr_nb_rows)
					$break:=-3
				Else 
					$break:=nqr_current_row-2
				End if 
				For ($i;1;QR Count columns:C764(nqr_area);1)
					QR GET TOTALS DATA:C768(nqr_area;$i;$break;$operator;$text)
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
						Else 
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
									nqr_op_stddeviation:=2
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
		
		If (nqr_formula_free=Char:C90(1))
			nqr_formula_free:=""
		End if 
		
		OBJECT SET ENABLED:C1123(*;"formula_button@";$aff_op)
		OBJECT SET ENTERABLE:C238(nqr_formula_free;$aff_op)
		OBJECT SET VISIBLE:C603(*;"cb2Cache@";$aff_op)
End case 
