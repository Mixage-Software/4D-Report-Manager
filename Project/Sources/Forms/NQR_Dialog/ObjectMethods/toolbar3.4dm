If (FORM Get current page:C276#16)
	FORM GOTO PAGE:C247(16)
	NQR_Borders_UpdatePreview 
	NQR_List_Get_Selection (16)
Else 
	OBJECT SET VISIBLE:C603(*;"nqr_step@";True:C214)
	FORM GOTO PAGE:C247(1)
End if 
