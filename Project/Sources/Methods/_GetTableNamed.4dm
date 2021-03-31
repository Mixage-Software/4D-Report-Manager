//%attributes = {"invisible":true}
  // $1 table name
  // $0 pointer to table or NULL POINTER if no table with this name

  // Is there a faster way to get a pointer to a named table?
C_TEXT:C284($1)
C_POINTER:C301($tablePtr)

For ($i;1;Get last table number:C254)
	If (Is table number valid:C999($i))
		If (Table name:C256($i)=$1)
			$tablePtr:=Table:C252($i)
		End if 
	End if 
End for 

$0:=$tablePtr
