//%attributes = {"invisible":true}
  // $1 character to find
  // $2 string
  // $0 position of the LAST occurrence of the specified character or 0 if not found

$charToFind:=$1
$text:=$2

$0:=0
$len:=Length:C16($text)
For ($i;$len;1;-1)
	If ($text[[$i]]=$charToFind)
		$0:=$i
		$i:=1  //break
	End if 
End for 