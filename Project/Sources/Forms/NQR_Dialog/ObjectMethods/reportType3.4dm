
C_LONGINT:C283($evt)
C_LONGINT:C283($i)
C_LONGINT:C283($report_type)
$evt:=Form event code:C388
nqr_tr_1:=0
nqr_tr_2:=1
Case of 
	: ($evt=On Clicked:K2:4)
		$report_type:=QR Get report kind:C755(nqr_area)
		If ($report_type#2)
			nqr_step_maximum:=1
			For ($i;nqr_step_maximum+1;10;1)
				OBJECT SET VISIBLE:C603(*;"bttn"+String:C10($i);False:C215)
				Get pointer:C304("nqr_step_"+String:C10($i))->:=""
			End for 
			OBJECT SET ENABLED:C1123(nqr_b_Step_Next;True:C214)
			nqr_step_following_ok:=True:C214
			OBJECT SET RGB COLORS:C628(*;"step_"+String:C10($i);0x0000)  // Black
			OBJECT SET ENABLED:C1123(*;"Btn_p7@";True:C214)
			OBJECT SET VISIBLE:C603(*;"p7_@";True:C214)
		End if 
		QR SET REPORT KIND:C738(nqr_area;2)
		NQR_Wiz_Step_Next 
End case 
OBJECT SET FORMAT:C236(nqr_tr_2;"1;4;#Images/14935.png;64")
OBJECT SET FORMAT:C236(nqr_tr_1;"1;4;#Images/14934.png;208")
OBJECT SET ENABLED:C1123(*;"bp1@";False:C215)