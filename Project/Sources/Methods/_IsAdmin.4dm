//%attributes = {"invisible":true}
  // $1 user name (optional: current user if omitted)


$userName:=Current user:C182
If (Count parameters:C259>=1)
	$userName:=$1
End if 

GET USER PROPERTIES:C611(1;$designerName;$startup;$password;$nbLogin;$lastLogin)  //designer
GET USER PROPERTIES:C611(2;$adminName;$startup;$password;$nbLogin;$lastLogin)  //admin
If ($userName=$designerName) | ($userName=$adminName)
	$0:=True:C214
Else 
	$0:=User in group:C338($userName;"Amministratore")
End if 