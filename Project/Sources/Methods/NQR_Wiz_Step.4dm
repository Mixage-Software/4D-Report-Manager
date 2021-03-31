//%attributes = {"invisible":true}
C_LONGINT:C283($1;$step_target)

$step_target:=$1
Case of 
	: (FORM Get current page:C276=1)  //defensive programming in case there is a page error
	: ($step_target=nqr_step_current)  // nothing to make in this case
	: ($step_target>nqr_step_maximum)  // nothing to make (improbable case in theory)
	: (Not:C34(nqr_step_following_ok)) & ($step_target>nqr_step_current)  //continuing to the next step is not authorized
		BEEP:C151
	Else 
		  //one pass to step completed
		nqr_step_current:=$step_target-1
		NQR_Wiz_Step_Next 
End case 