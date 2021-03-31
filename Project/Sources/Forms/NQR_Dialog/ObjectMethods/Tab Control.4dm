If (Self:C308->=1)
	  // Header
	nqr_header_footer_section:=qr header:K14906:4
Else 
	  // Footer
	nqr_header_footer_section:=qr footer:K14906:5
End if 


Case of 
	: (Form event code:C388=On Load:K2:1)
		
	: (Form event code:C388=On Clicked:K2:4)
		NQR_HeaderFooter_Get (Self:C308->)
End case 


