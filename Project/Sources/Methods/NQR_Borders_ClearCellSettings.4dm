//%attributes = {"invisible":true}
  // no parameters

C_LONGINT:C283($firstCol;$firstRow;$lastCol;$lastRow)
QR GET SELECTION:C793(nqr_area;$firstCol;$firstRow;$lastCol;$lastRow)

Case of 
	: ($firstCol=-1)  // no selection
		BEEP:C151
		
	Else 
		
		If ($firstCol=0)
			$firstCol:=1
		End if 
		If ($firstRow=0)
			$firstRow:=1
		End if 
		
		For ($row;$firstRow;$lastRow)
			For ($col;$firstCol;$lastCol)
				$sectionNum:=_QR_RowNumToSectionNum (nqr_area;$row)
				$trait:=1+2+4+8+16+32
				QR SET BORDERS:C797(nqr_area;$col;$sectionNum;$trait;0;0)
			End for 
		End for 
		
End case 