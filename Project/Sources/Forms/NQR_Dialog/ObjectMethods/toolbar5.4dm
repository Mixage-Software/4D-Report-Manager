If (FORM Get current page:C276#17)
	FORM GOTO PAGE:C247(17)
	NQR_List_Get_Selection (17)
Else 
	OBJECT SET VISIBLE:C603(*;"nqr_step@";True:C214)
	FORM GOTO PAGE:C247(1)
End if 