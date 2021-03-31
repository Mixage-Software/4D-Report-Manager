//%attributes = {"invisible":true}
  // $1 sort order

C_LONGINT:C283($sortOrder;$1)

$sortOrder:=$1
$iconPath:="path:/RESOURCES/Images/"+String:C10(652+Num:C11($sortOrder=-1))+".png"
$0:=$iconPath