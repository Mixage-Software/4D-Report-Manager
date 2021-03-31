//%attributes = {"invisible":true}
  // $0 unique report name

$name:=Get indexed string:C510(14908;177)
$suffix:=1
Repeat 
	$uniqueName:=$name+String:C10($suffix)
	$suffix:=$suffix+1
Until (Find in field:C653(gQR_ReportNamePtr->;$uniqueName)=-1)
$0:=$uniqueName