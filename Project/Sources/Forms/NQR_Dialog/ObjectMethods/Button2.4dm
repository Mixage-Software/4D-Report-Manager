C_LONGINT:C283($i)
C_LONGINT:C283($column;$row;$trait;$style;$align;$colora;$colorf;$colorp;$color)


For ($i;1;8;1)
	
	Case of 
		: ($i=1)
			$column:=2
			$row:=1
		: ($i=2)
			$column:=1
			$row:=2
		: ($i=3)
			$column:=2
			$row:=2
		: ($i=4)
			$column:=3
			$row:=1
		: ($i=5)
			$column:=1
			$row:=3
		: ($i=6)
			$column:=3
			$row:=2
		: ($i=7)
			$column:=2
			$row:=3
		: ($i=8)
			$column:=3
			$row:=3
	End case 
	$trait:=1+2+4+8+16+32
	QR SET BORDERS:C797(nqr_area;$column;$row;$trait;0;0)
	
	If (nqr_bc_font=1)
		$font_name:=_nqr_celltc_font{$row}
		QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;qr font name:K14904:10;$font_name)  //police
		QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;2;_nqr_celltc_font_size{$i})  //taille
	End if 
	
	If (nqr_bc_style=1)
		$style:=_nqr_celltc_style{$i}
		QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;qr bold:K14904:3;0)  //bold
		QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;qr italic:K14904:4;0)  //italic
		QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;qr underline:K14904:5;0)  //underline
		If ($style ?? 0)  //bold
			QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;qr bold:K14904:3;1)
		End if 
		If ($style ?? 1)  //italic
			QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;qr italic:K14904:4;1)
		End if 
		If ($style ?? 2)  //underline
			QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;qr underline:K14904:5;1)
		End if 
	End if 
	
	If (nqr_bc_alignment=1)
		$align:=Abs:C99(_nqr_celltc_align{$i}-1)
		QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;qr justification:K14904:7;$align)  //alignement
		
	End if 
	
	If (nqr_bc_color=1)
		$colorp:=_nqr_celltc_color_text{$i}
		QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;qr text color:K14904:6;$colorp)  //color of font
		
		$colorf:=_nqr_celltc_color_back{$i}
		QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;qr background color:K14904:8;$colorf)  //color of font
		If (_nqr_celltc_color_alternate{$i}#-1)
			$colora:=_nqr_celltc_color_alternate{$i}
			QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;qr alternate background color:K14904:9;$colora)  //color of font alt
		Else 
			QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;qr alternate background color:K14904:9;-1)  //color pf font alt
		End if 
	End if 
	
	If (nqr_bc_border=1)
		If (True:C214)  //nqr_bc_color=1)
			$color:=_nqr_celltc_colort{$i}
		Else 
			$color:=0x00FFFFFF
		End if 
		QR SET BORDERS:C797(nqr_area;$column;$row;1;_nqr_celltc_thicknessg{$i};$color)
		QR SET BORDERS:C797(nqr_area;$column;$row;2;_nqr_celltc_thicknessh{$i};$color)
		QR SET BORDERS:C797(nqr_area;$column;$row;4;_nqr_celltc_thicknessd{$i};$color)
		QR SET BORDERS:C797(nqr_area;$column;$row;8;_nqr_celltc_thicknessb{$i};$color)
		QR SET BORDERS:C797(nqr_area;$column;$row;16;_nqr_celltc_thicknessiv{$i};$color)
		QR SET BORDERS:C797(nqr_area;$column;$row;32;_nqr_celltc_thicknessih{$i};$color)
	Else 
		$trait:=1+2+4+8+16+32
		QR SET BORDERS:C797(nqr_area;$column;$row;$trait;0;0)
	End if 
	
End for 