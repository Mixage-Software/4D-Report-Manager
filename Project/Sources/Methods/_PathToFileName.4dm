//%attributes = {"invisible":true}
  // $1 file/folder path
  // $0 file/folder name (last file path component)


C_TEXT:C284($1;$0)

$0:=$1
$len:=Length:C16($1)

  // Modified by: bruno (17-12-2008)
If ($len>0)
	If ($1[[$len]]=Folder separator:K24:12)  //directory?
		$len:=$len-1
	End if 
End if 

For ($i;$len;1;-1)
	If ($1[[$i]]=Folder separator:K24:12)
		$0:=Substring:C12($1;$i+1;$len)
		$i:=1
	End if 
End for 