//%attributes = {"invisible":true}
  // set up the list of the tables and the fields

  //Initialization of variables
C_LONGINT:C283($table;$field)
C_TEXT:C284($title)
C_BOOLEAN:C305($index)
C_LONGINT:C283($repeat;$length;$hide;$size;$type;$style)
C_TEXT:C284($format)
C_LONGINT:C283(nqr_lh_field)
C_LONGINT:C283($i;$tt;$ttt;$ref_field2;$element)
C_LONGINT:C283($field_l;$find_table;$find_field;$ref_field;$sub_list;$ref_element)
  //C_LONGINT($subfield_list)
C_LONGINT:C283($table_parent;$ref_field3;$table_child)
C_TEXT:C284($fieldptr)
C_TEXT:C284($text)

  //initialization of the possible dialogs of subfields
  //ARRAY LONGINT($_subfield_id;0)

  //remove the old lists for their complete rebuilding.
If (Is a list:C621(nqr_lh_field))
	CLEAR LIST:C377(nqr_lh_field;*)
End if 
If (Is a list:C621(nqr_lh_field2))
	CLEAR LIST:C377(nqr_lh_field2;*)
End if 
If (Is a list:C621(nqr_lh_field3))
	CLEAR LIST:C377(nqr_lh_field3;*)
End if 

  //defensive code is case the number of the current table is lost  ...
If (_nqr_tables=0) | (_nqr_tables>Size of array:C274(_nqr_tables))
	NQR_Tables_Update (QR Get report table:C758(nqr_area))
End if 

  //assigning the information about the table
nqr_record_selection:=String:C10(Records in selection:C76(Table:C252(_nqr_table_id{_nqr_tables})->))+" "+Get indexed string:C510(14907;18)  //"record(s) in selection"
nqr_record_table:=String:C10(Records in table:C83(Table:C252(_nqr_table_id{_nqr_tables})->))+" "+Get indexed string:C510(14907;19)  //"record(s) in table"
nqr_table_name:=_nqr_tables{_nqr_tables}

  //create the list
nqr_lh_field:=New list:C375
SET LIST PROPERTIES:C387(nqr_lh_field;0;0;18;1)

Case of 
	: (nqr_cb_1=1) | (nqr_cb_2=1)  //list the fields of the current table report or related tables report
		  //get the number of the current table
		$table:=_nqr_table_id{_nqr_tables}
		
		  //loop on the fields of the current table
		For ($field_l;1;Size of array:C274(_nqr_field{$table});1)
			
			  //get the field number
			$field:=_nqr_field_id{$table}{$field_l}
			  //get the field type
			$type:=Type:C295(Field:C253($table;$field)->)
			
			  // get the position of the field in the table of the identifiers
			$find_table:=Find in array:C230(_nqr_table_id;$table)
			If ($find_table>0)
				$find_field:=Find in array:C230(_nqr_field_id{$table};$field)
			Else   //defensive code in case of a problem
				$find_field:=-1
			End if 
			
			Case of 
				: ($find_table<0)  //problem with the table; nothing to make
				: ($find_field<0)  //problem with the field; nothing to make
				: ($type=Is BLOB:K8:12)  //is a blob ; nothing to make because a blob can't be in a quick report
				: ($type=Is subtable:K8:11)  //is a subtable ; build a list of the subfields
					  //read the list of subfields
					  //GET FIELD TITLES(Field($table;$field)->;$_subfield;$_subfield_id)  //not supported, but functional
					  //$subfield_list:=New list
					  //For ($subfield;1;Size of array($_subfield);1)
					  //  //build a reference to the subfield
					  //$ref_subfield:=($_subfield_id{$subfield} << 24)+($table << 16)+$field
					  //APPEND TO LIST($subfield_list;$_subfield{$subfield};$ref_subfield)
					  //SET LIST ITEM PROPERTIES($subfield_list;$ref_subfield;False;Plain;Use PicRef+14950+Type(Field($table;$field;$_subfield_id{$subfield})->))
					  //End for
					
					  //  //build a reference to the field
					  //$ref_field:=($table << 16)+$field
					  //  //add the field to the list
					  //APPEND TO LIST(nqr_lh_field;_nqr_field{$table}{$find_field};$ref_field;$subfield_list;True)
					  //SET LIST ITEM PROPERTIES(nqr_lh_field;$ref_field;False;Plain;NQR_TypeIcon ($table;$field))
					
				Else   //is a valid field; add this one to the list
					  //build a reference to the field
					$ref_field:=($table << 16)+$field
					  //see if the field is indexed
					GET FIELD PROPERTIES:C258($table;$field;$type;$length;$index)
					If ($index)
						$style:=Bold:K14:2
					Else 
						$style:=Plain:K14:1
					End if 
					
					If (nqr_cb_1=1)  // If we are not showing related tables we are finished
						  //add the field to the list
						APPEND TO LIST:C376(nqr_lh_field;_nqr_field{$table}{$find_field};$ref_field)
						SET LIST ITEM PROPERTIES:C386(nqr_lh_field;$ref_field;False:C215;$style;NQR_Icon_FieldType ($table;$field))
					Else   // check for related items
						$sub_list:=0  //set sublist flag to zero
						
						  //look on the known relations
						For ($tt;1;Size of array:C274(_nqr_table_child);1)
							  //is the relationship outbound or a child relationship
							If (_nqr_table_child{$tt}=$table) & (_nqr_field_child{$tt}=$field)  //this is the starting field of a child relationship
								If (_nqr_Oneauto{$tt})  //the relationship is automatic (the calculation of the report will be possible)
									  //find the parent table
									$find_table:=Find in array:C230(_nqr_table_id;_nqr_table_parent{$tt})
									If ($find_table>0)
										  //if the sublist does not exist yet, to create it
										If ($sub_list=0)
											$sub_list:=New list:C375
										End if 
										  //the selected reference is - the number of the relation
										$ref_field2:=-$tt
										  //add the table to the list
										APPEND TO LIST:C376($sub_list;"["+_nqr_tables{$find_table}+"]";$ref_field2)
										SET LIST ITEM PROPERTIES:C386($sub_list;$ref_field2;False:C215;Bold:K14:2;"path:/RESOURCES/Images/ToOne.png")
									End if 
								End if 
							End if 
							  //is the relationship a return or parent relationship
							If (_nqr_table_parent{$tt}=$table) & (_nqr_field_parent{$tt}=$field)  //this is the related field in the parent table
								If (_nqr_manyauto{$tt}) & (nqr_allowautomatic=1)  //the relationship is automatic (the calculation of the report will be possible) and the relationship returns are authorized
									  //find the child table
									$find_table:=Find in array:C230(_nqr_table_id;_nqr_table_child{$tt})
									If ($find_table>0)
										  //if the sublist does not exist yet, to create it
										If ($sub_list=0)
											$sub_list:=New list:C375
										End if 
										  //the selected reference is - the number of the shifted relation of 16 bits
										$ref_field2:=-($tt << 16)
										  //add the table to the list
										APPEND TO LIST:C376($sub_list;"["+_nqr_tables{$find_table}+"]";$ref_field2)
										SET LIST ITEM PROPERTIES:C386($sub_list;$ref_field2;False:C215;Bold:K14:2;"path:/RESOURCES/Images/ToMany.png")
									End if 
								End if 
							End if 
						End for 
						  //add the field to the list with the possiblity of related tables
						APPEND TO LIST:C376(nqr_lh_field;_nqr_field{$table}{$find_field};$ref_field;$sub_list;True:C214)
						SET LIST ITEM PROPERTIES:C386(nqr_lh_field;$ref_field;False:C215;$style;NQR_Icon_FieldType ($table;$field))
					End if 
					
			End case 
		End for 
		
		If (nqr_cb_2=1)  //list related tables
			$element:=0  //one starts at the beginning !
			  //analyse all of the elements of the obtained list
			While ($element<Count list items:C380(nqr_lh_field))
				$element:=$element+1  //pass to the element according to
				  //information on the element and in particular when an associated list is attached
				GET LIST ITEM:C378(nqr_lh_field;$element;$ref_element;$text;$sub_list)
				If ($ref_element<0)  //if the reference is negative then it can have a cascade
					If (((-$ref_element) >> 16)>0)
						  //a relationship exists
						  //to see the parent table
						$table_parent:=_nqr_table_child{((-$ref_element) >> 16)}
						  //loop on all the relations
						For ($ttt;1;Size of array:C274(_nqr_table_parent))
							If (_nqr_table_parent{$ttt}=$table_parent)  //this is the parent table
								If (_nqr_manyauto{$ttt}) & (nqr_allowautomatic=1)  //the relationship is automatic (the calculation of the report will be possible) and the relationship returns are authorized
									  //find the child table in the array
									$find_table:=Find in array:C230(_nqr_table_id;_nqr_table_child{$ttt})
									If ($find_table>0)
										  //if the sublist does not exist yet, to create it
										If ($sub_list=0)
											$sub_list:=New list:C375
										End if 
										$ref_field3:=-($ttt << 16)
										APPEND TO LIST:C376($sub_list;"["+_nqr_tables{$find_table}+"]";$ref_field3)
										SET LIST ITEM PROPERTIES:C386($sub_list;$ref_field3;False:C215;Bold:K14:2;"path:/RESOURCES/Images/ToMany.png")
									End if 
								End if 
							End if 
						End for 
						  //modify the element to add the new sublist under this element
						SET LIST ITEM:C385(nqr_lh_field;$ref_element;$text;$ref_element;$sub_list;True:C214)
					Else 
						  //is a relationship from the child table
						  //find the parent table
						$table_child:=_nqr_table_parent{-$ref_element}
						  //loop on all the relations
						For ($ttt;1;Size of array:C274(_nqr_table_child))
							If (_nqr_table_child{$ttt}=$table_child)  //This is the child table
								If (_nqr_Oneauto{$ttt})  //the relationship is automatic (the calculation of the report will be possible)
									  //find the parent table in the array
									$find_table:=Find in array:C230(_nqr_table_id;_nqr_table_parent{$ttt})
									If ($find_table>0)
										  //if the sublist does not exist yet, to create it
										If ($sub_list=0)
											$sub_list:=New list:C375
										End if 
										$ref_field3:=-$ttt
										APPEND TO LIST:C376($sub_list;"["+_nqr_tables{$find_table}+"]";$ref_field3)
										SET LIST ITEM PROPERTIES:C386($sub_list;$ref_field3;False:C215;Bold:K14:2;"path:/RESOURCES/Images/ToOne.png")
									End if 
								End if 
							End if 
						End for 
						  //modify the element to add the new sublist under this element
						SET LIST ITEM:C385(nqr_lh_field;$ref_element;$text;$ref_element;$sub_list;True:C214)
					End if 
					
				End if 
			End while 
		End if 
		
	: (nqr_cb_3=1)  //list of all the tables
		  //loop throught all the tables
		For ($i;1;Size of array:C274(_nqr_table_id);1)
			  //get the table number
			$table:=_nqr_table_id{$i}
			  //create a new list
			$sub_list:=New list:C375
			  //loop on the fields of the table
			For ($field_l;1;Size of array:C274(_nqr_field{$table});1)
				  //get the field number
				$field:=_nqr_field_id{$table}{$field_l}
				  //ge the field type
				$type:=Type:C295(Field:C253($table;$field)->)
				
				  // get the position of the field in the table of the identifiers
				$find_table:=Find in array:C230(_nqr_table_id;$table)
				If ($find_table>0)
					$find_field:=Find in array:C230(_nqr_field_id{$table};$field)
				Else   //defensive code in case of a problem
					$find_field:=-1
				End if 
				Case of 
					: ($find_table<0)  //problem with the table; nothing to make
					: ($find_field<0)  //problem with the field; nothing to make
					: ($type=Is BLOB:K8:12)  //is a blob ; nothing to make because a blob can't be in a quick report
					: ($type=Is subtable:K8:11)  //is a subtable ; build a list of the subfields
						  //  //read the list of subfields
						  //GET FIELD TITLES(Field($table;$field)->;$_subfield;$_subfield_id)
						  //$subfield_list:=New list
						  //For ($subfield;1;Size of array($_subfield);1)
						  //$ref_subfield:=($_subfield_id{$subfield} << 24)+($table << 16)+$field
						  //APPEND TO LIST($subfield_list;$_subfield{$subfield};$ref_subfield)
						  //SET LIST ITEM PROPERTIES($subfield_list;$ref_subfield;False;Plain;Use PicRef+14950+Type(Field($table;$field;$_subfield_id{$subfield})->))
						  //End for
						
						  //$ref_field:=($table << 16)+$field
						  //APPEND TO LIST($sub_list;_nqr_field{$table}{$find_field};$ref_field;$subfield_list;True)
						  //SET LIST ITEM PROPERTIES($sub_list;$ref_field;False;Plain;NQR_TypeIcon ($table;$field))
					Else 
						$ref_field:=($table << 16)+$field
						APPEND TO LIST:C376($sub_list;_nqr_field{$table}{$find_field};$ref_field)
						GET FIELD PROPERTIES:C258($table;$field;$type;$length;$index)
						If ($index)
							$style:=Bold:K14:2
						Else 
							$style:=Plain:K14:1
						End if 
						SET LIST ITEM PROPERTIES:C386($sub_list;$ref_field;False:C215;$style;NQR_Icon_FieldType ($table;$field))
				End case 
			End for 
			APPEND TO LIST:C376(nqr_lh_field;"["+_nqr_tables{$i}+"]";$table << 16;$sub_list;False:C215)
			SET LIST ITEM PROPERTIES:C386(nqr_lh_field;$table << 16;False:C215;Bold:K14:2;"path:/RESOURCES/Images/Table.png")
			
		End for 
		
	: (nqr_cb_5=1)  //list columns
		For ($i;1;QR Count columns:C764(nqr_area))
			QR GET INFO COLUMN:C766(nqr_area;$i;$title;$fieldptr;$hide;$size;$repeat;$format)
			APPEND TO LIST:C376(nqr_lh_field;$title;$i)
			SET LIST ITEM PROPERTIES:C386(nqr_lh_field;$i;False:C215;Plain:K14:1;"path:/RESOURCES/Images/Column.png")
		End for 
		
End case 

  //copy the hierarchial lists
nqr_lh_field2:=Copy list:C626(nqr_lh_field)
nqr_lh_field3:=Copy list:C626(nqr_lh_field)

  //update the new list  properties
SET LIST PROPERTIES:C387(nqr_lh_field2;0;0;18;1)
SET LIST PROPERTIES:C387(nqr_lh_field3;0;0;18;1)

  //posting of the fields (in the event of relations)
NQR_View_Fields 
  //posting of the sorting
NQR_List_Get_Sorts 