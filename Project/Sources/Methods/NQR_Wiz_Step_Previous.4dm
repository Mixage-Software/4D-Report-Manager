//%attributes = {"invisible":true}
  // begin by move back two steps
nqr_step_current:=nqr_step_current-2
If (nqr_step_current=-1)  // if the current value of the step is -1
	nqr_step_current:=0  // move back only one step
End if 

NQR_Wiz_Step_Next 