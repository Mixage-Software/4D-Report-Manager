//%attributes = {"invisible":true}
C_BOOLEAN:C305($delete)
C_TEXT:C284($title)
C_LONGINT:C283($repeat;$hide;$size)
C_TEXT:C284($format)
C_LONGINT:C283($i;$table;$field;$type)
C_TEXT:C284($fieldobj;$table_name;$field_name)

Case of 
	: (nqr_tr_1=1)
		OBJECT SET VISIBLE:C603(*;"sort_tc@";False:C215)
		OBJECT SET VISIBLE:C603(*;"sort_list@";True:C214)
		
		QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
		
		$i:=1
		While ($i<=Size of array:C274(_nqr_col))
			QR GET INFO COLUMN:C766(nqr_area;_nqr_col{$i};$title;$fieldobj;$hide;$size;$repeat;$format)
			$delete:=False:C215
			If (Position:C15("'";$fieldobj)<=0)
				For ($table;1;Size of array:C274(_nqr_tables))
					$table_name:="["+_nqr_tables{$table}+"]"
					For ($field;1;Size of array:C274(_nqr_field{_nqr_table_id{$table}}))
						$field_name:=$table_name+_nqr_field{_nqr_table_id{$table}}{$field}
						If ($field_name=$fieldobj)
							$type:=Type:C295(Field:C253(_nqr_table_id{$table};_nqr_field_id{_nqr_table_id{$table}}{$field})->)
							If ($type=Is text:K8:3) | ($type=Is picture:K8:10) | ($type=Is BLOB:K8:12)
								$delete:=True:C214
								DELETE FROM ARRAY:C228(_nqr_col;$i;1)
								DELETE FROM ARRAY:C228(_nqr_order;$i;1)
							End if 
						End if 
					End for 
				End for 
			Else 
				$delete:=True:C214
				DELETE FROM ARRAY:C228(_nqr_col;$i;1)
				DELETE FROM ARRAY:C228(_nqr_order;$i;1)
			End if 
			If ($delete=False:C215)
				$i:=$i+1
			End if 
		End while 
		If (Count parameters:C259=0)
			QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
		End if 
		nqr_nb_rows:=Size of array:C274(_nqr_col)+3
		
		If (Is a list:C621(nqr_lh_sort))
			CLEAR LIST:C377(nqr_lh_sort;*)
		End if 
		nqr_lh_sort:=New list:C375
		For ($i;1;Size of array:C274(_nqr_col))
			QR GET INFO COLUMN:C766(nqr_area;_nqr_col{$i};$title;$fieldobj;$hide;$size;$repeat;$format)
			$fieldobj:=NQR_VirtualField_GetName ($fieldobj)
			APPEND TO LIST:C376(nqr_lh_sort;$fieldobj;$i)
			SET LIST ITEM PROPERTIES:C386(nqr_lh_sort;$i;False:C215;Plain:K14:1;NQR_Icon_SortOrder (_nqr_order{$i}))
		End for 
		nqr_lh_sort2:=Copy list:C626(nqr_lh_sort)
		nqr_lh_sort3:=Copy list:C626(nqr_lh_sort)
End case 
