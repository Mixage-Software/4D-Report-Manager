//%attributes = {"invisible":true}
C_LONGINT:C283($col;$row)
QR GET SELECTION:C793(nqr_area;$col;$row)
Case of 
	: ($col=-1)  // no selection
		BEEP:C151
		
	Else 
		
		$sectionNum:=_QR_RowNumToSectionNum (nqr_area;$row)
		For ($i;1;4)
			$borderNum:=(1 << ($i-1))
			QR GET BORDERS:C798(nqr_area;$col;$sectionNum;$borderNum;$width;$color)
			OBJECT SET VISIBLE:C603(*;"Border"+String:C10($i);$width>0)
			OBJECT SET RGB COLORS:C628(*;"Border"+String:C10($i);$color;$color)
		End for 
		
End case 