//%attributes = {"invisible":true}
C_LONGINT:C283($i;$column;$rowcounter;$obj)
C_LONGINT:C283($width;$height;$width_zone;$hight_zone;$offset_h;$offset_v;$offset_h_c;$offset_v_c)
C_LONGINT:C283($font_size;$style;$align;$colora;$colorf;$color_text;$bestwidth;$bestheight;$trait)
C_LONGINT:C283($loc_h;$loc_v;$bf;$df;$gf;$row;$colorav;$colorar;$hf)
C_TEXT:C284($font;$name_objet)

Case of 
	: (_nqr_format=0)
	: (_nqr_format>Size of array:C274(_nqr_format))
	Else 
		ARRAY TEXT:C222($_font;0)
		FONT LIST:C460($_font)
		ARRAY TEXT:C222($_name_objet;4)
		$_name_objet{1}:="nqr_header_@"
		$_name_objet{2}:="nqr_body_@"
		$_name_objet{3}:="nqr_break_@"
		$_name_objet{4}:="nqr_total_@"
		For ($i;1;4;1)
			OBJECT SET FONT:C164(*;$_name_objet{$i};$_font{1})
			OBJECT SET FONT SIZE:C165(*;$_name_objet{$i};12)
			OBJECT SET FONT STYLE:C166(*;$_name_objet{$i};0)
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*;$_name_objet{$i};1)
			OBJECT SET RGB COLORS:C628(*;$_name_objet{$i};0x0000;Background color none:K23:10)  // Black
		End for 
		OBJECT SET RGB COLORS:C628(*;"nqr_bkg@";0x00FFFFFF;0x00FFFFFF)  // White
		
		For ($column;1;4;1)
			For ($i;1;5;1)
				
				$font:=_nqr_cell_font{$i}{$column}
				$font_size:=_nqr_cell_font_size{$i}{$column}
				$style:=_nqr_cell_font_style{$i}{$column}
				$align:=_nqr_cell_text_align{$i}{$column}
				$color_text:=_nqr_cell_color_text{$i}{$column}
				$colorf:=_nqr_cell_color_back{$i}{$column}
				$colora:=_nqr_cell_color_alternate{$i}{$column}
				ARRAY TEXT:C222($_name_objet;1)
				Case of 
					: ($i=1)
						$_name_objet{1}:="nqr_header_"+String:C10($column)
					: ($i=2)
						ARRAY TEXT:C222($_name_objet;5)
						$_name_objet{1}:="nqr_body_1"+String:C10($column)
						$_name_objet{2}:="nqr_body_2"+String:C10($column)
						$_name_objet{3}:="nqr_body_3"+String:C10($column)
						$_name_objet{4}:="nqr_body_4"+String:C10($column)
						$_name_objet{5}:="nqr_body_5"+String:C10($column)
					: ($i=3)
						ARRAY TEXT:C222($_name_objet;2)
						$_name_objet{1}:="nqr_break_21"+String:C10($column)
						$_name_objet{2}:="nqr_break_22"+String:C10($column)
						
					: ($i=4)
						$_name_objet{1}:="nqr_break_11"+String:C10($column)
					: ($i=5)
						$_name_objet{1}:="nqr_total_"+String:C10($column)
				End case 
				
				
				For ($obj;1;Size of array:C274($_name_objet);1)
					$name_objet:=$_name_objet{$obj}
					If (nqr_bc_font=1)
						OBJECT SET FONT:C164(*;$name_objet;$font)
						OBJECT SET FONT SIZE:C165(*;$name_objet;$font_size)
					End if 
					If (nqr_bc_style=1)
						OBJECT SET FONT STYLE:C166(*;$name_objet;$style)
					End if 
					If (nqr_bc_alignment=1)
						OBJECT SET HORIZONTAL ALIGNMENT:C706(*;$name_objet;$align)
					End if 
					If (nqr_bc_color=1)
						OBJECT SET RGB COLORS:C628(*;$name_objet;$color_text;Background color none:K23:10)
						If ($i=2)
							OBJECT SET RGB COLORS:C628(*;"nqr_body_2"+String:C10($column);$color_text;Background color none:K23:10)
							OBJECT SET RGB COLORS:C628(*;"nqr_body_5"+String:C10($column);$color_text;Background color none:K23:10)
						End if 
					End if 
				End for 
			End for 
		End for 
		
		If (nqr_bc_color=1)
			For ($column;1;4;1)
				For ($rowcounter;1;10;1)
					Case of 
						: ($rowcounter=1)
							$colorf:=_nqr_cell_color_back{1}{$column}
						: ($rowcounter=2)
							$colorf:=_nqr_cell_color_back{2}{$column}
						: ($rowcounter=3)
							$colorf:=_nqr_cell_color_alternate{2}{$column}
						: ($rowcounter=4)
							$colorf:=_nqr_cell_color_back{2}{$column}
						: ($rowcounter=5)
							$colorf:=_nqr_cell_color_back{3}{$column}
						: ($rowcounter=6)
							$colorf:=_nqr_cell_color_back{2}{$column}
						: ($rowcounter=7)
							$colorf:=_nqr_cell_color_alternate{2}{$column}
						: ($rowcounter=8)
							$colorf:=_nqr_cell_color_back{3}{$column}
						: ($rowcounter=9)
							$colorf:=_nqr_cell_color_back{4}{$column}
						: ($rowcounter=10)
							$colorf:=_nqr_cell_color_back{5}{$column}
					End case 
					OBJECT SET RGB COLORS:C628(*;"nqr_bkg"+String:C10($rowcounter+(($column-1)*10));$colorf;$colorf)
				End for 
			End for 
		End if 
		
		ARRAY INTEGER:C220($_width;4)
		ARRAY INTEGER:C220($_heigth;10)
		ARRAY INTEGER:C220($_wide;4;10)
		ARRAY INTEGER:C220($_high;4;10)
		
		For ($column;1;4)
			For ($rowcounter;1;10)
				Case of 
					: ($rowcounter=1)
						$name_objet:="nqr_header_"+String:C10($column)
					: ($rowcounter=2)
						$name_objet:="nqr_body_1"+String:C10($column)
					: ($rowcounter=3)
						$name_objet:="nqr_body_2"+String:C10($column)
					: ($rowcounter=4)
						$name_objet:="nqr_body_3"+String:C10($column)
					: ($rowcounter=5)
						$name_objet:="nqr_break_21"+String:C10($column)
					: ($rowcounter=6)
						$name_objet:="nqr_body_4"+String:C10($column)
					: ($rowcounter=7)
						$name_objet:="nqr_body_5"+String:C10($column)
					: ($rowcounter=8)
						$name_objet:="nqr_break_22"+String:C10($column)
					: ($rowcounter=9)
						$name_objet:="nqr_break_11"+String:C10($column)
					: ($rowcounter=10)
						$name_objet:="nqr_total_"+String:C10($column)
				End case 
				If (Get pointer:C304($name_objet)->#"")
					OBJECT GET BEST SIZE:C717(*;$name_objet;$bestwidth;$bestheight)
				Else 
					$bestwidth:=1
					$bestheight:=1
				End if 
				$bestwidth:=$bestwidth+3
				$bestheight:=$bestheight+1
				$_wide{$column}{$rowcounter}:=$bestwidth
				$_high{$column}{$rowcounter}:=$bestheight
				If ($bestwidth>$_width{$column})
					$_width{$column}:=$bestwidth
				End if 
				If ($bestheight>$_heigth{$rowcounter})
					$_heigth{$rowcounter}:=$bestheight
				End if 
				
			End for 
		End for 
		
		ARRAY INTEGER:C220($_nqr_cell_thicknessg;8)
		ARRAY INTEGER:C220($_nqr_cell_thicknessh;8)
		ARRAY INTEGER:C220($_nqr_cell_thicknessd;8)
		ARRAY INTEGER:C220($_nqr_cell_thicknessb;8)
		ARRAY INTEGER:C220($_nqr_cell_thicknessih;8)
		For ($i;1;5;1)
			Case of 
				: (nqr_bc_border=0)
					$_nqr_cell_thicknessg{$i}:=0
				: (_nqr_cell_thicknessg{$i}=0)
					$_nqr_cell_thicknessg{$i}:=0
				: (_nqr_cell_thicknessg{$i}=4)
					$_nqr_cell_thicknessg{$i}:=2
				Else 
					$_nqr_cell_thicknessg{$i}:=1
			End case 
			Case of 
				: (nqr_bc_border=0)
					$_nqr_cell_thicknessh{$i}:=0
				: (_nqr_cell_thicknessh{$i}=0)
					$_nqr_cell_thicknessh{$i}:=0
				: (_nqr_cell_thicknessh{$i}=4)
					$_nqr_cell_thicknessh{$i}:=2
				Else 
					$_nqr_cell_thicknessh{$i}:=1
			End case 
			Case of 
				: (nqr_bc_border=0)
					$_nqr_cell_thicknessd{$i}:=0
				: (_nqr_cell_thicknessd{$i}=0)
					$_nqr_cell_thicknessd{$i}:=0
				: (_nqr_cell_thicknessd{$i}=4)
					$_nqr_cell_thicknessd{$i}:=2
				Else 
					$_nqr_cell_thicknessd{$i}:=1
			End case 
			Case of 
				: (nqr_bc_border=0)
					$_nqr_cell_thicknessb{$i}:=0
				: (_nqr_cell_thicknessb{$i}=0)
					$_nqr_cell_thicknessb{$i}:=0
				: (_nqr_cell_thicknessb{$i}=4)
					$_nqr_cell_thicknessb{$i}:=2
				Else 
					$_nqr_cell_thicknessb{$i}:=1
			End case 
			Case of 
				: (nqr_bc_border=0)
					$_nqr_cell_thicknessih{$i}:=0
				: (_nqr_cell_thicknessih{$i}=0)
					$_nqr_cell_thicknessih{$i}:=0
				: (_nqr_cell_thicknessih{$i}=4)
					$_nqr_cell_thicknessih{$i}:=2
				Else 
					$_nqr_cell_thicknessih{$i}:=1
			End case 
		End for 
		
		$width:=0
		For ($column;1;4)
			$width:=$width+$_width{$column}+6
		End for 
		
		$height:=0
		For ($rowcounter;1;10)
			$height:=$height+$_heigth{$rowcounter}+6
		End for 
		
		
		OBJECT GET COORDINATES:C663(*;"zone_base1";$g;$h;$d;$b)
		$width_zone:=$d-$g
		$hight_zone:=$b-$h
		$offset_h:=Int:C8(($width_zone-$width)/2)
		If ($offset_h<0)
			$offset_h:=10
		End if 
		$offset_v:=Int:C8(($hight_zone-$height)/2)
		If ($offset_v<0)
			$offset_v:=10
		End if 
		
		$trait:=0
		$offset_h_c:=$offset_h+$g
		For ($column;1;4)
			$offset_v_c:=$offset_v+$h
			
			$loc_h:=3
			$gf:=$offset_h_c+$loc_h-3
			$df:=$gf+$_width{$column}+6
			
			For ($rowcounter;1;10)
				$loc_v:=3
				$hf:=$offset_v_c+$loc_v-3
				$bf:=$offset_v_c+$loc_v+$_heigth{$rowcounter}+3
				Case of 
					: ($rowcounter=1)
						$name_objet:="nqr_header_"+String:C10($column)
						$row:=1
					: ($rowcounter=2)
						$name_objet:="nqr_body_1"+String:C10($column)
						$row:=2
					: ($rowcounter=3)
						$name_objet:="nqr_body_2"+String:C10($column)
						$row:=2
					: ($rowcounter=4)
						$name_objet:="nqr_body_3"+String:C10($column)
						$row:=2
					: ($rowcounter=5)
						$name_objet:="nqr_break_21"+String:C10($column)
						$row:=3
					: ($rowcounter=6)
						$name_objet:="nqr_body_4"+String:C10($column)
						$row:=2
					: ($rowcounter=7)
						$name_objet:="nqr_body_5"+String:C10($column)
						$row:=2
					: ($rowcounter=8)
						$name_objet:="nqr_break_22"+String:C10($column)
						$row:=3
					: ($rowcounter=9)
						$name_objet:="nqr_break_11"+String:C10($column)
						$row:=4
					: ($rowcounter=10)
						$name_objet:="nqr_total_"+String:C10($column)
						$row:=5
						
						
				End case 
				If (True:C214)  //nqr_bc_color=1)
					$colorav:=_nqr_cell_color_border{$row}
					$colorar:=_nqr_cell_color_border{$row}
				Else 
					$colorav:=0x00FFFFFF
					$colorar:=0x00FFFFFF
				End if 
				If ($column=1)
					$trait:=$trait+1
					OBJECT MOVE:C664(*;"trait_"+String:C10($trait);$gf;$hf;$gf+$_nqr_cell_thicknessg{$row};$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait_"+String:C10($trait);$colorav;$colorar)
					
					If ($rowcounter=3) | ($rowcounter=4) | ($rowcounter=7)
					Else 
						$trait:=$trait+1
						OBJECT MOVE:C664(*;"trait_"+String:C10($trait);$gf;$hf;$gf+$width;$hf+$_nqr_cell_thicknessh{$row};*)
						OBJECT SET RGB COLORS:C628(*;"trait_"+String:C10($trait);$colorav;$colorar)
					End if 
					
					If ($rowcounter=2) | ($rowcounter=3) | ($rowcounter=6)
						$trait:=$trait+1
						OBJECT MOVE:C664(*;"trait_"+String:C10($trait);$gf;$bf;$gf+$width;$bf+$_nqr_cell_thicknessih{$row};*)
						OBJECT SET RGB COLORS:C628(*;"trait_"+String:C10($trait);$colorav;$colorar)
					Else 
						$trait:=$trait+1
						OBJECT MOVE:C664(*;"trait_"+String:C10($trait);$gf;$bf;$gf+$width;$bf+$_nqr_cell_thicknessb{$row};*)
						OBJECT SET RGB COLORS:C628(*;"trait_"+String:C10($trait);$colorav;$colorar)
					End if 
					
				End if 
				$trait:=$trait+1
				OBJECT MOVE:C664(*;"trait_"+String:C10($trait);$df-$_nqr_cell_thicknessd{$row};$hf;$df;$bf;*)
				OBJECT SET RGB COLORS:C628(*;"trait_"+String:C10($trait);$colorav;$colorar)
				
				OBJECT MOVE:C664(*;"nqr_bkg"+String:C10($rowcounter+(($column-1)*10));$gf;$hf;$df;$bf;*)
				If ($_high{$column}{$rowcounter}<$_heigth{$rowcounter})
					$loc_v:=$loc_v+Int:C8(($_heigth{$rowcounter}-$_high{$column}{$rowcounter})/2)
					OBJECT MOVE:C664(*;$name_objet;$offset_h_c+$loc_h;$offset_v_c+$loc_v;$offset_h_c+$loc_h+$_width{$column};$offset_v_c+$loc_v+$_high{$column}{$rowcounter};*)
				Else 
					OBJECT MOVE:C664(*;$name_objet;$offset_h_c+$loc_h;$offset_v_c+$loc_v;$offset_h_c+$loc_h+$_width{$column};$offset_v_c+$loc_v+$_heigth{$rowcounter};*)
				End if 
				
				$offset_v_c:=$offset_v_c+$_heigth{$rowcounter}+6
			End for 
			$offset_h_c:=$offset_h_c+$_width{$column}+6
		End for 
		
End case 