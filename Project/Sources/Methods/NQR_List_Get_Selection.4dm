//%attributes = {"invisible":true}
C_BOOLEAN:C305($column;$row;$cell;$selectedNone)
C_LONGINT:C283($left;$top;$right;$bottom)
C_LONGINT:C283($num_columns;$find)

If (Count parameters:C259=0)
	$currentPage:=FORM Get current page:C276
Else 
	$currentPage:=$1
End if 

QR GET SELECTION:C793(nqr_area;$left;$top;$right;$bottom)
$num_columns:=QR Count columns:C764(nqr_area)
  //set the variables in function
$selectedNone:=False:C215
$selectedAll:=False:C215

Case of 
	: ($top=0) & ($bottom=nqr_nb_rows) & ($left=$right)  //a column
		$column:=True:C214
		$row:=False:C215
		$cell:=False:C215
		nqr_current_col:=$left
		nqr_current_row:=0
		nqr_current_cc:=0
		nqr_current_cl:=0
		
	: ($left=0) & ($right=$num_columns) & ($top=$bottom)  //a row
		$column:=False:C215
		$row:=True:C214
		$cell:=False:C215
		nqr_current_col:=0
		nqr_current_row:=$top
		nqr_current_cc:=0
		nqr_current_cl:=0
		
	: ($left#-1) & ($left=$right) & ($top=$bottom)  //a cell
		$column:=False:C215
		$row:=False:C215
		$cell:=True:C214
		nqr_current_col:=0
		nqr_current_row:=0
		nqr_current_cc:=$left
		nqr_current_cl:=$top
		
	Else   // all or none :)
		If ($top=-1) | ($left=-1)
			$selectedNone:=True:C214  // none
		Else 
			$selectedAll:=True:C214
		End if 
		$column:=False:C215
		$row:=False:C215
		$cell:=False:C215
		nqr_current_col:=0
		nqr_current_row:=0
		nqr_current_cc:=0
		nqr_current_cl:=0
		
End case 


Case of 
	: (nqr_tr_1=1)
		nqr_Computations:=Get indexed string:C510(14907;37)
		
		  // update the interface according to the current page
		Case of 
			: ($currentPage=1) | ($currentPage>=16)
				
				If ($currentPage=1)
					If ($column)
						QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
						$find:=Find in array:C230(_nqr_col;nqr_current_col)
						If ($find>0)
							SELECT LIST ITEMS BY REFERENCE:C630(nqr_lh_sort;$find)
						Else 
							SELECT LIST ITEMS BY POSITION:C381(nqr_lh_sort;Count list items:C380(nqr_lh_sort)+1)
						End if 
					Else 
						SELECT LIST ITEMS BY POSITION:C381(nqr_lh_sort;Count list items:C380(nqr_lh_sort)+1)
					End if 
				End if 
				
				nqr_page_break:=0
				nqr_extra_space:=0
				nqr_extra_space_kind:=1
				nqr_extra_space_value:=0
				QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
				$isBreak:=(nqr_current_row>2) & (nqr_current_row<(3+Size of array:C274(_nqr_col)))
				If ($isBreak)
					$breakLevel:=nqr_current_row-2
					QR GET TOTALS SPACING:C762(nqr_area;$breakLevel;$value)
					Case of 
						: ($value=32000)
							nqr_page_break:=1
						: ($value>0)
							nqr_extra_space:=1
							nqr_extra_space_kind:=1
							nqr_extra_space_value:=$value
						: ($value<0)
							nqr_extra_space:=1
							nqr_extra_space_kind:=2
							nqr_extra_space_value:=-$value
					End case 
				End if 
				
				OBJECT SET ENABLED:C1123(*;"@_BreakSettings@";$isBreak & ($currentPage=1))
				
				OBJECT SET ENABLED:C1123(*;"ApplySettings@";Not:C34($selectedNone))
				OBJECT SET ENABLED:C1123(vb_ApplyInside;$selectedAll)
				OBJECT SET ENABLED:C1123(bGetBorders;$cell)
				
				
			: ($currentPage=3) & ($column)
				If (nqr_current_col>0)
					SELECT LIST ITEMS BY REFERENCE:C630(nqr_lh_column;nqr_current_col)
				Else 
					SELECT LIST ITEMS BY POSITION:C381(nqr_lh_column;Count list items:C380(nqr_lh_column)+1)
				End if 
				
			: ($currentPage=3)
				SELECT LIST ITEMS BY POSITION:C381(nqr_lh_column;Count list items:C380(nqr_lh_column)+1)
				
			: ($currentPage=4) & ($column)
				QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
				$find:=Find in array:C230(_nqr_col;nqr_current_col)
				If ($find>0)
					SELECT LIST ITEMS BY REFERENCE:C630(nqr_lh_sort2;$find)
				Else 
					SELECT LIST ITEMS BY POSITION:C381(nqr_lh_sort2;Count list items:C380(nqr_lh_sort2)+1)
				End if 
				
			: ($currentPage=4)
				SELECT LIST ITEMS BY POSITION:C381(nqr_lh_sort2;Count list items:C380(nqr_lh_sort2)+1)
				
			: ($currentPage=5)
				Case of 
					: ($column)
						NQR_Wiz_Get_Column 
						
					: ($row)
						NQR_Wiz_Get_Row 
						
					: ($cell)
						NQR_Get_Cell 
						
					Else 
						OBJECT SET ENABLED:C1123(*;"formula_button@";False:C215)
						OBJECT SET ENTERABLE:C238(nqr_formula_free;False:C215)
						nqr_formula_free:=""
						OBJECT SET VISIBLE:C603(*;"cb2Cache@";False:C215)
						
				End case 
				
				
		End case 
		
	: (nqr_tr_2=1)
		  //nothing to do in this case
		
		Case of 
			: ($currentPage>=16)
				OBJECT SET ENABLED:C1123(*;"ApplySettings@";Not:C34($selectedNone))
				OBJECT SET ENABLED:C1123(vb_ApplyInside;$selectedAll)
				OBJECT SET ENABLED:C1123(bGetBorders;$cell)
				
		End case 
		
End case 
