C_BOOLEAN:C305($present)
C_LONGINT:C283($evt;$ref_popup;$col;$order)
C_LONGINT:C283($i;$position;$find;$t;$pos_item;$x;$y)
C_POINTER:C301($source)
C_TEXT:C284($title;$name;$fieldobj)
C_LONGINT:C283($repeat;$hide;$size;$element;$process;$column;$table;$field;$subfield;$type)
C_LONGINT:C283($list_field;$ref_field)
C_TEXT:C284($format;$text;$table_name;$field_name;$text;$texte)

$evt:=Form event code:C388
Case of 
	: ($evt=On Drag Over:K2:13)
		_O_DRAG AND DROP PROPERTIES:C607($source;$element;$process)
		RESOLVE POINTER:C394($source;$name;$table;$field)
		$0:=-1
		
		Case of 
			: ($source=Self:C308)
				$0:=0
			: (nqr_cb_5=1)
				$0:=0
			: ($name="nqr_lh_field@")
				Case of 
					: ($name="nqr_lh_field")
						$list_field:=nqr_lh_field
					: ($name="nqr_lh_field_detail")
						$list_field:=nqr_lh_field_detail
				End case 
				If (Selected list items:C379($list_field)>0)
					GET LIST ITEM:C378($list_field;Selected list items:C379($list_field);$ref_field;$text)
					If ($ref_field>0)
						$table:=($ref_field & 0x00FFFFFF) >> 16
						$field:=$ref_field & 0xFFFF
						$subfield:=$ref_field >> 24
						
						Case of 
							: ($field>0) & ($subfield=0)
								$type:=Type:C295(Field:C253($table;$field)->)
								If ($table>0) & ($field>0) & ($type#Is text:K8:3) & ($type#Is picture:K8:10) & ($type#Is subtable:K8:11)
									$0:=0
								End if 
							: ($field>0) & ($subfield>0)
								  //nothing to do because one can not sort according to subfields
						End case 
					End if 
				End if 
		End case 
		
	: ($evt=On Drop:K2:12)
		_O_DRAG AND DROP PROPERTIES:C607($source;$element;$process)
		RESOLVE POINTER:C394($source;$name;$table;$field)
		$position:=Drop position:C608
		
		
		Case of 
			: ($source=Self:C308)
				If ($position#-1)
					$col:=_nqr_col{$element}
					$order:=_nqr_order{$element}
					INSERT IN ARRAY:C227(_nqr_col;$position)
					INSERT IN ARRAY:C227(_nqr_order;$position)
					$find:=Find in array:C230(_nqr_col;$col)
					DELETE FROM ARRAY:C228(_nqr_col;$find)
					DELETE FROM ARRAY:C228(_nqr_order;$find)
					$find:=Find in array:C230(_nqr_col;0)
					_nqr_col{$find}:=$col
					_nqr_order{$find}:=$order
					
					QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
					
					NQR_List_Get_Sorts 
					NQR_List_Select_Sorts ($t)
					NQR_Select_Column 
				End if 
				
			: (nqr_cb_5=1)  //list of columns
				$column:=Selected list items:C379(nqr_lh_field)
				If ($column>0) & ($column<=Count list items:C380(nqr_lh_field))
					QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
					$find:=Find in array:C230(_nqr_col;$column)
					If ($find<0)
						APPEND TO ARRAY:C911(_nqr_col;$column)
						APPEND TO ARRAY:C911(_nqr_order;1)
						QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
						
						NQR_List_Get_Sorts 
						NQR_List_Select_Sorts ($t)
						NQR_Select_Column 
						
					End if 
				End if 
				
			: ($name="nqr_lh_field@")
				Case of 
					: ($name="nqr_lh_field")
						$list_field:=nqr_lh_field
					: ($name="nqr_lh_field_detail")
						$list_field:=nqr_lh_field_detail
				End case 
				GET LIST ITEM:C378($list_field;Selected list items:C379($list_field);$ref_field;$text)
				$table:=($ref_field & 0x00FFFFFF) >> 16
				$field:=$ref_field & 0xFFFF
				$subfield:=$ref_field >> 24
				Case of 
					: ($field>0) & ($subfield=0)
						$type:=Type:C295(Field:C253($table;$field)->)
						If ($table>0) & ($field>0) & ($type#Is text:K8:3) & ($type#Is picture:K8:10) & ($type#Is subtable:K8:11)
							QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
							$present:=False:C215
							$table_name:=Table name:C256($table)
							$field_name:=Field name:C257($table;$field)
							For ($i;1;QR Count columns:C764(nqr_area);1)
								QR GET INFO COLUMN:C766(nqr_area;$i;$title;$fieldobj;$hide;$size;$repeat;$format)
								Case of 
									: ($fieldobj#("["+$table_name+"]"+$field_name))
									Else 
										$present:=True:C214
										$column:=$i
								End case 
							End for 
							Case of 
								: ($present=True:C214)
									If (Find in array:C230(_nqr_col;$column)<0)
										If ($position=-1)
											$t:=Size of array:C274(_nqr_col)+1
										Else 
											$t:=$position
										End if 
										INSERT IN ARRAY:C227(_nqr_col;$t)
										INSERT IN ARRAY:C227(_nqr_order;$t)
										_nqr_col{$t}:=$column
										_nqr_order{$t}:=1
										QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
										
										NQR_List_Get_Sorts 
										NQR_List_Select_Sorts ($column)
										NQR_Select_Column 
										
									End if 
								: ($present=False:C215)
									$column:=QR Count columns:C764(nqr_area)+1
									QR INSERT COLUMN:C748(nqr_area;$column;Field:C253($table;$field))
									If ($position=-1)
										$t:=Size of array:C274(_nqr_col)+1
									Else 
										$t:=$position
									End if 
									INSERT IN ARRAY:C227(_nqr_col;$t)
									INSERT IN ARRAY:C227(_nqr_order;$t)
									_nqr_col{$t}:=$column
									_nqr_order{$t}:=1
									QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
									
									NQR_List_Get_Sorts 
									NQR_List_Select_Sorts ($column)
									NQR_Select_Column 
									
							End case 
						End if 
					: ($field>0) & ($subfield>0)
						  //nothing to do because one can not sort according to subfields
						
				End case 
		End case 
		
		
	: ($evt=On Clicked:K2:4)
		
		QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
		$pos_item:=Selected list items:C379(nqr_lh_sort)
		
		If ($pos_item>0)
			GET MOUSE:C468($x;$y;$b)
			
			OBJECT GET COORDINATES:C663(nqr_lh_sort;$g;$h;$d;$b)
			
			$x:=$x-$g
			
			Case of 
				: ($x>0) & ($x<18)  //change the order of sorting by click on the arrow
					_nqr_order{$pos_item}:=-_nqr_order{$pos_item}
					QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
					SET LIST ITEM PROPERTIES:C386(nqr_lh_sort;$pos_item;False:C215;Plain:K14:1;NQR_Icon_SortOrder (_nqr_order{$pos_item}))
					
					
				: (Contextual click:C713)
					$texte:=Get indexed string:C510(14907;103)+";"
					$texte:=$texte+"-;"
					$texte:=$texte+("("*Num:C11($pos_item=1))+Get indexed string:C510(14907;101)+";"
					$texte:=$texte+("("*Num:C11($pos_item=Count list items:C380(nqr_lh_sort)))+Get indexed string:C510(14907;102)+";"
					
					$ref_popup:=Pop up menu:C542($texte;0)
					Case of 
						: ($ref_popup=1)  //remove
							DELETE FROM ARRAY:C228(_nqr_order;$pos_item;1)
							DELETE FROM ARRAY:C228(_nqr_col;$pos_item;1)
							QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
							nqr_current_col:=0
							NQR_List_Get_Sorts 
							
							
						: ($ref_popup=3)  //go up
							$col:=_nqr_col{$pos_item}
							$order:=_nqr_order{$pos_item}
							_nqr_col{$pos_item}:=_nqr_col{$pos_item-1}
							_nqr_order{$pos_item}:=_nqr_order{$pos_item-1}
							_nqr_col{$pos_item-1}:=$col
							_nqr_order{$pos_item-1}:=$order
							QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
							nqr_current_col:=0
							
							NQR_List_Get_Sorts 
							NQR_List_Select_Sorts ($col)
							NQR_Select_Column 
							
							SELECT LIST ITEMS BY POSITION:C381(nqr_lh_sort;Count list items:C380(nqr_lh_sort)+1)
							
						: ($ref_popup=4)  //go down
							$col:=_nqr_col{$pos_item}
							$order:=_nqr_order{$pos_item}
							_nqr_col{$pos_item}:=_nqr_col{$pos_item+1}
							_nqr_order{$pos_item}:=_nqr_order{$pos_item+1}
							_nqr_col{$pos_item+1}:=$col
							_nqr_order{$pos_item+1}:=$order
							QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
							nqr_current_col:=0
							
							NQR_List_Get_Sorts 
							NQR_List_Select_Sorts ($col)
							NQR_Select_Column 
							
							SELECT LIST ITEMS BY POSITION:C381(nqr_lh_sort;Count list items:C380(nqr_lh_sort)+1)
							
					End case 
			End case 
			
			If ($pos_item<=Size of array:C274(_nqr_col))
				nqr_current_col:=_nqr_col{$pos_item}
			Else 
				$pos_item:=$pos_item-1
				nqr_current_col:=_nqr_col{$pos_item}
			End if 
		End if 
		
		NQR_Select_Column 
		
End case 
