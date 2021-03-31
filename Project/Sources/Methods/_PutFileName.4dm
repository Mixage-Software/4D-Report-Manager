//%attributes = {"invisible":true}
  // $1 = prompt (optional) if empty string not considered
  // $2 = defaultName (optional) if empty string not considered
  // $3 = directory (optional)
  // $4 = context (optional)


C_TEXT:C284($prompt)
C_TEXT:C284($defaultName)
C_TEXT:C284($directory)
C_LONGINT:C283($context)

$prompt:=""
$defaultName:=""
$directory:=""
$context:=0
If (Count parameters:C259>0)
	$prompt:=$1
	If (Count parameters:C259>1)
		$defaultName:=$2
		If (Count parameters:C259>2)
			$directory:=$3
			If (Count parameters:C259>3)
				$context:=$4
			End if 
		End if 
	End if 
End if 

If ($defaultName#"")
	$directory:=_PathToParentPath ($directory)+$defaultName
End if 

$Options:=Use sheet window:K24:11+File name entry:K24:17
If ($context>0)
	$name:=Select document:C905($context;"";$prompt;$Options)
Else 
	$name:=Select document:C905($directory;"";$prompt;$Options)
End if 

If (OK=1)
	$0:=document
Else 
	$0:=""
End if 