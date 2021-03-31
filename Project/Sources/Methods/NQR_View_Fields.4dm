//%attributes = {"invisible":true}
  //initialization
C_BOOLEAN:C305($index;$continue)
C_LONGINT:C283($field_l;$find_table;$find_field)
C_LONGINT:C283($length)
C_LONGINT:C283($list_field;$list_detail;$h1;$h2;$h3)
C_LONGINT:C283($item;$ref_field;$table;$field;$type;$style)
  //C_LONGINT($subfield_list;$ref_subfield)
C_TEXT:C284($suffix;$text)

  //choose the co-ordinates according to the page
$continue:=True:C214
$currentPage:=FORM Get current page:C276
Case of 
	: ($currentPage=1)
		$list_field:=nqr_lh_field
		$list_detail:=nqr_lh_field_detail
		$h1:=162
		$h2:=84
		$h3:=90
		$suffix:=""
		
	: ($currentPage=3)
		$list_field:=nqr_lh_field2
		$list_detail:=nqr_lh_field_detail2
		$h1:=158
		$h2:=64
		$h3:=70
		$suffix:="2"
		
	: ($currentPage=7)
		$list_field:=nqr_lh_field3
		$list_detail:=nqr_lh_field_detail3
		$h1:=205
		$h2:=110
		$h3:=116
		$suffix:="3"
		
	Else   //defensive code
		$continue:=False:C215
End case 

If ($continue)
	  //get the information on the selected item
	$item:=Selected list items:C379($list_field)
	GET LIST ITEM:C378($list_field;$item;$ref_field;$text)
	
	Case of 
		: ($ref_field>=0)  //is a field or subfield
			  //get the position of the main list
			OBJECT GET COORDINATES:C663(*;("nqr_lh_field"+$suffix);$g;$h;$d;$b)
			  //move the main list
			OBJECT MOVE:C664(*;("nqr_lh_field"+$suffix);$g;$h;$d;$h+$h1;*)
			  //the secondary list is rejected if it is out of the visible zone
			OBJECT MOVE:C664(*;("nqr_lh_field_detail"+$suffix);10000;10000;10000;10000;*)
			SELECT LIST ITEMS BY POSITION:C381($list_field;$item)
			
		: ($ref_field<0)  //is a table
			  //get the position of the main list
			OBJECT GET COORDINATES:C663(*;("nqr_lh_field"+$suffix);$g;$h;$d;$b)
			  //move the main list
			OBJECT MOVE:C664(*;("nqr_lh_field"+$suffix);$g;$h;$d;$h+$h2;*)
			  //the other half is for the secondary list
			OBJECT MOVE:C664(*;("nqr_lh_field_detail"+$suffix);$g;$h+$h3;$d;$h+$h1;*)
			SELECT LIST ITEMS BY REFERENCE:C630($list_field;$ref_field)
			
			  //initialize the list of the dependent fields
			If (Is a list:C621($list_detail))
				CLEAR LIST:C377($list_detail;*)
			End if 
			$list_detail:=New list:C375
			SET LIST PROPERTIES:C387($list_detail;0;0;18;1)
			
			  //get the table number of the dependent table
			If (((-$ref_field & 0x00FFFFFF) >> 16)>0)
				$table:=_nqr_table_child{(-$ref_field & 0x00FFFFFF) >> 16}
			Else 
				$table:=_nqr_table_parent{(-$ref_field & 0x00FFFFFF)}
			End if 
			
			  //loop on the fields of the dependent table
			For ($field_l;1;Size of array:C274(_nqr_field{$table});1)
				$field:=_nqr_field_id{$table}{$field_l}
				$type:=Type:C295(Field:C253($table;$field)->)
				$find_table:=Find in array:C230(_nqr_table_id;$table)
				If ($find_table>0)
					$find_field:=Find in array:C230(_nqr_field_id{$table};$field)
				Else 
					$find_field:=-1
				End if 
				Case of 
					: ($find_table<0)
					: ($find_field<0)
					: ($type=Is BLOB:K8:12)
					: ($type=Is subtable:K8:11)
						
						  //GET FIELD TITLES(Field($table;$field)->;$_subfield;$_subfield_id)
						  //$subfield_list:=New list
						  //For ($subfield;1;Size of array($_subfield);1)
						  //$ref_subfield:=($_subfield_id{$subfield} << 24)+($table << 16)+$field
						  //APPEND TO LIST($subfield_list;$_subfield{$subfield};$ref_subfield)
						  //SET LIST ITEM PROPERTIES($subfield_list;$ref_subfield;False;Plain;1150+Type(Field($table;$field;$_subfield_id{$subfield})->))
						  //End for 
						
						  //$ref_field:=($table << 16)+$field
						  //APPEND TO LIST($list_detail;_nqr_field{$table}{$find_field};$ref_field;$subfield_list;True)
						  //SET LIST ITEM PROPERTIES($list_detail;$ref_field;False;Plain;1150+Type(Field($table;$field)->))
						
					Else 
						$ref_field:=($table << 16)+$field
						GET FIELD PROPERTIES:C258($table;$field;$type;$length;$index)
						If ($index)
							$style:=Bold:K14:2
						Else 
							$style:=Plain:K14:1
						End if 
						APPEND TO LIST:C376($list_detail;"["+_nqr_tables{$find_table}+"]"+_nqr_field{$table}{$find_field};$ref_field)
						SET LIST ITEM PROPERTIES:C386($list_detail;$ref_field;False:C215;$style;NQR_Icon_FieldType ($table;$field))
				End case 
			End for 
			
			SELECT LIST ITEMS BY POSITION:C381($list_detail;1)
			
			  //update the information in the lists
			Case of 
				: ($currentPage=1)
					nqr_lh_field_detail:=$list_detail
					GOTO OBJECT:C206(nqr_lh_field_detail)
					If (Is a list:C621(nqr_lh_field_detail))
						SET LIST PROPERTIES:C387(nqr_lh_field_detail;0;0;18;1)
					End if 
					
				: ($currentPage=3)
					nqr_lh_field_detail2:=$list_detail
					GOTO OBJECT:C206(nqr_lh_field_detail2)
					If (Is a list:C621(nqr_lh_field_detail2))
						SET LIST PROPERTIES:C387(nqr_lh_field_detail2;0;0;18;1)
					End if 
					
				: ($currentPage=7)
					nqr_lh_field_detail3:=$list_detail
					GOTO OBJECT:C206(nqr_lh_field_detail3)
					If (Is a list:C621(nqr_lh_field_detail3))
						SET LIST PROPERTIES:C387(nqr_lh_field_detail3;0;0;18;1)
					End if 
			End case 
			
	End case 
End if 