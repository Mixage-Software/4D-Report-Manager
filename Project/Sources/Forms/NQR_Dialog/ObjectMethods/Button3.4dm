C_LONGINT:C283($column;$rowcounter;$columncounter;$column_t;$row;$row_t;$trait;$style;$align)
C_LONGINT:C283($colora;$colorf;$colorp;$color)
For ($rowcounter;1;nqr_nb_rows;1)
	For ($columncounter;1;QR Count columns:C764(nqr_area);1)
		$column_t:=$columncounter
		If ($column_t>4)
			$column_t:=4
		End if 
		$column:=$columncounter
		Case of 
			: ($rowcounter=1)
				$row:=-1
				$row_t:=1
			: ($rowcounter=2)
				$row:=-2
				$row_t:=2
			: ($rowcounter=nqr_nb_rows)
				$row:=-3
				$row_t:=5
			Else 
				$row:=$rowcounter-2
				$row_t:=2+$row
				If ($row_t>4)
					$row_t:=4
				End if 
		End case 
		
		$trait:=1+2+4+8+16+32
		QR SET BORDERS:C797(nqr_area;$column;$row;$trait;0;0)
		
		If (nqr_bc_font=1)
			$font_name:=_nqr_cell_font{$row_t}{$column_t}
			QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;qr font name:K14904:10;$font_name)  //police
			QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;2;_nqr_cell_font_size{$row_t}{$column_t})  //taille
		End if 
		If (nqr_bc_style=1)
			$style:=_nqr_cell_font_style{$row_t}{$column_t}
			QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;3;0)  //bold
			QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;4;0)  //italic
			QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;5;0)  //underline
			If ($style ?? 0)  //bold
				QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;3;1)
			End if 
			If ($style ?? 1)  //italic
				QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;4;1)
			End if 
			If ($style ?? 2)  //underline
				QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;5;1)
			End if 
		End if 
		
		If (nqr_bc_alignment=1)
			$align:=Abs:C99(_nqr_cell_text_align{$row_t}{$column_t}-1)
			
			QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;7;$align)  //alignement
			
		End if 
		
		If (nqr_bc_color=1)
			$colorp:=_nqr_cell_color_text{$row_t}{$column_t}
			QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;6;$colorp)  //color of font
			
			$colorf:=_nqr_cell_color_back{$row_t}{$column_t}
			QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;8;$colorf)  //color of font
			If (_nqr_cell_color_alternate{$row_t}{$column_t}#-1) & ($row_t=2)
				$colora:=_nqr_cell_color_alternate{$row_t}{$column_t}
				QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;9;$colora)  //color of font alt
			Else 
				QR SET TEXT PROPERTY:C759(nqr_area;$column;$row;9;-1)  //color of font alt
			End if 
		End if 
		
		If (nqr_bc_border=1)
			If (True:C214)  //nqr_bc_color=1)
				$color:=_nqr_cell_color_border{$row_t}
			Else 
				$color:=0x00FFFFFF
			End if 
			QR SET BORDERS:C797(nqr_area;$column;$row;1;_nqr_cell_thicknessg{$row_t};$color)
			QR SET BORDERS:C797(nqr_area;$column;$row;2;_nqr_cell_thicknessh{$row_t};$color)
			QR SET BORDERS:C797(nqr_area;$column;$row;4;_nqr_cell_thicknessd{$row_t};$color)
			QR SET BORDERS:C797(nqr_area;$column;$row;8;_nqr_cell_thicknessb{$row_t};$color)
			QR SET BORDERS:C797(nqr_area;$column;$row;32;_nqr_cell_thicknessih{$row_t};$color)
		Else 
			$trait:=1+2+4+8+16+32
			QR SET BORDERS:C797(nqr_area;$column;$row;$trait;0;0)
		End if 
	End for 
End for 