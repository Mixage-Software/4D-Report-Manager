//%attributes = {"invisible":true}
C_TEXT:C284(gQR_DefaultDestination)

$path:=_PutFileName (Get indexed string:C510(14908;164);"";gQR_DefaultDestination)
If ($path#"")
	NQR_Save ($path)
End if 