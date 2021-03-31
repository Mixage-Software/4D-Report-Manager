C_LONGINT:C283($evt)
C_LONGINT:C283($t;$x;$y)
C_LONGINT:C283($position_drop;$find;$pos_item;$ref_popup;$col;$order)
C_LONGINT:C283($repeat;$hide;$size;$element;$process)
C_LONGINT:C283($table;$field;$column;$type)
  //C_POINTER($source;$field_old)
C_TEXT:C284($title)
C_TEXT:C284($format)
C_TEXT:C284($fieldobj;$name;$text;$texte)


$evt:=Form event code:C388
Case of 
	: ($evt=On Drag Over:K2:13)
		_O_DRAG AND DROP PROPERTIES:C607($source;$element;$process)
		RESOLVE POINTER:C394($source;$name;$table;$field)
		$0:=-1
		Case of 
			: ($source=Self:C308)
				$0:=0
			: ($name="nqr_lh_column2")
				GET LIST ITEM:C378(nqr_lh_column2;Selected list items:C379(nqr_lh_column2);$column;$text)
				QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
				QR GET INFO COLUMN:C766(nqr_area;$column;$title;$fieldobj;$hide;$size;$repeat;$format)
				$type:=NQR_VirtualField_GetType ($fieldobj)
				If ($type#Is text:K8:3) & ($type#Is picture:K8:10) & (Position:C15("'";$fieldobj)<=0)
					$0:=0
				End if 
		End case   //
		
	: ($evt=On Drop:K2:12)
		_O_DRAG AND DROP PROPERTIES:C607($source;$element;$process)
		RESOLVE POINTER:C394($source;$name;$table;$field)
		
		$position_drop:=Drop position:C608
		
		Case of 
			: ($source=Self:C308)
				If ($position_drop#-1)
					$col:=_nqr_col{$element}
					$order:=_nqr_order{$element}
					INSERT IN ARRAY:C227(_nqr_col;$position_drop)
					INSERT IN ARRAY:C227(_nqr_order;$position_drop)
					$find:=Find in array:C230(_nqr_col;$col)
					DELETE FROM ARRAY:C228(_nqr_col;$find)
					DELETE FROM ARRAY:C228(_nqr_order;$find)
					$find:=Find in array:C230(_nqr_col;0)
					_nqr_col{$find}:=$col
					_nqr_order{$find}:=$order
					
					QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
					
					NQR_List_Get_Sorts 
				End if 
				
			: ($name="nqr_lh_column2")
				GET LIST ITEM:C378(nqr_lh_column2;Selected list items:C379(nqr_lh_column2);$column;$text)
				QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
				QR GET INFO COLUMN:C766(nqr_area;$column;$title;$fieldobj;$hide;$size;$repeat;$format)
				$type:=NQR_VirtualField_GetType ($fieldobj)
				If ($type#Is text:K8:3) & ($type#Is picture:K8:10)
					$find:=Find in array:C230(_nqr_col;$column)
					If ($find<0)
						If ($position_drop=-1)
							$t:=Size of array:C274(_nqr_col)+1
						Else 
							$t:=$position_drop
						End if 
						INSERT IN ARRAY:C227(_nqr_col;$t)
						INSERT IN ARRAY:C227(_nqr_order;$t)
						_nqr_col{$t}:=$column
						_nqr_order{$t}:=1
						QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
						NQR_List_Get_Sorts 
					Else 
						SELECT LIST ITEMS BY POSITION:C381(nqr_lh_sort2;$find)
					End if 
				End if 
		End case 
		
		
	: ($evt=On Clicked:K2:4)
		
		QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
		$pos_item:=Selected list items:C379(nqr_lh_sort2)
		
		If ($pos_item>0)
			GET MOUSE:C468($x;$y;$b)
			
			OBJECT GET COORDINATES:C663(nqr_lh_sort2;$g;$h;$d;$b)
			
			$x:=$x-$g
			
			Case of 
				: ($x>0) & ($x<18)
					
					_nqr_order{$pos_item}:=-_nqr_order{$pos_item}
					QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
					SET LIST ITEM PROPERTIES:C386(nqr_lh_sort2;$pos_item;False:C215;Plain:K14:1;NQR_Icon_SortOrder (_nqr_order{$pos_item}))
					
				: (Contextual click:C713)
					$texte:=Get indexed string:C510(14907;103)+";"
					$texte:=$texte+"-;"
					$texte:=$texte+("("*Num:C11($pos_item=1))+Get indexed string:C510(14907;101)+";"
					$texte:=$texte+("("*Num:C11($pos_item=Count list items:C380(nqr_lh_sort)))+Get indexed string:C510(14907;102)+";"
					
					$ref_popup:=Pop up menu:C542($texte;0)
					Case of 
						: ($ref_popup=1)  //supprimer
							DELETE FROM ARRAY:C228(_nqr_order;$pos_item;1)
							DELETE FROM ARRAY:C228(_nqr_col;$pos_item;1)
							QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
							nqr_current_col:=0
							NQR_List_Get_Sorts 
							
						: ($ref_popup=3)  //monter
							$col:=_nqr_col{$pos_item}
							$order:=_nqr_order{$pos_item}
							_nqr_col{$pos_item}:=_nqr_col{$pos_item-1}
							_nqr_order{$pos_item}:=_nqr_order{$pos_item-1}
							_nqr_col{$pos_item-1}:=$col
							_nqr_order{$pos_item-1}:=$order
							$pos_item:=$pos_item-1
							QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
							nqr_current_col:=0
							
							NQR_List_Get_Sorts 
							
						: ($ref_popup=4)  //Descendre
							$col:=_nqr_col{$pos_item}
							$order:=_nqr_order{$pos_item}
							_nqr_col{$pos_item}:=_nqr_col{$pos_item+1}
							_nqr_order{$pos_item}:=_nqr_order{$pos_item+1}
							_nqr_col{$pos_item+1}:=$col
							_nqr_order{$pos_item+1}:=$order
							$pos_item:=$pos_item+1
							QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
							nqr_current_col:=0
							
							NQR_List_Get_Sorts 
							
					End case 
					
			End case 
			
			
		End if 
		nqr_current_col:=_nqr_col{$pos_item}
		
		NQR_Select_Column 
		
End case 
