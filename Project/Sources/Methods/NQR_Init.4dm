//%attributes = {"invisible":true}
QR SET REPORT TABLE:C757(nqr_area;Table:C252(gQR_MasterTablePtr))

If (Is a list:C621(nqr_lh_sort))
	CLEAR LIST:C377(nqr_lh_sort;*)
End if 
If (Is a list:C621(nqr_lh_sort2))
	CLEAR LIST:C377(nqr_lh_sort2;*)
End if 
nqr_lh_sort:=New list:C375

NQR_Tables_Update (QR Get report table:C758(nqr_area))

nqr_sc_1:=0  // Printer
nqr_sc_2:=0  // Text File
nqr_sc_3:=0  // 4D View - NOT SUPPORTED
nqr_sc_4:=0  // 4D Chart - NOT SUPPORTED
nqr_sc_5:=0  // HTML File

C_LONGINT:C283($destination)
C_TEXT:C284($option_text)
QR GET DESTINATION:C756(nqr_area;$destination;$option_text)
If ($destination=qr 4D View area:K14903:3) | ($destination=_O_qr 4D Chart area:K14903:4)
	QR SET DESTINATION:C745(nqr_area;qr printer:K14903:1)
End if 
(Get pointer:C304("nqr_sc_"+String:C10($destination)))->:=1

NQR_Get_Fields 

  //set up the types of reports : (1) list report (2) cross tab report
$type_etat:=QR Get report kind:C755(nqr_area)
If ($type_etat=qr list report:K14902:1)
	nqr_tr_1:=1
	nqr_tr_2:=0
	OBJECT SET FORMAT:C236(nqr_tr_1;"1;4;#Images/14934.png;64")
	OBJECT SET FORMAT:C236(nqr_tr_2;"1;4;#Images/14935.png;208")
	OBJECT SET ENABLED:C1123(*;"bp1@";True:C214)
	NQR_List_Get_Sorts 
Else 
	nqr_tr_1:=0
	nqr_tr_2:=1
	OBJECT SET FORMAT:C236(nqr_tr_2;"1;4;#Images/14935.png;64")
	OBJECT SET FORMAT:C236(nqr_tr_1;"1;4;#Images/14934.png;208")
	OBJECT SET ENABLED:C1123(*;"bp1@";False:C215)
	NQR_Cross_Get_Sorts 
End if 
OBJECT SET VISIBLE:C603(*;"toolbar_BreakSettings@";QR Get report kind:C755(nqr_area)=qr list report:K14902:1)

NQR_ManualMode 
NQR_ExecuteButton_Update 
NQR_HeaderFooter_Get (nqr_tab_header_footer_selector)
