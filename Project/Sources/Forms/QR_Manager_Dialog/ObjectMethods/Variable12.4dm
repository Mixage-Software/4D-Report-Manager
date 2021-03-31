$s:=Get indexed string:C510(14908;172)
CONFIRM:C162($s+" \""+gQR_ReportNamePtr->+"\"?")
If (ok=1)
	If (_LoadRecord (gQR_ReportTablePtr))
		DELETE RECORD:C58(gQR_ReportTablePtr->)
		QR_Manager_LB_Update 
	End if 
End if 