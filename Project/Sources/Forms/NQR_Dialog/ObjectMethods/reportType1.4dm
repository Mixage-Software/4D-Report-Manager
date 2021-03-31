
C_TEXT:C284($title)
C_LONGINT:C283($repeat;$visible;$size;$column)
C_TEXT:C284($format;$field_new)

QR SET REPORT KIND:C738(nqr_area;2)
$column:=1
QR GET INFO COLUMN:C766(nqr_area;$column;$title;$field_new;$visible;$size;$repeat;$format)
nqr_tc_column:=$field_new
$column:=2
QR GET INFO COLUMN:C766(nqr_area;$column;$title;$field_new;$visible;$size;$repeat;$format)
nqr_tc_row:=$field_new
$column:=3
QR GET INFO COLUMN:C766(nqr_area;$column;$title;$field_new;$visible;$size;$repeat;$format)
nqr_tc_cell:=$field_new

nqr_tr_1:=0
nqr_tr_2:=1
OBJECT SET FORMAT:C236(nqr_tr_2;"1;4;#Images/14935.png;64")
OBJECT SET FORMAT:C236(nqr_tr_1;"1;4;#Images/14934.png;208")
OBJECT SET ENABLED:C1123(*;"bp1@";False:C215)
OBJECT SET VISIBLE:C603(*;"toolbar_BreakSettings@";QR Get report kind:C755(nqr_area)=qr list report:K14902:1)

NQR_Cross_Get_Sorts 