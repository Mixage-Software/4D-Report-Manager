//%attributes = {"invisible":true}
  // $1 QR area
  // $2 row number
  // $0 real section number

C_LONGINT:C283($1;$Lon_area;$2;$Lon_row;$0)

$Lon_area:=$1
$Lon_row:=$2

$reportKind:=QR Get report kind:C755($Lon_area)

If ($reportKind=qr cross report:K14902:2)
	
	$0:=$Lon_row
	
Else 
	
	Case of 
		: ($Lon_row=1)
			$Lon_row:=qr title:K14906:1
		: ($Lon_row=2)
			$Lon_row:=qr detail:K14906:2
		: ($Lon_row=_QR_CountRows ($Lon_area))
			$Lon_row:=qr grand total:K14906:3
		: ($Lon_row>2)
			$Lon_row:=$Lon_row-2  // breaks
	End case 
End if 

$0:=$Lon_row
