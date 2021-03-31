C_TIME:C306($ref)
$ref:=Open document:C264("";"";Read mode:K24:5)
If (ok=1)
	nqr_model_html:=document
	CLOSE DOCUMENT:C267($ref)
	QR SET HTML TEMPLATE:C750(nqr_area;nqr_model_html)
End if 