//%attributes = {"invisible":true}
  // $1 text
  // $0 text without extension

$text:=$1

$pos:=_LastPosition (".";$text)
If ($pos#0)
	$text:=Substring:C12($text;1;$pos-1)
End if 

$0:=$text