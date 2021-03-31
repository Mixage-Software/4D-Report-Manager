//%attributes = {"invisible":true}
  // $1 menu
  // $2 name
  // $3 shortcut
  // $4 method name
  // $5 string parameter

$menu:=$1
$name:=$2
$shortcut:=$3
$methodName:=$4
$parameter:=$5

APPEND MENU ITEM:C411($menu;$name)
$item:=Count menu items:C405($menu)
SET MENU ITEM SHORTCUT:C423($menu;$item;$shortcut)
SET MENU ITEM METHOD:C982($menu;$item;$methodName)
SET MENU ITEM PARAMETER:C1004($menu;$item;$parameter)
