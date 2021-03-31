//%attributes = {"invisible":true}
  // $1 record number (optional)
  // Loads all reports of current master table in the listbox 
  // If a record number is specified, the listbox row corresponding to specified record number is selected

QUERY:C277(gQR_ReportTablePtr->;gQR_ReportMasterTableNumPtr->=Table:C252(gQR_MasterTablePtr))
ORDER BY:C49(gQR_ReportTablePtr->;gQR_ReportNamePtr->)
UNLOAD RECORD:C212(gQR_ReportTablePtr->)

  // https://kb.4d.com/assetid=75758
  //%W-518.2
ARRAY LONGINT:C221(aQR_ReportRecNum;0)
SELECTION TO ARRAY:C260(gQR_ReportNamePtr->;aQR_ReportName;gQR_ReportTablePtr->;aQR_ReportRecNum)
LISTBOX SELECT ROW:C912(LB_QR_Reports;0;lk remove from selection:K53:3)
aQR_ReportName:=0

If (Count parameters:C259>0)
	$recnum:=$1
	$n:=Find in array:C230(aQR_ReportRecNum;$recnum)
	If ($n#-1)
		LISTBOX SELECT ROW:C912(LB_QR_Reports;$n)
		aQR_ReportName:=$n
		GOTO OBJECT:C206(LB_QR_Reports)
		GOTO SELECTED RECORD:C245(gQR_ReportTablePtr->;$n)
	End if 
End if 