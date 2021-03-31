//%attributes = {"invisible":true}
  // $1 QR area
  // $0 QR rows count including breaks

C_LONGINT:C283($1;$Lon_area)
$Lon_area:=$1

$reportKind:=QR Get report kind:C755($Lon_area)
If ($reportKind=qr cross report:K14902:2)
	
	$0:=3
	
Else 
	
	ARRAY LONGINT:C221($arr1;0)
	QR GET SORTS:C753($Lon_area;$arr1;$arr1)
	$numSubTotals:=Size of array:C274($arr1)
	$countRows:=3+$numSubTotals
	$0:=$countRows
	
End if 