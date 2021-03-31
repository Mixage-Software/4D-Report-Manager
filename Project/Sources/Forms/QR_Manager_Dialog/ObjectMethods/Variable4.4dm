C_BLOB:C604($BLOB)

C_TEXT:C284(gQR_DefaultDestination)
$s:=Get indexed string:C510(14908;173)
$path:=_GetFileName ($s;gQR_Estensione;gQR_DefaultDestination)
If ($path#"")
	$path:=document
	DOCUMENT TO BLOB:C525($path;$BLOB)  //data fork
	QR_Manager_NewRecord (_TextWithoutExtension (_PathToFileName ($path));$BLOB)
	$recnum:=Record number:C243(gQR_ReportTablePtr->)
	QR_Manager_LB_Update ($recnum)
End if 