//%attributes = {"invisible":true}
C_TEXT:C284($1)  //name of the field
C_LONGINT:C283($0)  //field type

C_LONGINT:C283($counter)
C_LONGINT:C283($position;$type;$table)
C_TEXT:C284($field;$field_name;$table_name)

$type:=0
$field:=$1
If ($field="[@")
	$position:=Position:C15("]";$field)
	If ($position>0)
		$table_name:=Substring:C12($field;2;$position-2)
		$field_name:=Substring:C12($field;$position+1)
		For ($table;1;Get last table number:C254;1)
			If (Table name:C256($table)=$table_name)
				For ($counter;1;Get last field number:C255($table);1)
					If (Field name:C257($table;$counter)=$field_name)
						$type:=Type:C295(Field:C253($table;$counter)->)
						$counter:=512
						$table:=256
					End if 
				End for 
			End if 
		End for 
	End if 
End if 
$0:=$type