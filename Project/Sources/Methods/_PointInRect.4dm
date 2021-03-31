//%attributes = {"invisible":true}
  // $1 point x coords
  // $2 point y coords
  // $3 left rect coordinate
  // $4 top rect coordinate
  // $5 right rect coordinate
  // $6 bottom rect coordinate
  // $0 boolean - Was the last mouse click inside object?

C_LONGINT:C283($rect_left;$rect_top;$rect_right;$rect_bottom)

$point_X:=$1
$point_Y:=$2

$rect_left:=$3
$rect_top:=$4
$rect_right:=$5
$rect_bottom:=$6

$0:=False:C215
If ($point_X>=$rect_left)
	If ($point_X<=$rect_right)
		If ($point_Y>=$rect_top)
			If ($point_Y<=$rect_bottom)
				$0:=True:C214
			End if 
		End if 
	End if 
End if 