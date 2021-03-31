//%attributes = {"invisible":true}
$command:=$1

COPY NAMED SELECTION:C331(Table:C252(QR Get report table:C758(nqr_area))->;"QR_Selezione")
SET AUTOMATIC RELATIONS:C310(True:C214;True:C214)  //this may modify selection...
QR EXECUTE COMMAND:C791(nqr_area;$command)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
USE NAMED SELECTION:C332("QR_Selezione")
CLEAR NAMED SELECTION:C333("QR_Selezione")