$s:=Get indexed string:C510(14908;174)
$s1:=Get indexed string:C510(14908;175)
vNome:=Request:C163("Nome:";gQR_ReportNamePtr->+" "+$s1)
If (ok=1)
	$recnum:=QR_Manager_RecNumForName (Table:C252(gQR_MasterTablePtr);vNome)
	If ($recnum=-1)
		DUPLICATE RECORD:C225(gQR_ReportTablePtr->)
		gQR_ReportNamePtr->:=vNome
		SAVE RECORD:C53(gQR_ReportTablePtr->)
		$recnum:=Record number:C243(gQR_ReportTablePtr->)
		QR_Manager_LB_Update ($recnum)
	Else 
		$s:=Get indexed string:C510(14908;176)
		BEEP:C151
		ALERT:C41($s)
	End if 
End if 