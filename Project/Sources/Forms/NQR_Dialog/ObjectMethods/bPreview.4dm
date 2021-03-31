C_LONGINT:C283($destination)
C_TEXT:C284($option)
QR GET DESTINATION:C756(nqr_area;$destination;$option)
QR SET DESTINATION:C745(nqr_area;1)

COPY NAMED SELECTION:C331(Table:C252(QR Get report table:C758(nqr_Area))->;"QR_Selezione")
QR EXECUTE COMMAND:C791(nqr_area;qr cmd print preview:K14900:25)  //qr cmd print preview )
USE NAMED SELECTION:C332("QR_Selezione")
CLEAR NAMED SELECTION:C333("QR_Selezione")


QR SET DESTINATION:C745(nqr_area;$destination;$option)
nqr_record_selection:=String:C10(Records in selection:C76(Table:C252(_nqr_table_id{_nqr_tables})->))+" "+Get indexed string:C510(14907;18)  //"record(s) in selection"
nqr_record_table:=String:C10(Records in table:C83(Table:C252(_nqr_table_id{_nqr_tables})->))+" "+Get indexed string:C510(14907;19)  //"record(s) in table"
nqr_table_name:=_nqr_tables{_nqr_tables}

nqr_bPreview:=0