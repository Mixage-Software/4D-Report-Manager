//%attributes = {"invisible":true}
  // $1 $newDestination
  // $2 $sender_ptr
  // $3 $filename (optional)

C_LONGINT:C283($newDestination)
C_POINTER:C301($sender_ptr)
C_TEXT:C284($filename)

$newDestination:=$1
$sender_ptr:=$2
If (Count parameters:C259>2)
	$filename:=$3
End if 

C_LONGINT:C283($i)
C_LONGINT:C283($destination_type)
QR GET DESTINATION:C756(nqr_area;$destination_type)
If ($destination_type#$newDestination)
	
	nqr_step_maximum:=nqr_step_current
	For ($i;nqr_step_maximum+1;10;1)
		OBJECT SET VISIBLE:C603(*;"bttn"+String:C10($i);False:C215)
		Get pointer:C304("nqr_step_"+String:C10($i))->:=""
	End for 
	
	OBJECT SET ENABLED:C1123(nqr_b_Step_Next;True:C214)
	nqr_step_following_ok:=True:C214
	OBJECT SET RGB COLORS:C628(*;"step_"+String:C10($i);0x0000)  // Black
End if 


If (Count parameters:C259>2)
	QR SET DESTINATION:C745(nqr_area;$newDestination;$filename)
Else 
	QR SET DESTINATION:C745(nqr_area;$newDestination)
End if 

nqr_sc_1:=0
nqr_sc_2:=0
nqr_sc_3:=0
nqr_sc_4:=0
nqr_sc_5:=0

OBJECT SET FORMAT:C236(nqr_sc_1;"1;4;#Images/14945.png;208")
OBJECT SET FORMAT:C236(nqr_sc_4;"1;4;#Images/14949.png;208")
OBJECT SET FORMAT:C236(nqr_sc_3;"1;4;#Images/14947.png;208")
OBJECT SET FORMAT:C236(nqr_sc_2;"1;4;#Images/14946.png;208")
OBJECT SET FORMAT:C236(nqr_sc_5;"1;4;#Images/14948.png;208")

($sender_ptr->):=1
$format:=OBJECT Get format:C894($sender_ptr->)
$format:=Replace string:C233($format;";208";";64")
OBJECT SET FORMAT:C236($sender_ptr->;$format)

NQR_Update_Destination 