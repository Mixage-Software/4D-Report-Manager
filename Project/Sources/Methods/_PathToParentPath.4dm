//%attributes = {"invisible":true}
  // $1 file/folder path
  // $0 parent file/folder path (removes last path component)


C_TEXT:C284($1;$0)

$viLen:=Length:C16($1)

If ($viLen>0)
	If ($1[[$viLen]]=Folder separator:K24:12)  //It is a directory
		$viLen:=$viLen-1
	End if 
End if 

$viPos:=0
For ($viChar;$viLen;1;-1)
	If ($1[[$viChar]]=Folder separator:K24:12)
		$viPos:=$viChar
		$viChar:=0
	End if 
End for 
If ($viPos>0)
	$0:=Substring:C12($1;1;$viPos)
Else 
	$0:=$1
End if 