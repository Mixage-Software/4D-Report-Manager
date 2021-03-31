//%attributes = {"invisible":true}
  // Modify current selected report if user allowed
  // $0 returns True if the record has been modified

$0:=False:C215
$owner:=Current user:C182=gQR_ReportOwnerPtr->
$isAdmin:=_IsAdmin 
$canModify:=(gQR_ReportProtectedPtr->=False:C215) | $owner | $isAdmin
If ($canModify)
	If (nqr_allowautomatic=1)
		SET AUTOMATIC RELATIONS:C310(True:C214;True:C214)
	End if 
	DIALOG:C40("NQR_Dialog")
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	$0:=(ok=1)
Else 
	$mess:=Get indexed string:C510(14908;160)
	ALERT:C41($mess+" "+gQR_ReportOwnerPtr->)
End if 



