//%attributes = {"invisible":true}
  // $1 QR area
  // Saves the area and updates date modified and owner fields

$area:=$1

QR REPORT TO BLOB:C770($area;gQR_ReportBLOBPtr->)
gQR_ReportModifiedByPtr->:=Current user:C182
gQR_ReportModifiedDatePtr->:=Current date:C33(*)
COMPRESS BLOB:C534(gQR_ReportBLOBPtr->;Compact compression mode:K22:12)
SAVE RECORD:C53(gQR_ReportTablePtr->)