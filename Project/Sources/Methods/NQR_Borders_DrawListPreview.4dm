//%attributes = {"invisible":true}
ARRAY REAL:C219($ar_Points;4)
$ar_Points{0}:=0
$ar_Points{1}:=0.25
$ar_Points{2}:=0.5
$ar_Points{3}:=1
$ar_Points{4}:=2

$numRows:=_QR_CountRows (nqr_area)
$numCols:=QR Count columns:C764(nqr_area)

$margin:=10

If (True:C214)
	OBJECT GET COORDINATES:C663(gBordersPreview;$left;$top;$right;$bottom)
	$vp_Width:=$right-$left
	$vp_Height:=$bottom-$top
	
	$cellWidth:=($vp_Width-($margin*2))/$numCols
	$cellHeight:=($vp_Height-($margin*2))/$numRows
	
	
Else 
	$cellWidth:=100
	$cellHeight:=20
	
	$winWidth_r:=$cellWidth*$numCols+($margin*2)
	$winHeight_r:=$cellHeight*$numRows+($margin*2)
End if 


$svg_ref:=SVG_New ($winWidth_r;$winHeight_r)

$startX:=$margin
$startY:=$margin

$reportKind:=QR Get report kind:C755(nqr_area)

For ($row;1;$numRows)
	For ($col;1;$numCols)
		
		Case of 
			: ($reportKind=qr cross report:K14902:2) & ($row=1) & ($col=1)
				
			Else 
				
				$startX:=$margin+($col-1*$cellWidth)
				$startY:=$margin+($row-1*$cellHeight)
				
				C_LONGINT:C283($color)
				C_LONGINT:C283($line)
				
				$sectionNum:=_QR_RowNumToSectionNum (nqr_area;$row)
				QR GET BORDERS:C798(nqr_area;$col;$sectionNum;qr top border:K14908:2;$line;$color)  // Top border
				$svg_color:=SVG_Color_RGB_from_long ($color)
				$result:=SVG_New_line ($svg_ref;$startX;$startY;$startX+$cellWidth;$startY;$svg_color;$ar_Points{$line})
				
				QR GET BORDERS:C798(nqr_area;$col;$sectionNum;qr right border:K14908:3;$line;$color)  // Right border
				$svg_color:=SVG_Color_RGB_from_long ($color)
				$result:=SVG_New_line ($svg_ref;$startX+$cellWidth;$startY;$startX+$cellWidth;$startY+$cellHeight;$svg_color;$ar_Points{$line})
				
				QR GET BORDERS:C798(nqr_area;$col;$sectionNum;qr left border:K14908:1;$line;$color)  // Left border
				$svg_color:=SVG_Color_RGB_from_long ($color)
				$result:=SVG_New_line ($svg_ref;$startX;$startY;$startX;$startY+$cellHeight;$svg_color;$ar_Points{$line})
				
				QR GET BORDERS:C798(nqr_area;$col;$sectionNum;qr bottom border:K14908:4;$line;$color)  // Bottom border
				$svg_color:=SVG_Color_RGB_from_long ($color)
				$result:=SVG_New_line ($svg_ref;$startX;$startY+$cellHeight;$startX+$cellWidth;$startY+$cellHeight;$svg_color;$ar_Points{$line})
				
		End case 
		
	End for 
End for 

gBordersPreview:=SVG_Export_to_picture ($svg_ref)
SVG_CLEAR ($svg_ref)
