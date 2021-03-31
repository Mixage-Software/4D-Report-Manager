//%attributes = {"invisible":true}
  // $1 object name
  // $0 boolean - Was the last mouse click inside object rect?

OBJECT GET COORDINATES:C663(*;$1;$left;$top;$right;$bottom)
GET MOUSE:C468($mouseX;$mouseY;$mouseButton)
$0:=_PointInRect ($mouseX;$mouseY;$left;$top;$right;$bottom)