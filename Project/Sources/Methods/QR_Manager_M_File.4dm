//%attributes = {"invisible":true}
  // Report manager menu handler

If (Count parameters:C259=0)
	
	  // called from menu
	CALL FORM:C1391(gQR_ReportFormWindow;"QR_Manager_M_File";"Cancel")
	
Else 
	
	  // called from form
	$param:=$1
	Case of 
		: ($param="Cancel")
			CANCEL:C270
			
	End case 
	
End if 