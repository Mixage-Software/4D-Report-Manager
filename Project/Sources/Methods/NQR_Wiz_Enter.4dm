//%attributes = {"invisible":true}
C_LONGINT:C283($view;$g;$h;$d;$b)
  // entering the Quick Report Editor; one adapts it to the size of the plugin zone
OBJECT GET COORDINATES:C663(nqr_area;$g;$h;$d;$b)
OBJECT MOVE:C664(nqr_area;$g;$h;$d;$b-110;*)


OBJECT SET VISIBLE:C603(*;"toolbar@";False:C215)
OBJECT GET COORDINATES:C663(*;"nqr_area";$left;$top;$right;$bottom)
OBJECT SET COORDINATES:C1248(*;"nqr_area";$left;$top-30;$right;$bottom)
DISABLE MENU ITEM:C150(1;0)

  //initialize the variables
nqr_step_maximum:=0
nqr_step_current:=0
nqr_step_1:=""
nqr_step_2:=""
nqr_step_3:=""
nqr_step_4:=""
nqr_step_5:=""
nqr_step_6:=""
nqr_step_7:=""
nqr_step_8:=""
nqr_step_9:=""
nqr_step_10:=""
nqr_op_sum:=0
nqr_op_average:=0
nqr_op_mini:=0
nqr_op_maxi:=0
nqr_op_count:=0
nqr_op_stddeviation:=0

  //initialize the properties of the zone
For ($view;1;7)
	QR SET AREA PROPERTY:C796(nqr_area;$view;0)
End for 
  //set the selection
QR SET SELECTION:C794(nqr_area;-1;-1;-1;-1)

NQR_Wiz_Step_Next 