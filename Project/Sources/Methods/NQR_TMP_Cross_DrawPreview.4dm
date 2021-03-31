//%attributes = {"invisible":true}
C_LONGINT:C283($i;$j;$position;$find;$column;$row)
C_LONGINT:C283($width;$height;$width_zone;$offset_h;$offset_v;$offset_h_c;$offset_v_c;$offset_h_ep;$offset_v_ep)
C_LONGINT:C283($font_size;$style;$align;$colorf;$colorp;$color_alt_title_row;$color_alt_cell;$color_alt_total_row)
C_LONGINT:C283($color_prim_row;$color_prim_cell;$color_prim_total;$bestwidth;$bestheight;$height_zone;$trait)
C_LONGINT:C283($loc_h;$loc_v;$bf;$df;$gf;$row;$colorav;$colorar;$hf;$e1;$e2;$e3;$e4;$e5;$f1;$f2;$f3;$f4;$f5)
C_TEXT:C284($font;$font_r;$name_objet)

Case of 
	: (_nqr_format=0)
	: (_nqr_format>Size of array:C274(_nqr_format))
	Else 
		ARRAY TEXT:C222($_font;0)
		FONT LIST:C460($_font)
		OBJECT SET FONT:C164(*;"nqr_title@";$_font{1})
		OBJECT SET FONT SIZE:C165(*;"nqr_title@";12)
		OBJECT SET FONT STYLE:C166(*;"nqr_title@";0)
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*;"nqr_title@";1)
		OBJECT SET RGB COLORS:C628(*;"nqr_title@";0x0000;Background color none:K23:10)  // Black
		OBJECT SET RGB COLORS:C628(*;"nqr_fond@";0x00FFFFFF;0x00FFFFFF)  // White
		
		For ($i;1;8;1)
			
			$font:=_nqr_celltc_font{$i}
			$font_size:=_nqr_celltc_font_size{$i}
			$style:=_nqr_celltc_style{$i}
			$align:=_nqr_celltc_align{$i}
			$colorp:=_nqr_celltc_color_text{$i}
			$colorf:=_nqr_celltc_color_back{$i}
			$color_alt_title_row:=_nqr_celltc_color_alternate{2}
			$color_alt_cell:=_nqr_celltc_color_alternate{3}
			$color_alt_total_row:=_nqr_celltc_color_alternate{6}
			
			$font_r:=$font
			Repeat 
				$position:=Position:C15(",";$font_r)
				If ($position>0)
					$font:=Substring:C12($font_r;1;$position-1)
					$font_r:=Substring:C12($font_r;$position+1)
				Else 
					$font:=$font_r
					$font_r:=""
				End if 
				$find:=Find in array:C230($_font;$font)
				If ($find<0) & ($font_r="")
					$find:=1
				End if 
			Until ($find>0)
			$font:=$_font{$find}
			
			ARRAY TEXT:C222($_name_objet;1)
			Case of 
				: ($i=1)
					$_name_objet{1}:="nqr_title_c@"
				: ($i=2)
					$_name_objet{1}:="nqr_title_l@"
					$color_prim_row:=$colorp
				: ($i=3)
					$_name_objet{1}:="nqr_title_v@"
					$color_prim_cell:=$colorp
				: ($i=4)
					$_name_objet{1}:="nqr_title_c_total"
				: ($i=5)
					$_name_objet{1}:="nqr_title_l_total"
				: ($i=6)
					ARRAY TEXT:C222($_name_objet;3)
					$_name_objet{1}:="nqr_title_v25"
					$_name_objet{2}:="nqr_title_v35"
					$_name_objet{3}:="nqr_title_v45"
					$color_prim_total:=$colorp
				: ($i=7)
					$_name_objet{1}:="nqr_title_v5@"
				: ($i=8)
					$_name_objet{1}:="nqr_title_v55"
			End case 
			For ($j;1;Size of array:C274($_name_objet);1)
				$name_objet:=$_name_objet{$j}
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
				If (nqr_bc_color=1)  // cell text back color
					OBJECT SET RGB COLORS:C628(*;$name_objet;$colorp;Background color none:K23:10)
				End if 
			End for 
			If (nqr_bc_color=1)
				OBJECT SET RGB COLORS:C628(*;"nqr_fond"+String:C10($i);$colorf;$colorf)
			End if 
		End for 
		
		
		If (nqr_bc_color=1)
			If ($color_alt_cell#-1)
				OBJECT SET RGB COLORS:C628(*;"nqr_fondac";$color_alt_cell;$color_alt_cell)
				OBJECT SET RGB COLORS:C628(*;"nqr_title_v32";$color_prim_cell;Background color none:K23:10)
				OBJECT SET RGB COLORS:C628(*;"nqr_title_v33";$color_prim_cell;Background color none:K23:10)
				OBJECT SET RGB COLORS:C628(*;"nqr_title_v34";$color_prim_cell;Background color none:K23:10)
			End if 
			If ($color_alt_title_row#-1)
				OBJECT SET RGB COLORS:C628(*;"nqr_fondal";$color_alt_title_row;$color_alt_title_row)
				OBJECT SET RGB COLORS:C628(*;"nqr_title_l2";$color_prim_row;Background color none:K23:10)
			End if 
			If ($color_alt_total_row#-1)
				OBJECT SET RGB COLORS:C628(*;"nqr_fondat";$color_alt_total_row;$color_alt_total_row)
				OBJECT SET RGB COLORS:C628(*;"nqr_title_v35";$color_prim_total;Background color none:K23:10)
			End if 
		End if 
		
		ARRAY INTEGER:C220($_width;5)
		ARRAY INTEGER:C220($_heigth;5)
		ARRAY INTEGER:C220($_wide;5;5)
		ARRAY INTEGER:C220($_high;5;5)
		
		For ($column;1;5)
			For ($row;1;5)
				Case of 
					: ($row=1) & ($column=1)
						$name_objet:=""
					: ($row=1) & ($column=5)
						$name_objet:="nqr_title_c_total"
					: ($row=1)
						$name_objet:="nqr_title_c"+String:C10($column-1)
					: ($column=1) & ($row=5)
						$name_objet:="nqr_title_l_total"
					: ($column=1)
						$name_objet:="nqr_title_l"+String:C10($row-1)
					Else 
						$name_objet:="nqr_title_v"+String:C10($row)+String:C10($column)
				End case 
				If ($name_objet#"")
					OBJECT GET BEST SIZE:C717(*;$name_objet;$bestwidth;$bestheight)
					$bestwidth:=$bestwidth+2
					$bestheight:=$bestheight+1
					$_wide{$column}{$row}:=$bestwidth
					$_high{$column}{$row}:=$bestheight
					If ($bestwidth>$_width{$column})
						$_width{$column}:=$bestwidth
					End if 
					If ($bestheight>$_heigth{$row})
						$_heigth{$row}:=$bestheight
					End if 
				End if 
			End for 
		End for 
		
		ARRAY INTEGER:C220($_nqr_celltc_thicknessg;8)
		ARRAY INTEGER:C220($_nqr_celltc_thicknessh;8)
		ARRAY INTEGER:C220($_nqr_celltc_thicknessd;8)
		ARRAY INTEGER:C220($_nqr_celltc_thicknessb;8)
		ARRAY INTEGER:C220($_nqr_celltc_thicknessih;8)
		ARRAY INTEGER:C220($_nqr_celltc_thicknessiv;8)
		For ($i;1;8;1)
			Case of 
				: (nqr_bc_border=0)
					$_nqr_celltc_thicknessg{$i}:=0
				: (_nqr_celltc_thicknessg{$i}=0)
					$_nqr_celltc_thicknessg{$i}:=0
				: (_nqr_celltc_thicknessg{$i}=4)
					$_nqr_celltc_thicknessg{$i}:=2
				Else 
					$_nqr_celltc_thicknessg{$i}:=1
			End case 
			Case of 
				: (nqr_bc_border=0)
					$_nqr_celltc_thicknessh{$i}:=0
				: (_nqr_celltc_thicknessh{$i}=0)
					$_nqr_celltc_thicknessh{$i}:=0
				: (_nqr_celltc_thicknessh{$i}=4)
					$_nqr_celltc_thicknessh{$i}:=2
				Else 
					$_nqr_celltc_thicknessh{$i}:=1
			End case 
			Case of 
				: (nqr_bc_border=0)
					$_nqr_celltc_thicknessd{$i}:=0
				: (_nqr_celltc_thicknessd{$i}=0)
					$_nqr_celltc_thicknessd{$i}:=0
				: (_nqr_celltc_thicknessd{$i}=4)
					$_nqr_celltc_thicknessd{$i}:=2
				Else 
					$_nqr_celltc_thicknessd{$i}:=1
			End case 
			Case of 
				: (nqr_bc_border=0)
					$_nqr_celltc_thicknessb{$i}:=0
				: (_nqr_celltc_thicknessb{$i}=0)
					$_nqr_celltc_thicknessb{$i}:=0
				: (_nqr_celltc_thicknessb{$i}=4)
					$_nqr_celltc_thicknessb{$i}:=2
				Else 
					$_nqr_celltc_thicknessb{$i}:=1
			End case 
			Case of 
				: (nqr_bc_border=0)
					$_nqr_celltc_thicknessih{$i}:=0
				: (_nqr_celltc_thicknessih{$i}=0)
					$_nqr_celltc_thicknessih{$i}:=0
				: (_nqr_celltc_thicknessih{$i}=4)
					$_nqr_celltc_thicknessih{$i}:=2
				Else 
					$_nqr_celltc_thicknessih{$i}:=1
			End case 
			Case of 
				: (nqr_bc_border=0)
					$_nqr_celltc_thicknessiv{$i}:=0
				: (_nqr_celltc_thicknessiv{$i}=0)
					$_nqr_celltc_thicknessiv{$i}:=0
				: (_nqr_celltc_thicknessiv{$i}=4)
					$_nqr_celltc_thicknessiv{$i}:=2
				Else 
					$_nqr_celltc_thicknessiv{$i}:=1
			End case 
		End for 
		
		$width:=$_width{1}+$_width{2}+$_width{3}+$_width{4}+$_width{5}+(4*5)
		$height:=$_heigth{1}+$_heigth{2}+$_heigth{3}+$_heigth{4}+$_heigth{5}+(4*5)
		If (nqr_bc_border=1)
			If ($_nqr_celltc_thicknessg{2}>$_nqr_celltc_thicknessg{5})
				$width:=$width+$_nqr_celltc_thicknessg{2}
				$e1:=$_nqr_celltc_thicknessg{2}
			Else 
				$width:=$width+$_nqr_celltc_thicknessg{5}
				$e1:=$_nqr_celltc_thicknessg{5}
			End if 
			
			$e2:=0
			If ($e2<$_nqr_celltc_thicknessg{1})
				$e2:=$_nqr_celltc_thicknessg{1}
			End if 
			If ($e2<$_nqr_celltc_thicknessd{2})
				$e2:=$_nqr_celltc_thicknessd{2}
			End if 
			If ($e2<$_nqr_celltc_thicknessg{3})
				$e2:=$_nqr_celltc_thicknessg{3}
			End if 
			If ($e2<$_nqr_celltc_thicknessd{5})
				$e2:=$_nqr_celltc_thicknessd{5}
			End if 
			If ($e2<$_nqr_celltc_thicknessg{7})
				$e2:=$_nqr_celltc_thicknessg{7}
			End if 
			$width:=$width+$e2
			
			$e3:=0
			If ($e3<$_nqr_celltc_thicknessiv{1})
				$e3:=$_nqr_celltc_thicknessd{1}
			End if 
			If ($e3<$_nqr_celltc_thicknessiv{3})
				$e3:=$_nqr_celltc_thicknessd{3}
			End if 
			If ($e3<$_nqr_celltc_thicknessiv{7})
				$e3:=$_nqr_celltc_thicknessd{7}
			End if 
			$width:=$width+$e3+$e3
			
			$e4:=0
			If ($e4<$_nqr_celltc_thicknessd{1})
				$e4:=$_nqr_celltc_thicknessd{1}
			End if 
			If ($e4<$_nqr_celltc_thicknessg{4})
				$e4:=$_nqr_celltc_thicknessg{4}
			End if 
			If ($e4<$_nqr_celltc_thicknessd{3})
				$e4:=$_nqr_celltc_thicknessd{3}
			End if 
			If ($e4<$_nqr_celltc_thicknessg{6})
				$e4:=$_nqr_celltc_thicknessg{6}
			End if 
			If ($e4<$_nqr_celltc_thicknessd{7})
				$e4:=$_nqr_celltc_thicknessd{7}
			End if 
			If ($e4<$_nqr_celltc_thicknessg{8})
				$e4:=$_nqr_celltc_thicknessg{8}
			End if 
			$width:=$width+$e4
			
			$e5:=0
			If ($e5<$_nqr_celltc_thicknessd{4})
				$e5:=$_nqr_celltc_thicknessd{4}
			End if 
			If ($e5<$_nqr_celltc_thicknessd{6})
				$e5:=$_nqr_celltc_thicknessd{6}
			End if 
			If ($e5<$_nqr_celltc_thicknessd{8})
				$e5:=$_nqr_celltc_thicknessd{8}
			End if 
			$width:=$width+$e5
			
			
			If ($_nqr_celltc_thicknessh{1}>$_nqr_celltc_thicknessh{4})
				$height:=$height+$_nqr_celltc_thicknessh{1}
				$f1:=$_nqr_celltc_thicknessh{1}
			Else 
				$height:=$height+$_nqr_celltc_thicknessh{4}
				$f1:=$_nqr_celltc_thicknessh{4}
			End if 
			
			$f2:=0
			If ($f2<$_nqr_celltc_thicknessh{2})
				$f2:=$_nqr_celltc_thicknessh{2}
			End if 
			If ($f2<$_nqr_celltc_thicknessb{1})
				$f2:=$_nqr_celltc_thicknessb{1}
			End if 
			If ($f2<$_nqr_celltc_thicknessh{3})
				$f2:=$_nqr_celltc_thicknessh{3}
			End if 
			If ($f2<$_nqr_celltc_thicknessb{6})
				$f2:=$_nqr_celltc_thicknessb{6}
			End if 
			If ($f2<$_nqr_celltc_thicknessh{4})
				$f2:=$_nqr_celltc_thicknessh{4}
			End if 
			$height:=$height+$f2
			
			$f3:=0
			If ($f3<$_nqr_celltc_thicknessih{2})
				$f3:=$_nqr_celltc_thicknessb{2}
			End if 
			If ($f3<$_nqr_celltc_thicknessih{3})
				$f3:=$_nqr_celltc_thicknessb{3}
			End if 
			If ($f3<$_nqr_celltc_thicknessih{6})
				$f3:=$_nqr_celltc_thicknessb{6}
			End if 
			$height:=$height+$f3+$f3
			
			$f4:=0
			If ($f4<$_nqr_celltc_thicknessb{2})
				$f4:=$_nqr_celltc_thicknessb{2}
			End if 
			If ($f4<$_nqr_celltc_thicknessh{5})
				$f4:=$_nqr_celltc_thicknessh{5}
			End if 
			If ($f4<$_nqr_celltc_thicknessb{3})
				$f4:=$_nqr_celltc_thicknessb{3}
			End if 
			If ($f4<$_nqr_celltc_thicknessh{7})
				$f4:=$_nqr_celltc_thicknessh{7}
			End if 
			If ($f4<$_nqr_celltc_thicknessb{6})
				$f4:=$_nqr_celltc_thicknessb{6}
			End if 
			If ($f4<$_nqr_celltc_thicknessh{8})
				$f4:=$_nqr_celltc_thicknessh{8}
			End if 
			$height:=$height+$f4
			
			$f5:=0
			If ($f5<$_nqr_celltc_thicknessb{5})
				$f5:=$_nqr_celltc_thicknessb{5}
			End if 
			If ($f5<$_nqr_celltc_thicknessb{7})
				$f5:=$_nqr_celltc_thicknessb{7}
			End if 
			If ($f5<$_nqr_celltc_thicknessb{8})
				$f5:=$_nqr_celltc_thicknessb{8}
			End if 
			$height:=$height+$f5
		Else 
			$e1:=0
			$e2:=0
			$e3:=0
			$e4:=0
			$e5:=0
			$f1:=0
			$f2:=0
			$f3:=0
			$f4:=0
			$f5:=0
		End if 
		OBJECT GET COORDINATES:C663(*;"zone_base";$g;$h;$d;$b)
		$width_zone:=$d-$g
		$height_zone:=$b-$h
		$offset_h:=Int:C8(($width_zone-$width)/2)
		If ($offset_h<0)
			$offset_h:=10
		End if 
		$offset_v:=Int:C8(($height_zone-$height)/2)
		If ($offset_v<0)
			$offset_v:=10
		End if 
		$offset_h_c:=$offset_h+$g
		For ($column;1;5)
			$offset_v_c:=$offset_v+$h
			For ($row;1;5)
				Case of 
					: ($row=1) & ($column=1)
						$name_objet:=""
						$offset_h_ep:=0
						$offset_v_ep:=0
						
					: ($row=1) & ($column=5)
						$name_objet:="nqr_title_c_total"
						$offset_h_ep:=$e1+$e2+$e3+$e3+$e4
						$offset_v_ep:=$f1
						
					: ($row=1)
						$name_objet:="nqr_title_c"+String:C10($column-1)
						$offset_h_ep:=$e1+$e2
						Case of 
							: ($column=3)
								$offset_h_ep:=$offset_h_ep+$e3
							: ($column=4)
								$offset_h_ep:=$offset_h_ep+$e3+$e3
						End case 
						$offset_v_ep:=$f1
						
					: ($column=1) & ($row=5)
						$name_objet:="nqr_title_l_total"
						$offset_h_ep:=$e1
						$offset_v_ep:=$f1+$f2+$f3+$f3+$f4
						
					: ($column=1)
						$name_objet:="nqr_title_l"+String:C10($row-1)
						$offset_h_ep:=$e1
						$offset_v_ep:=0
						$offset_v_ep:=$f1+$f2
						Case of 
							: ($row=3)
								$offset_v_ep:=$offset_v_ep+$f3
							: ($row=4)
								$offset_v_ep:=$offset_v_ep+$f3+$f3
						End case 
					Else 
						$name_objet:="nqr_title_v"+String:C10($row)+String:C10($column)
						$offset_h_ep:=$e1+$e2
						Case of 
							: ($column=3)
								$offset_h_ep:=$offset_h_ep+$e3
							: ($column=4)
								$offset_h_ep:=$offset_h_ep+$e3+$e3
							: ($column=5)
								$offset_h_ep:=$offset_h_ep+$e3+$e3+$e4
						End case 
						$offset_v_ep:=$f1+$f2
						Case of 
							: ($row=3)
								$offset_v_ep:=$offset_v_ep+$f3
							: ($row=4)
								$offset_v_ep:=$offset_v_ep+$f3+$f3
							: ($row=5)
								$offset_v_ep:=$offset_v_ep+$f3+$f3+$f4
						End case 
				End case 
				If ($name_objet#"")
					Case of 
						: (nqr_with_total_columns=False:C215) & ($row=5)
							$loc_h:=200000
							$loc_v:=200000
						: (nqr_with_total_rows=False:C215) & ($column=5)
							$loc_h:=200000
							$loc_v:=200000
						Else 
							$loc_h:=2+$offset_h_ep
							$loc_v:=2+$offset_v_ep
					End case 
					If ($_high{$column}{$row}<$_heigth{$row})
						$loc_v:=$loc_v+Int:C8(($_heigth{$row}-$_high{$column}{$row})/2)
						OBJECT MOVE:C664(*;$name_objet;$offset_h_c+$loc_h;$offset_v_c+$loc_v;$offset_h_c+$loc_h+$_width{$column};$offset_v_c+$loc_v+$_high{$column}{$row};*)
					Else 
						OBJECT MOVE:C664(*;$name_objet;$offset_h_c+$loc_h;$offset_v_c+$loc_v;$offset_h_c+$loc_h+$_width{$column};$offset_v_c+$loc_v+$_heigth{$row};*)
					End if 
				End if 
				$offset_v_c:=$offset_v_c+$_heigth{$row}+4
			End for 
			$offset_h_c:=$offset_h_c+$_width{$column}+4
		End for 
		$trait:=0
		For ($i;1;8;1)
			If (nqr_bc_border=1)
				$colorav:=_nqr_celltc_colort{$i}
				$colorar:=_nqr_celltc_colort{$i}
			Else 
				$colorav:=0x00FFFFFF
				$colorar:=0x00FFFFFF
			End if 
			Case of 
				: ($i=1)
					
					$gf:=$offset_h+$g+$_width{1}+4-2+$e1+$e2
					$df:=$gf+$_width{2}+4+$_width{3}+4+$_width{4}+4+$e3+$e3+$e4
					$hf:=$offset_v+$h-2+$f1
					$bf:=$hf+$_heigth{1}+4+$f2
					
					$trait:=$trait+1  //001
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{1};$hf-$_nqr_celltc_thicknessh{1};$gf;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //002
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf+$_width{2}+4+$e3+2-$_nqr_celltc_thicknessiv{1};$hf;$gf+$_width{2}+4+$e3+2;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //003
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf+$_width{2}+4+$_width{3}+4+$e3+$e3+2-$_nqr_celltc_thicknessiv{1};$hf;$gf+$_width{2}+4+$_width{3}+4+$e3+$e3+2;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //004
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$df-$_nqr_celltc_thicknessd{1};$hf;$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //005
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{1};$hf-$_nqr_celltc_thicknessh{1};$df;$hf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					$trait:=$trait+1  //006
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf;$bf-$_nqr_celltc_thicknessb{1};$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
				: ($i=2)
					$gf:=$offset_h+$g-2+$e1
					$df:=$gf+$_width{1}+4+$e2
					$hf:=$offset_v+$h+$_heigth{1}+4-2+$f1+$f2
					$bf:=$hf+$_heigth{2}+4+$_heigth{3}+4+$_heigth{4}+4+$f3+$f3+$f4
					
					$trait:=$trait+1  //007
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{2};$hf-$_nqr_celltc_thicknessh{2};$gf;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //008
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$df-$_nqr_celltc_thicknessd{2};$hf;$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //009
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{2};$hf-$_nqr_celltc_thicknessh{2};$df;$hf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //010
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf;$hf+$_heigth{2}+4+$f3+2-$_nqr_celltc_thicknessih{2};$df;$hf+$_heigth{2}+4+$f3+2;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //011
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf;$hf+$_heigth{2}+4+$_heigth{3}+4+$f3+$f3+2-$_nqr_celltc_thicknessih{2};$df;$hf+$_heigth{2}+4+$_heigth{3}+4+$f3+$f3+2;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //012
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf;$bf-$_nqr_celltc_thicknessb{2};$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
				: ($i=3)
					$gf:=$offset_h+$g+$_width{1}+4-2+$e1+$e2
					$df:=$gf+$_width{2}+4+$_width{3}+4+$_width{4}+4+$e3+$e3+$e4
					$hf:=$offset_v+$h+$_heigth{1}+4-2+$f1+$f2
					$bf:=$hf+$_heigth{2}+4+$_heigth{3}+4+$_heigth{4}+4+$f3+$f3+$f4
					
					$trait:=$trait+1  //013
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{3};$hf-$_nqr_celltc_thicknessh{3};$gf;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //014
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf+$_width{2}+4+$e3+2-$_nqr_celltc_thicknessiv{3};$hf;$gf+$_width{2}+4+$e3+2;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //015
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf+$_width{2}+4+$_width{3}+4+$e3+$e3+2-$_nqr_celltc_thicknessiv{3};$hf;$gf+$_width{2}+4+$_width{3}+4+$e3+$e3+2;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //016
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$df-$_nqr_celltc_thicknessd{3};$hf;$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //017
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{3};$hf-$_nqr_celltc_thicknessh{3};$df;$hf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //018
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf;$hf+$_heigth{2}+4+$f3+2-$_nqr_celltc_thicknessih{3};$df;$hf+$_heigth{2}+4+$f3+2;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //019
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf;$hf+$_heigth{2}+4+$_heigth{3}+4+$f3+$f3+2-$_nqr_celltc_thicknessih{3};$df;$hf+$_heigth{2}+4+$_heigth{3}+4+$f3+$f3+2;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //020
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf;$bf-$_nqr_celltc_thicknessb{3};$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
				: ($i=4) & (nqr_with_total_rows)
					$gf:=$offset_h+$g+$_width{1}+4+$_width{2}+4+$_width{3}+4+$_width{4}+4-2+$e1+$e2+$e3+$e3+$e4
					$df:=$gf+$_width{5}+4+2+$e5
					$hf:=$offset_v+$h-2+$f1
					$bf:=$hf+$_heigth{1}+4+$f2
					
					$trait:=$trait+1
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{4};$hf-$_nqr_celltc_thicknessh{4};$gf;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					$trait:=$trait+1
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$df-$_nqr_celltc_thicknessd{4};$hf;$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{4};$hf-$_nqr_celltc_thicknessh{4};$df;$hf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					$trait:=$trait+1
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf;$bf-$_nqr_celltc_thicknessb{4};$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
				: ($i=5) & (nqr_with_total_columns)
					$gf:=$offset_h+$g-2+$e1
					$df:=$gf+$_width{1}+4+$e2
					$hf:=$offset_v+$h+$_heigth{1}+4+$_heigth{2}+4+$_heigth{3}+4+$_heigth{4}+4-2+$f1+$f2+$f3+$f3+$f4
					$bf:=$hf+$_heigth{5}+4+2+$f5
					
					$trait:=$trait+1
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{5};$hf-$_nqr_celltc_thicknessh{5};$gf;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					$trait:=$trait+1
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$df-$_nqr_celltc_thicknessd{5};$hf;$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{5};$hf-$_nqr_celltc_thicknessh{5};$df;$hf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					$trait:=$trait+1
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf;$bf-$_nqr_celltc_thicknessb{5};$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
				: ($i=6) & (nqr_with_total_rows)
					$gf:=$offset_h+$g+$_width{1}+4+$_width{2}+4+$_width{3}+4+$_width{4}+4-2+$e1+$e2+$e3+$e3+$e4
					$df:=$gf+$_width{5}+4+2+$e5
					$hf:=$offset_v+$h+$_heigth{1}+4-2+$f1+$f2
					$bf:=$hf+$_heigth{2}+4+$_heigth{3}+4+$_heigth{4}+4+$f3+$f3+$f4
					
					$trait:=$trait+1  //021
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{6};$hf-$_nqr_celltc_thicknessh{6};$gf;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //022
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$df-$_nqr_celltc_thicknessd{6};$hf;$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //023
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{6};$hf-$_nqr_celltc_thicknessh{6};$df;$hf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //024
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf;$hf+$_heigth{2}+4+$f3+2-$_nqr_celltc_thicknessih{6};$df;$hf+$_heigth{2}+4+$f3+2;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //025
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf;$hf+$_heigth{2}+4+$_heigth{3}+4+$f3+$f3+2-$_nqr_celltc_thicknessih{6};$df;$hf+$_heigth{2}+4+$_heigth{3}+4+$f3+$f3+2;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //026
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf;$bf-$_nqr_celltc_thicknessb{6};$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					
				: ($i=7) & (nqr_with_total_columns)
					$gf:=$offset_h+$g+$_width{1}+4-2+$e1+$e2
					$df:=$gf+$_width{2}+4+$_width{3}+4+$_width{4}+4+$e3+$e3+$e4
					$hf:=$offset_v+$h+$_heigth{1}+4+$_heigth{2}+4+$_heigth{3}+4+$_heigth{4}+4-2+$f1+$f2+$f3+$f3+$f4
					$bf:=$hf+$_heigth{5}+4+2+$f5
					
					
					$trait:=$trait+1  //027
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{7};$hf-$_nqr_celltc_thicknessh{7};$gf;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //028
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf+$_width{2}+4+$e3+2-$_nqr_celltc_thicknessih{7};$hf;$gf+$_width{2}+4+$e3+2;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //029
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf+$_width{2}+4+$_width{3}+4+$e3+$e3+2-$_nqr_celltc_thicknessih{7};$hf;$gf+$_width{2}+4+$_width{3}+4+$e3+$e3+2;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //030
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$df-$_nqr_celltc_thicknessd{7};$hf;$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //031
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{7};$hf-$_nqr_celltc_thicknessh{7};$df;$hf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1  //032
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf;$bf-$_nqr_celltc_thicknessb{7};$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
				: ($i=8) & (nqr_with_total_columns) & (nqr_with_total_rows)
					$gf:=$offset_h+$g+$_width{1}+4+$_width{2}+4+$_width{3}+4+$_width{4}+4-2+$e1+$e2+$e3+$e3+$e4
					$df:=$gf+$_width{5}+4+2+$e5
					$hf:=$offset_v+$h+$_heigth{1}+4+$_heigth{2}+4+$_heigth{3}+4+$_heigth{4}+4-2+$f1+$f2+$f3+$f3+$f4
					$bf:=$hf+$_heigth{5}+4+2+$f5
					
					$trait:=$trait+1
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{8};$hf-$_nqr_celltc_thicknessh{8};$gf;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					$trait:=$trait+1
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$df-$_nqr_celltc_thicknessd{8};$hf;$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
					$trait:=$trait+1
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf-$_nqr_celltc_thicknessg{8};$hf-$_nqr_celltc_thicknessh{8};$df;$hf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					$trait:=$trait+1
					OBJECT MOVE:C664(*;"trait"+String:C10($trait);$gf;$bf-$_nqr_celltc_thicknessb{8};$df;$bf;*)
					OBJECT SET RGB COLORS:C628(*;"trait"+String:C10($trait);$colorav;$colorar)
					
				Else 
					$gf:=200000
					$df:=200000
					$hf:=200001
					$bf:=200001
			End case 
			OBJECT MOVE:C664(*;"nqr_fond"+String:C10($i);$gf;$hf;$df;$bf;*)
		End for 
		
		If ($color_alt_cell#-1)
			$gf:=$offset_h+$g+$_width{1}+4-2+$e1+$e2
			$df:=$gf+$_width{2}+4+$_width{3}+4+$_width{4}+4+$e3+$e3+$e4
			$hf:=$offset_v+$h+$_heigth{2}+4+$_heigth{1}+4+$f1+$f2+$f3-2
			$bf:=$hf+$_heigth{3}+4+2+$f3
		Else 
			$gf:=100000
			$hf:=100000
			$df:=100000
			$bf:=100000
		End if 
		OBJECT MOVE:C664(*;"nqr_fondac";$gf;$hf;$df;$bf;*)
		If ($color_alt_title_row#-1)
			$gf:=$offset_h+$g-2+$e1
			$df:=$gf+$_width{1}+4+$e2
			$hf:=$offset_v+$h+$_heigth{2}+4+$_heigth{1}+4+$f1+$f2+$f3-2
			$bf:=$hf+$_heigth{3}+4+2+$f3
		Else 
			$gf:=100000
			$hf:=100000
			$df:=100000
			$bf:=100000
		End if 
		OBJECT MOVE:C664(*;"nqr_fondal";$gf;$hf;$df;$bf;*)
		Case of 
			: (nqr_with_total_rows=False:C215)
				$gf:=100000
				$hf:=100000
				$df:=100000
				$bf:=100000
			: ($color_alt_total_row#-1)
				$gf:=$offset_h+$g+$_width{1}+4+$_width{2}+4+$_width{3}+4+$_width{4}+4-2+$e1+$e2+$e3+$e3+$e4
				$df:=$gf+$_width{5}+4+2+$e5
				$hf:=$offset_v+$h+$_heigth{2}+4+$_heigth{1}+4+$f1+$f2+$f3-2
				$bf:=$hf+$_heigth{3}+4+2+$f3
			Else 
				$gf:=100000
				$hf:=100000
				$df:=100000
				$bf:=100000
		End case 
		OBJECT MOVE:C664(*;"nqr_fondat";$gf;$hf;$df;$bf;*)
End case 

