//%attributes = {"invisible":true}
C_LONGINT:C283($i;$position;$col;$find)
C_TEXT:C284($title;$row_text;$name_object;$col1;$col2;$col3;$col4;$font;$font_r)
C_OBJECT:C1216($template)

Case of 
	: (_nqr_format=0)
	: (_nqr_format>Size of array:C274(_nqr_format))
	Else 
		ARRAY TEXT:C222($_font;0)
		FONT LIST:C460($_font)
		
		ARRAY TEXT:C222($_name_object;4)
		$_name_object{1}:="nqr_header_@"
		$_name_object{2}:="nqr_body_@"
		$_name_object{3}:="nqr_break_@"
		$_name_object{4}:="nqr_total_@"
		For ($i;1;4;1)
			OBJECT SET FONT:C164(*;$_name_object{$i};$_font{1})
			OBJECT SET FONT SIZE:C165(*;$_name_object{$i};12)
			OBJECT SET FONT STYLE:C166(*;$_name_object{$i};0)
			OBJECT SET HORIZONTAL ALIGNMENT:C706(*;$_name_object{$i};1)
			OBJECT SET RGB COLORS:C628(*;$_name_object{$i};0x0000)  // Black
		End for 
		OBJECT SET RGB COLORS:C628(*;"nqr_bkg@";0x00FFFFFF)  // White
		
		  // Loads template
		$template:=at_Templates{_nqr_format}
		$title:=$template.title
		
		ARRAY TEXT:C222($at_sampleData;0)
		OB GET ARRAY:C1229($template;"sampleData";$at_sampleData)
		$ac_sampleData:=$template.sampleData
		For ($i;1;10;1)
			  // template sample values
			  //$row_text:=$at_sampleData{$i}
			$row_text:=$ac_sampleData[$i-1]
			Case of 
				: ($i=1)
					$name_object:="nqr_header_"
				: ($i=2)
					$name_object:="nqr_body_1"
				: ($i=3)
					$name_object:="nqr_body_2"
				: ($i=4)
					$name_object:="nqr_body_3"
				: ($i=5)
					$name_object:="nqr_break_21"
				: ($i=6)
					$name_object:="nqr_body_4"
				: ($i=7)
					$name_object:="nqr_body_5"
				: ($i=8)
					$name_object:="nqr_break_22"
				: ($i=9)
					$name_object:="nqr_break_11"
				: ($i=10)
					$name_object:="nqr_total_"
			End case 
			$position:=Position:C15(",";$row_text)
			$col1:=Substring:C12($row_text;1;$position-1)
			$row_text:=Substring:C12($row_text;$position+1)
			$position:=Position:C15(",";$row_text)
			$col2:=Substring:C12($row_text;1;$position-1)
			$row_text:=Substring:C12($row_text;$position+1)
			$position:=Position:C15(",";$row_text)
			$col3:=Substring:C12($row_text;1;$position-1)
			$col4:=Substring:C12($row_text;$position+1)
			Get pointer:C304($name_object+"1")->:=$col1
			Get pointer:C304($name_object+"2")->:=$col2
			Get pointer:C304($name_object+"3")->:=$col3
			Get pointer:C304($name_object+"4")->:=$col4
			
		End for 
		
		ARRAY TEXT:C222(_nqr_cell_font;5;4)
		ARRAY INTEGER:C220(_nqr_cell_font_size;5;4)
		ARRAY INTEGER:C220(_nqr_cell_font_style;5;4)
		ARRAY INTEGER:C220(_nqr_cell_text_align;5;4)
		ARRAY LONGINT:C221(_nqr_cell_color_text;5;4)
		ARRAY LONGINT:C221(_nqr_cell_color_back;5;4)
		ARRAY LONGINT:C221(_nqr_cell_color_alternate;5;4)
		
		$columns:=$template.columns
		
		For ($col;1;4;1)
			$cells:=$columns[$col-1].cells
			
			For ($i;1;5;1)
				  // loads cell style
				
				$cell:=$cells[$i-1]
				
				$font_r:=$cell.font
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
				
				_nqr_cell_font{$i}{$col}:=$font
				_nqr_cell_font_size{$i}{$col}:=$cell.fontSize
				_nqr_cell_font_style{$i}{$col}:=$cell.fontStyle
				_nqr_cell_text_align{$i}{$col}:=$cell.textAlignment
				_nqr_cell_color_text{$i}{$col}:=_Hex2Dec ($cell.foreColor)
				_nqr_cell_color_back{$i}{$col}:=_Hex2Dec ($cell.backColor)
				_nqr_cell_color_alternate{$i}{$col}:=_Hex2Dec ($cell.alternateColor)
			End for 
		End for 
		
		ARRAY LONGINT:C221(_nqr_cell_color_border;5)
		ARRAY INTEGER:C220(_nqr_cell_thicknessg;5)
		ARRAY INTEGER:C220(_nqr_cell_thicknessh;5)
		ARRAY INTEGER:C220(_nqr_cell_thicknessd;5)
		ARRAY INTEGER:C220(_nqr_cell_thicknessb;5)
		ARRAY INTEGER:C220(_nqr_cell_thicknessih;5)
		
		$borders:=$template.borders
		For ($i;1;5;1)
			$border:=$borders[$i-1]
			_nqr_cell_color_border{$i}:=_Hex2Dec ($border.color)
			_nqr_cell_thicknessg{$i}:=$border.left
			_nqr_cell_thicknessh{$i}:=$border.top
			_nqr_cell_thicknessd{$i}:=$border.right
			_nqr_cell_thicknessb{$i}:=$border.bottom
			_nqr_cell_thicknessih{$i}:=$border.inside
		End for 
		
		
		NQR_TMP_List_DrawPreview 
		
End case 