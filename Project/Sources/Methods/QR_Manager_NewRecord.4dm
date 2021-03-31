//%attributes = {"invisible":true}
  // $1 new report name
  // $2 report BLOB (optional: empty report if omitted) 

C_BLOB:C604($BLOB)

$name:=$1
If (Count parameters:C259>1)
	$BLOB:=$2
End if 

$archivio:=Table:C252(gQR_MasterTablePtr)

$ok:=True:C214

$recnum:=QR_Manager_RecNumForName ($archivio;$name)
If ($recnum=-1)
	CREATE RECORD:C68(gQR_ReportTablePtr->)
	gQR_ReportNamePtr->:=$name
	gQR_ReportModifiedDatePtr->:=Current date:C33(*)
	gQR_ReportOwnerPtr->:=Current user:C182
	gQR_ReportModifiedByPtr->:=Current user:C182
	gQR_ReportMasterTableNumPtr->:=$archivio
	SAVE RECORD:C53(gQR_ReportTablePtr->)
Else 
	$mess:=Get indexed string:C510(14908;171)
	CONFIRM:C162($mess)
	If (ok=1)
		GOTO RECORD:C242(gQR_ReportTablePtr->;$recnum)
		$ok:=True:C214
	Else 
		UNLOAD RECORD:C212(gQR_ReportTablePtr->)
		$ok:=False:C215
	End if 
End if 
If ($ok)
	If (_LoadRecord (gQR_ReportTablePtr))
		gQR_ReportBLOBPtr->:=$BLOB
		COMPRESS BLOB:C534(gQR_ReportBLOBPtr->;Compact compression mode:K22:12)
		SAVE RECORD:C53(gQR_ReportTablePtr->)
	End if 
End if 
