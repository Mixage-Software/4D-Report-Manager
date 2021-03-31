//%attributes = {"invisible":true}
  // Loads and draws cross templates

C_TEXT:C284($title;$title_general)
C_LONGINT:C283($i)
C_OBJECT:C1216($template)

Case of 
	: (_nqr_format=0)
	: (_nqr_format>Size of array:C274(_nqr_format))
	Else 
		ARRAY TEXT:C222($_font;0)
		FONT LIST:C460($_font)
		
		  // Loads template
		$template:=at_Templates{_nqr_format}
		$title:=$template.title
		$title_general:=$template.$title_general
		
		ARRAY TEXT:C222($at_sampleData;0)
		OB GET ARRAY:C1229($template;"cellsData";$at_sampleData)
		
		nqr_title_c1:=$at_sampleData{1}
		nqr_title_c2:=$at_sampleData{2}
		nqr_title_c3:=$at_sampleData{3}
		nqr_title_c_total:=$at_sampleData{4}
		nqr_title_l1:=$at_sampleData{5}
		nqr_title_l2:=$at_sampleData{6}
		nqr_title_l3:=$at_sampleData{7}
		nqr_title_l_total:=$at_sampleData{8}
		nqr_title_v22:=$at_sampleData{9}
		nqr_title_v23:=$at_sampleData{10}
		nqr_title_v24:=$at_sampleData{11}
		nqr_title_v25:=$at_sampleData{12}
		nqr_title_v32:=$at_sampleData{13}
		nqr_title_v33:=$at_sampleData{14}
		nqr_title_v34:=$at_sampleData{15}
		nqr_title_v35:=$at_sampleData{16}
		nqr_title_v42:=$at_sampleData{17}
		nqr_title_v43:=$at_sampleData{18}
		nqr_title_v44:=$at_sampleData{19}
		nqr_title_v45:=$at_sampleData{20}
		nqr_title_v52:=$at_sampleData{21}
		nqr_title_v53:=$at_sampleData{22}
		nqr_title_v54:=$at_sampleData{23}
		nqr_title_v55:=$at_sampleData{24}
		
		ARRAY TEXT:C222(_nqr_celltc_font;8)
		ARRAY INTEGER:C220(_nqr_celltc_font_size;8)
		ARRAY INTEGER:C220(_nqr_celltc_style;8)
		ARRAY INTEGER:C220(_nqr_celltc_align;8)
		ARRAY LONGINT:C221(_nqr_celltc_color_text;8)
		ARRAY LONGINT:C221(_nqr_celltc_color_back;8)
		ARRAY LONGINT:C221(_nqr_celltc_color_alternate;8)
		
		$cellsStyles:=$template.cellsStyles
		
		For ($i;1;8;1)
			$cell:=$cellsStyles[$i-1]
			
			_nqr_celltc_font{$i}:=$cell.font
			_nqr_celltc_font_size{$i}:=$cell.fontSize
			_nqr_celltc_style{$i}:=$cell.fontStyle
			_nqr_celltc_align{$i}:=$cell.textAlignment
			_nqr_celltc_color_text{$i}:=_Hex2Dec ($cell.foreColor)
			_nqr_celltc_color_back{$i}:=_Hex2Dec ($cell.backColor)
			If ($cell.alternateColor#"")
				_nqr_celltc_color_alternate{$i}:=_Hex2Dec ($cell.alternateColor)
			Else 
				_nqr_celltc_color_alternate{$i}:=-1
			End if 
		End for 
		
		ARRAY LONGINT:C221(_nqr_celltc_colort;8)
		ARRAY INTEGER:C220(_nqr_celltc_thicknessg;8)
		ARRAY INTEGER:C220(_nqr_celltc_thicknessh;8)
		ARRAY INTEGER:C220(_nqr_celltc_thicknessd;8)
		ARRAY INTEGER:C220(_nqr_celltc_thicknessb;8)
		ARRAY INTEGER:C220(_nqr_celltc_thicknessih;8)
		ARRAY INTEGER:C220(_nqr_celltc_thicknessiv;8)
		
		$borders:=$template.borders
		For ($i;1;8;1)
			$border:=$borders[$i-1]
			
			_nqr_celltc_colort{$i}:=_Hex2Dec ($border.color)
			_nqr_celltc_thicknessg{$i}:=$border.left
			_nqr_celltc_thicknessh{$i}:=$border.top
			_nqr_celltc_thicknessd{$i}:=$border.right
			_nqr_celltc_thicknessb{$i}:=$border.bottom
			_nqr_celltc_thicknessih{$i}:=$border.insideH
			_nqr_celltc_thicknessiv{$i}:=$border.insideV
			
		End for 
		
		NQR_TMP_Cross_DrawPreview 
End case 
