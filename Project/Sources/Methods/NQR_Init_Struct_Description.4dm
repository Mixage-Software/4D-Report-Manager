//%attributes = {"invisible":true}
C_LONGINT:C283($id_table;$field;$table_dest;$field_dest;$choicefield)
C_LONGINT:C283($table)
C_LONGINT:C283($nb_table;$id_table)
C_BOOLEAN:C305($autoOne;$autoMany)


  // the two dimension arrays for fields by table
$nb_table:=Get last table number:C254
ARRAY TEXT:C222(_nqr_field;$nb_table;0)
ARRAY LONGINT:C221(_nqr_field_id;$nb_table;0)

  // the arrays for handling the relationships
ARRAY INTEGER:C220(_nqr_table_child;0)
ARRAY INTEGER:C220(_nqr_field_child;0)
ARRAY INTEGER:C220(_nqr_table_parent;0)
ARRAY INTEGER:C220(_nqr_field_parent;0)
ARRAY BOOLEAN:C223(_nqr_Oneauto;0)
ARRAY BOOLEAN:C223(_nqr_manyauto;0)

  // loop on the list of the VISIBLE tables to find the fields and the relations
For ($table;1;Size of array:C274(_nqr_table_id);1)
	
	  // get the number of the table to work upon
	$id_table:=_nqr_table_id{$table}
	GET TABLE PROPERTIES:C687($id_table;$invisible)
	
	  // read the list of the fields and place them in the tables created for this purpose
	GET FIELD TITLES:C804(Table:C252($id_table)->;$_field;$_id)
	COPY ARRAY:C226($_field;_nqr_field{$id_table})
	COPY ARRAY:C226($_id;_nqr_field_id{$id_table})
	
	  // research the relations to the current table
	For ($field;1;Get last field number:C255($id_table);1)
		  // read the nature of the relationship
		GET RELATION PROPERTIES:C686($id_table;$field;$table_dest;$field_dest;$choicefield;$autoOne;$autoMany)
		
		  // if a relationship exists
		If ($field_dest#0) & ($table_dest#0)
			  // read the properties of the relationship in the context of the current table
			GET FIELD RELATION:C920(Field:C253($id_table;$field)->;$one2;$many2;*)
			Case of 
				: ($one2=2)
					$autoOne:=False:C215
				: ($one2=3)
					$autoOne:=True:C214
				Else   // defensive code (useless in theory)
					$autoOne:=False:C215
			End case 
			Case of 
				: ($many2=2)
					$autoMany:=False:C215
				: ($many2=3)
					$autoMany:=True:C214
				Else   // defensive code (useless in theory)
					$autoOne:=False:C215
			End case 
			
			  // add the values to the relationship arrays
			APPEND TO ARRAY:C911(_nqr_table_child;$id_table)
			APPEND TO ARRAY:C911(_nqr_field_child;$field)
			APPEND TO ARRAY:C911(_nqr_table_parent;$table_dest)
			APPEND TO ARRAY:C911(_nqr_field_parent;$field_dest)
			APPEND TO ARRAY:C911(_nqr_Oneauto;$autoOne)
			APPEND TO ARRAY:C911(_nqr_manyauto;$autoMany)
		End if 
		
	End for 
	
	
End for 

  // sort the table arrays by alphabetical order
SORT ARRAY:C229(_nqr_tables;_nqr_table_id)

