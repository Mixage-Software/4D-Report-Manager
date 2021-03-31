//%attributes = {"invisible":true}
C_TEXT:C284($1;$0)
C_LONGINT:C283($position;$table;$counter)
C_LONGINT:C283($find)
C_TEXT:C284($field;$table_num)
C_TEXT:C284($table_name;$field_name;$counter_name)

  //from the name of the real field, to find the name of the virtual field
$field:=$1
If ($field="[@")
	$position:=Position:C15("]";$field)
	If ($position>0)
		$table_name:=Substring:C12($field;2;$position-2)
		$field_name:=Substring:C12($field;$position+1)
		For ($table;1;Get last table number:C254;1)
			If (Is table number valid:C999($table))
				
				If (Table name:C256($table)=$table_name)
					For ($counter;1;Get last field number:C255($table);1)
						
						If (Is field number valid:C1000($table;$counter))
							If (Field name:C257($table;$counter)=$field_name)
								$find:=Find in array:C230(_nqr_table_id;$table)
								If ($find>0)
									$table_num:=_nqr_tables{$find}
								Else   //defensive code
									$table_num:=""
								End if 
								$find:=Find in array:C230(_nqr_field_id{$table};$counter)
								If ($find>0)
									$counter_name:=_nqr_field{$table}{$find}
								Else   //defensive code
									$counter_name:=""
								End if 
								$field:="["+$table_num+"]"+$counter_name
								$counter:=512
								$table:=256
							End if 
							
						End if 
					End for 
				End if 
				
			End if 
		End for 
	End if 
End if 
$0:=$field