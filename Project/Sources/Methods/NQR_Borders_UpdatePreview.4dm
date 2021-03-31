//%attributes = {"invisible":true}
$reportKind:=QR Get report kind:C755(nqr_area)
If ($reportKind=qr cross report:K14902:2)
	NQR_Borders_DrawCrossPreview 
Else 
	NQR_Borders_DrawListPreview 
End if 