//%attributes = {"invisible":true}
  // $1 table num
  // $2 field num

C_LONGINT:C283($table;$1;$field;$2)

$table:=$1
$field:=$2
$iconPath:="path:/RESOURCES/Images/"+String:C10(14950+Type:C295(Field:C253($table;$field)->))+".png"
$0:=$iconPath