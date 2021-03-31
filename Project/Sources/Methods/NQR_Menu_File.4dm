//%attributes = {"invisible":true}
  // $1 action

If (Count parameters:C259=0)
	$item:=Num:C11(Get selected menu item parameter:C1005)
Else 
	$item:=$1
End if 

Case of 
	: ($item=1)  // new
		$kind:=QR Get report kind:C755(nqr_area)
		QR DELETE OFFSCREEN AREA:C754(nqr_area)
		QR NEW AREA:C1320(->nqr_area)
		QR SET REPORT KIND:C738(nqr_area;$kind)
		NQR_Init 
		
	: ($item=2)  // open
		C_TEXT:C284(gQR_DefaultDestination)
		$s:=Get indexed string:C510(14908;173)
		$path:=_GetFileName ($s;gQR_Estensione;gQR_DefaultDestination)
		If ($path#"")
			gQR_DefaultDestination:=_PathToParentPath ($path)
			gQR_Filename:=$path
			C_BLOB:C604($BLOB)
			DOCUMENT TO BLOB:C525(gQR_Filename;$BLOB)  //data fork
			QR BLOB TO REPORT:C771(nqr_area;$BLOB)
			NQR_Init 
		End if 
		
	: ($item=3)  // save
		If (gQR_ReportManager)
			QR_Manager_SaveRecord (nqr_Area)
		Else 
			C_TEXT:C284(gQR_Filename)
			If (gQR_Filename#"")
				NQR_Save (gQR_Filename)
			Else 
				NQR_SaveAs 
			End if 
		End if 
		
	: ($item=4)  // save as
		NQR_SaveAs 
		
	: ($item=5)  // page setup
		C_LONGINT:C283($destination)
		C_TEXT:C284($option_text)
		QR GET DESTINATION:C756(nqr_area;$destination;$option_text)
		QR SET DESTINATION:C745(nqr_area;qr printer:K14903:1)
		QR EXECUTE COMMAND:C791(nqr_area;qr cmd page setup:K14900:24)
		QR SET DESTINATION:C745(nqr_area;$destination;$option_text)
		
End case 