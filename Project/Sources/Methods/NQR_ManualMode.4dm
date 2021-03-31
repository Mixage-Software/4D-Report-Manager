//%attributes = {"invisible":true}
If (FORM Get current page:C276#1)
	  //we return to manual mode; the size of the plugin zone is adapted
	C_LONGINT:C283($view;$g;$h;$d;$b)
	OBJECT GET COORDINATES:C663(nqr_area;$g;$h;$d;$b)
	OBJECT MOVE:C664(nqr_area;$g;$h;$d;$b+110;*)
	FORM GOTO PAGE:C247(1)
	For ($view;1;7)
		QR SET AREA PROPERTY:C796(nqr_area;$view;1)
	End for 
	OBJECT SET ENABLED:C1123(nqr_b_Step_Previous;False:C215)
	
	OBJECT SET VISIBLE:C603(*;"toolbar@";True:C214)
	OBJECT SET VISIBLE:C603(*;"toolbar_BreakSettings@";QR Get report kind:C755(nqr_area)=qr list report:K14902:1)
	OBJECT GET COORDINATES:C663(*;"nqr_area";$left;$top;$right;$bottom)
	OBJECT SET COORDINATES:C1248(*;"nqr_area";$left;$top+30;$right;$bottom)
	
	NQR_ExecuteButton_Update 
	
	ENABLE MENU ITEM:C149(1;0)
	
End if 