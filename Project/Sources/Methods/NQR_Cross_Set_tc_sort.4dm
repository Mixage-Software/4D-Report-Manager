//%attributes = {"invisible":true}
C_LONGINT:C283($repeat;$hide;$size;$find;$type;$i)
C_TEXT:C284($title)
C_TEXT:C284($format)
C_TEXT:C284($field)

Case of 
	: (nqr_tr_2=1)
		For ($i;1;2)
			QR GET INFO COLUMN:C766(nqr_area;$i;$title;$field;$hide;$size;$repeat;$format)
			$type:=NQR_VirtualField_GetType ($field)
			$find:=Find in array:C230(_nqr_col;$i)
			Case of 
				: ($i=1)  //column 1 represents the columns in the cross table report
					Case of 
						: ($type=Is text:K8:3) | ($type=Is picture:K8:10)  //nonsortable types
							nqr_b_sort_columns:=2
							If ($find>0)
								DELETE FROM ARRAY:C228(_nqr_col;$find;1)
								DELETE FROM ARRAY:C228(_nqr_order;$find;1)
							End if 
							
						: (nqr_b_sort_columns=0)  //sorting by ascending order
							If ($find<0)
								$find:=Size of array:C274(_nqr_col)+1
								INSERT IN ARRAY:C227(_nqr_col;$find;1)
								INSERT IN ARRAY:C227(_nqr_order;$find;1)
							End if 
							_nqr_col{$find}:=1
							_nqr_order{$find}:=1
							
						: (nqr_b_sort_columns=1)  //sorting by decending order
							If ($find<0)
								$find:=Size of array:C274(_nqr_col)+1
								INSERT IN ARRAY:C227(_nqr_col;$find;1)
								INSERT IN ARRAY:C227(_nqr_order;$find;1)
							End if 
							_nqr_col{$find}:=1
							_nqr_order{$find}:=-1
							
						: (nqr_b_sort_columns=2)  //no sorting
							If ($find>0)
								DELETE FROM ARRAY:C228(_nqr_col;$find;1)
								DELETE FROM ARRAY:C228(_nqr_order;$find;1)
							End if 
					End case 
					
					
				: ($i=2)  // column 2 represents the rows in the cross table report
					Case of 
						: ($type=Is text:K8:3) | ($type=Is picture:K8:10)  //nonsortable types
							nqr_b_sort_rows:=2
							If ($find>0)
								DELETE FROM ARRAY:C228(_nqr_col;$find;1)
								DELETE FROM ARRAY:C228(_nqr_order;$find;1)
							End if 
							
						: (nqr_b_sort_rows=0)  //sorting by ascending order
							If ($find<0)
								$find:=Size of array:C274(_nqr_col)+1
								INSERT IN ARRAY:C227(_nqr_col;$find;1)
								INSERT IN ARRAY:C227(_nqr_order;$find;1)
							End if 
							_nqr_col{$find}:=2
							_nqr_order{$find}:=1
							
						: (nqr_b_sort_rows=1)  //sorting by descending order
							If ($find<0)
								$find:=Size of array:C274(_nqr_col)+1
								INSERT IN ARRAY:C227(_nqr_col;$find;1)
								INSERT IN ARRAY:C227(_nqr_order;$find;1)
							End if 
							_nqr_col{$find}:=2
							_nqr_order{$find}:=-1
							
						: (nqr_b_sort_rows=2)  //no sorting
							If ($find>0)
								DELETE FROM ARRAY:C228(_nqr_col;$find;1)
								DELETE FROM ARRAY:C228(_nqr_order;$find;1)
							End if 
					End case 
					
			End case 
			
		End for 
		
		  //set the sorting choices
		QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
		  //update the sorting information
		NQR_Cross_Get_Sorts 
End case 
