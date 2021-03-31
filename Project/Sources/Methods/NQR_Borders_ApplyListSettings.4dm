//%attributes = {"invisible":true}
C_BOOLEAN:C305(vb_ApplyAll)
C_LONGINT:C283($firstCol;$firstRow;$lastCol;$lastRow)
QR GET SELECTION:C793(nqr_area;$firstCol;$firstRow;$lastCol;$lastRow)

Case of 
	: ($firstCol=-1)  // no selection
		BEEP:C151
		
	Else 
		
		$shouldSetLeftBorder:=OBJECT Get visible:C1075(*;"Border1")
		$shouldSetTopBorder:=OBJECT Get visible:C1075(*;"Border2")
		$shouldSetRightBorder:=OBJECT Get visible:C1075(*;"Border3")
		$shouldSetBottomBorder:=OBJECT Get visible:C1075(*;"Border4")
		$shouldSetVerticalBorder:=OBJECT Get visible:C1075(*;"Border5")
		$shouldSetHorizontalBorder:=OBJECT Get visible:C1075(*;"Border6")
		
		$colSelection:=False:C215
		$rowSelection:=False:C215
		
		If ($firstCol=0)
			$colSelection:=True:C214
			$firstCol:=1
		End if 
		$rowSelection:=False:C215
		If ($firstRow=0)
			$rowSelection:=True:C214
			$firstRow:=1
		End if 
		
		For ($row;$firstRow;$lastRow)
			For ($col;$firstCol;$lastCol)
				
				C_LONGINT:C283($newColor;$newWidth)
				
				$sectionNum:=_QR_RowNumToSectionNum (nqr_area;$row)
				
				If (vb_ApplyAll)  // delete all
					$trait:=1+2+4+8+16+32
					QR SET BORDERS:C797(nqr_area;$col;$sectionNum;$trait;0;0)
				End if 
				
				$newWidth:=ar_LineWidth-1
				
				If ($shouldSetTopBorder)
					If ($row=$firstRow)
						OBJECT GET RGB COLORS:C1074(*;"Border2";$temp;$newColor)
						QR SET BORDERS:C797(nqr_area;$col;$sectionNum;qr top border:K14908:2;$newWidth;$newColor)  // Top border
					End if 
				End if 
				
				If ($shouldSetBottomBorder)
					If ($row=$lastRow)
						OBJECT GET RGB COLORS:C1074(*;"Border4";$temp;$newColor)
						QR SET BORDERS:C797(nqr_area;$col;$sectionNum;qr bottom border:K14908:4;$newWidth;$newColor)  // Bottom border
					End if 
				End if 
				
				If ($shouldSetLeftBorder)
					If ($col=$firstCol)
						OBJECT GET RGB COLORS:C1074(*;"Border1";$temp;$newColor)
						QR SET BORDERS:C797(nqr_area;$col;$sectionNum;qr left border:K14908:1;$newWidth;$newColor)  // Left border
					End if 
				End if 
				
				If ($shouldSetRightBorder)
					If ($col=$lastCol)
						$setRightBorder:=$shouldSetRightBorder
						OBJECT GET RGB COLORS:C1074(*;"Border3";$temp;$newColor)
						QR SET BORDERS:C797(nqr_area;$col;$sectionNum;qr right border:K14908:3;$newWidth;$newColor)  // Right border
					End if 
				End if 
				
				If ($shouldSetVerticalBorder)
					OBJECT GET RGB COLORS:C1074(*;"Border5";$temp;$newColor)
					QR SET BORDERS:C797(nqr_area;$col;$sectionNum;qr inside vertical border:K14908:5;$newWidth;$newColor)
					If ($col>1) & ($firstCol#$lastCol)
						QR SET BORDERS:C797(nqr_area;$col;$sectionNum;qr left border:K14908:1;$newWidth;$newColor)
					End if 
				End if 
				
				If ($shouldSetHorizontalBorder)
					OBJECT GET RGB COLORS:C1074(*;"Border6";$temp;$newColor)
					QR SET BORDERS:C797(nqr_area;$col;$sectionNum;qr inside horizontal border:K14908:6;$newWidth;$newColor)
					If ($row>1) & ($firstRow#$lastRow)
						QR SET BORDERS:C797(nqr_area;$col;$sectionNum;qr top border:K14908:2;$newWidth;$newColor)
					End if 
				End if 
				
			End for 
		End for 
		
		If ($shouldSetBottomBorder & ($lastRow<_QR_CountRows (nqr_area)))
			  // This may not be a good idea ... break extra space? page break?
			$sectionNum:=_QR_RowNumToSectionNum (nqr_area;$lastRow+1)
			OBJECT GET RGB COLORS:C1074(*;"Border4";$temp;$newColor)
			For ($col;$firstCol;$lastCol)
				QR SET BORDERS:C797(nqr_area;$col;$sectionNum;qr top border:K14908:2;$newWidth;$newColor)  // Top border
			End for 
		End if 
		If ($shouldSetRightBorder & ($lastCol<QR Count columns:C764(nqr_area)))
			OBJECT GET RGB COLORS:C1074(*;"Border3";$temp;$newColor)
			For ($row;$firstRow;$lastRow)
				$sectionNum:=_QR_RowNumToSectionNum (nqr_area;$row)
				QR SET BORDERS:C797(nqr_area;$lastCol+1;$sectionNum;qr left border:K14908:1;$newWidth;$newColor)  // Left border
			End for 
		End if 
		
		
End case 