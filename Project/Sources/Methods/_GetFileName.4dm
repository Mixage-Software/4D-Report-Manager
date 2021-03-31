//%attributes = {"invisible":true}
  // $1 = prompt (optional) if empty string not considered
  // $2 = file type (optional) if empty string not considered
  // $3 = directory (optional) if empty string not considered

C_TEXT:C284($prompt)
C_TEXT:C284($type)
C_TEXT:C284($directory)

$prompt:=""
$type:=""
$directory:=""
If (Count parameters:C259>0)
	$prompt:=$1
	If (Count parameters:C259>1)
		$type:=$2
		If (Count parameters:C259>2)
			$directory:=$3
			$test:=Test path name:C476($directory)
			If ($test#Is a folder:K24:2)
				$directory:=_PathToParentPath ($directory)
			End if 
		End if 
	End if 
End if 

$Options:=Package selection:K24:9+Use sheet window:K24:11

$name:=Select document:C905($directory;$type;$prompt;$Options)

If (OK=1) & (Test path name:C476(document)=Is a document:K24:1)
	$0:=document
Else 
	$0:=""
End if 