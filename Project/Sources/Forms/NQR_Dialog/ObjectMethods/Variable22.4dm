Case of 
	: (Form event code:C388=On After Keystroke:K2:26)
		$text:=Get edited text:C655
		
End case 

nqr_operator:=-2
NQR_Wiz_List_Set_Cell_Formula ($text)
