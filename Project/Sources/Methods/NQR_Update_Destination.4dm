//%attributes = {"invisible":true}
C_LONGINT:C283($destination)
C_TEXT:C284($option_text)

OBJECT SET ENABLED:C1123(nqr_sc_3;Is license available:C714(4D View license:K44:4))
QR GET DESTINATION:C756(nqr_area;$destination;$option_text)

nqr_sc_1:=0
nqr_sc_2:=0
nqr_sc_3:=0
nqr_sc_4:=0
nqr_sc_5:=0
OBJECT SET VISIBLE:C603(*;"nqr_dest_@";False:C215)

Case of 
	: ($destination=1)
		nqr_sc_1:=1
		nqr_explanation_4:=Get indexed string:C510(14931;14927)
		OBJECT SET VISIBLE:C603(*;"nqr_dest_4";True:C214)
		
	: ($destination=2)
		nqr_sc_2:=1
		nqr_explanation_2:=Get indexed string:C510(14931;14914)
		nqr_FldDelimit:=FldDelimit
		nqr_RecDelimit:=RecDelimit
		
	: ($destination=3)
		nqr_sc_3:=1
		nqr_explanation_4:=Get indexed string:C510(14931;14928)
		OBJECT SET VISIBLE:C603(*;"nqr_dest_4";True:C214)
		
	: ($destination=4)
		nqr_sc_4:=1
		nqr_explanation_4:=Get indexed string:C510(14931;14929)
		OBJECT SET VISIBLE:C603(*;"nqr_dest_4";True:C214)
		
	: ($destination=5)
		nqr_sc_5:=1
		nqr_explanation_3:=Get indexed string:C510(14931;14915)
		
	: ($destination=6)
		nqr_sc_5:=1
		nqr_explanation_3:=Get indexed string:C510(14931;14915)
		
End case 
OBJECT SET VISIBLE:C603(*;"nqr_dest_file@";(nqr_sc_2=1))
OBJECT SET VISIBLE:C603(*;"nqr_dest_html@";(nqr_sc_5=1))
Case of 
	: (nqr_sc_2=1)
		QR GET DESTINATION:C756(nqr_area;$destination;nqr_result_file)
	: (nqr_sc_5=1)
		nqr_model_html:=QR Get HTML template:C751(nqr_area)
		QR GET DESTINATION:C756(nqr_area;$destination;nqr_result_html)
End case 

