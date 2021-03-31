$reportKind:=QR Get report kind:C755(nqr_area)
If ($reportKind=qr cross report:K14902:2)
	NQR_Borders_ApplyCrossSettings 
Else 
	NQR_Borders_ApplyListSettings 
End if 

NQR_Borders_UpdatePreview 
