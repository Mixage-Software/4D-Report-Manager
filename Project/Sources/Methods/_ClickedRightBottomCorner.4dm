//%attributes = {"invisible":true}
  // $1 button variable pointer
  // $2 right bottom corner width/height size
  // $0 boolean - Was the last mouse click inside popup arrow rect?


C_POINTER:C301($1)
C_LONGINT:C283($2)

OBJECT GET COORDINATES:C663($1->;$left;$top;$right;$bottom)

$arrowRectSize:=$2
$left:=$right-$arrowRectSize
$top:=$bottom-$arrowRectSize

GET MOUSE:C468($mouseX;$mouseY;$mouseButton)
$0:=_PointInRect ($mouseX;$mouseY;$left;$top;$right;$bottom)