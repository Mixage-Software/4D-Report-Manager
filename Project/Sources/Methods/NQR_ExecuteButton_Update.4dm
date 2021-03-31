//%attributes = {"invisible":true}
QR GET DESTINATION:C756(nqr_area;$destination)
OBJECT SET VISIBLE:C603(p_stampa;$destination=qr printer:K14903:1)  // Print
OBJECT SET VISIBLE:C603(p_genera;($destination=qr text file:K14903:2) | ($destination=qr HTML file:K14903:5))  // Execute
