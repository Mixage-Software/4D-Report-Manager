//%attributes = {"invisible":true}
  // $1 path

C_TEXT:C284($path)

$path:=$1
gQR_DefaultDestination:=_PathToParentPath ($path)
C_BLOB:C604($BLOB)
QR REPORT TO BLOB:C770(nqr_area;$BLOB)
gQR_Filename:=_TextWithoutExtension ($path)+"."+gQR_Estensione
BLOB TO DOCUMENT:C526(gQR_Filename;$BLOB)