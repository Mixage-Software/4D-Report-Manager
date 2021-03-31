//%attributes = {"invisible":true}
ARRAY REAL:C219($ar_Points;4)
$ar_Points{0}:=0
$ar_Points{1}:=0.25
$ar_Points{2}:=0.5
$ar_Points{3}:=1
$ar_Points{4}:=2

$margin:=10

OBJECT GET COORDINATES:C663(gBordersPreview;$left;$top;$right;$bottom)
$vp_Width:=$right-$left
$vp_Height:=$bottom-$top

$numRows:=3
$numCols:=3
$cellWidth:=Int:C8(($vp_Width-($margin*2))/5)
$cellHeight:=Int:C8(($vp_Height-($margin*2))/5)

$svg_ref:=SVG_New ($winWidth_r;$winHeight_r)

$startX:=$margin
$startY:=$margin

$startX:=$margin
$startY:=$margin

For ($row;1;$numRows)
	$sectionHeight:=$cellHeight
	If ($row=2)
		$sectionHeight:=3*$cellHeight
	End if 
	
	For ($col;1;$numCols)
		$sectionWidth:=$cellWidth
		If ($col=2)
			$sectionWidth:=3*$cellWidth
		End if 
		
		Case of 
			: ($row=1) & ($col=1)
				  //skip
			Else 
				
				C_LONGINT:C283($color)
				C_LONGINT:C283($line)
				
				QR GET BORDERS:C798(nqr_area;$col;$row;qr left border:K14908:1;$line;$color)  // Left border
				$svg_color:=SVG_Color_RGB_from_long ($color)
				$result:=SVG_New_line ($svg_ref;$startX;$startY;$startX;$startY+$sectionHeight;$svg_color;$ar_Points{$line})
				
				QR GET BORDERS:C798(nqr_area;$col;$row;qr top border:K14908:2;$line;$color)  // Top border
				$svg_color:=SVG_Color_RGB_from_long ($color)
				$result:=SVG_New_line ($svg_ref;$startX;$startY;$startX+$sectionWidth;$startY;$svg_color;$ar_Points{$line})
				
				Case of 
					: (($row=1) | ($row=3)) & ($col=2)
						$insideX:=$startX
						For ($j;1;2)
							QR GET BORDERS:C798(nqr_area;$col;$row;qr inside vertical border:K14908:5;$line;$color)  // Inside vertical border
							$svg_color:=SVG_Color_RGB_from_long ($color)
							$result:=SVG_New_line ($svg_ref;$insideX+$cellWidth;$startY;$insideX+$cellWidth;$startY+$sectionHeight;$svg_color;$ar_Points{$line})
							$insideX:=$insideX+$cellWidth
						End for 
						
						
					: ($row=2) & (($col=1) | ($col=3))
						$insideY:=$startY
						For ($j;1;2)
							QR GET BORDERS:C798(nqr_area;$col;$row;qr inside horizontal border:K14908:6;$line;$color)  // Inside vertical border
							$svg_color:=SVG_Color_RGB_from_long ($color)
							$result:=SVG_New_line ($svg_ref;$startX;$insideY+$cellHeight;$startX+$sectionWidth;$insideY+$cellHeight;$svg_color;$ar_Points{$line})
							$insideY:=$insideY+$cellHeight
						End for 
						
						
					: ($row=2) & ($col=2)
						$insideY:=$startY
						For ($j;1;2)
							QR GET BORDERS:C798(nqr_area;$col;$row;qr inside horizontal border:K14908:6;$line;$color)  // Inside vertical border
							$svg_color:=SVG_Color_RGB_from_long ($color)
							$result:=SVG_New_line ($svg_ref;$startX;$insideY+$cellHeight;$startX+$sectionWidth;$insideY+$cellHeight;$svg_color;$ar_Points{$line})
							$insideY:=$insideY+$cellHeight
						End for 
						$insideX:=$startX
						For ($j;1;2)
							QR GET BORDERS:C798(nqr_area;$col;$row;qr inside vertical border:K14908:5;$line;$color)  // Inside vertical border
							$svg_color:=SVG_Color_RGB_from_long ($color)
							$result:=SVG_New_line ($svg_ref;$insideX+$cellWidth;$startY;$insideX+$cellWidth;$startY+$sectionHeight;$svg_color;$ar_Points{$line})
							$insideX:=$insideX+$cellWidth
						End for 
						
						
						
						
				End case 
				
				QR GET BORDERS:C798(nqr_area;$col;$row;qr right border:K14908:3;$line;$color)  // Right border
				$svg_color:=SVG_Color_RGB_from_long ($color)
				$result:=SVG_New_line ($svg_ref;$startX+$sectionWidth;$startY;$startX+$sectionWidth;$startY+$sectionHeight;$svg_color;$ar_Points{$line})
				
				
				QR GET BORDERS:C798(nqr_area;$col;$row;qr bottom border:K14908:4;$line;$color)  // Bottom border
				$svg_color:=SVG_Color_RGB_from_long ($color)
				$result:=SVG_New_line ($svg_ref;$startX;$startY+$sectionHeight;$startX+$sectionWidth;$startY+$sectionHeight;$svg_color;$ar_Points{$line})
		End case 
		
		$startX:=$startX+$sectionWidth
	End for 
	$startX:=$margin
	$startY:=$startY+$sectionHeight
End for 

gBordersPreview:=SVG_Export_to_picture ($svg_ref)
SVG_CLEAR ($svg_ref)
