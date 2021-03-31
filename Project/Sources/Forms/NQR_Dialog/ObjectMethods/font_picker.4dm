  // ----------------------------------------------------
  // Object method : BALLOON_COMMON.font.picker - (4D Report)
  // ID[17EAF1BDC5B34A0CA9CD3D79A9DCD563]
  // Created #18-9-2014 by Vincent de Lachaux
  // ----------------------------------------------------
  // Declarations
C_LONGINT:C283($Lon_area;$Lon_column;$Lon_formEvent;$Lon_row;$Lon_size)
C_LONGINT:C283($Lon_styles)
C_POINTER:C301($Ptr_me)
C_TEXT:C284($Txt_font;$Txt_me)

  // ----------------------------------------------------
  // Initialisations
$Lon_formEvent:=Form event code:C388
$Txt_me:=OBJECT Get name:C1087(Object current:K67:2)
$Ptr_me:=OBJECT Get pointer:C1124(Object current:K67:2)

  // ----------------------------------------------------
Case of 
		  //______________________________________________________
	: ($Lon_formEvent=On After Edit:K2:43)
		
		$Txt_font:=OBJECT Get font:C1069(*;$Txt_me)
		
		If ($Txt_font=".@")
			
			$Txt_font:=Get localized string:C991("systemFont")
			
		End if 
		
		$Lon_size:=OBJECT Get font size:C1070(*;$Txt_me)
		$Lon_styles:=OBJECT Get font style:C1071(*;$Txt_me)
		
		  //update selection
		$Lon_area:=nqr_area
		
		QR GET SELECTION:C793($Lon_area;$Lon_column;$Lon_row)
		$Lon_row:=_QR_RowNumToSectionNum ($Lon_area;$Lon_row)
		
		_QR_SetTextProperty ($Lon_area;qr font name:K14904:10;$Txt_font;$Lon_column;$Lon_row)
		_QR_SetTextProperty ($Lon_area;qr font size:K14904:2;String:C10($Lon_size);$Lon_column;$Lon_row)
		_QR_SetTextProperty ($Lon_area;qr underline:K14904:5;String:C10(Num:C11($Lon_styles>=4));$Lon_column;$Lon_row)
		$Lon_styles:=Choose:C955($Lon_styles>=4;$Lon_styles-4;$Lon_styles)
		_QR_SetTextProperty ($Lon_area;qr italic:K14904:4;String:C10(Num:C11($Lon_styles>=2));$Lon_column;$Lon_row)
		$Lon_styles:=Choose:C955($Lon_styles>=2;$Lon_styles-2;$Lon_styles)
		_QR_SetTextProperty ($Lon_area;qr bold:K14904:3;String:C10(Num:C11($Lon_styles=1));$Lon_column;$Lon_row)
		
		  //______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215;"Form event activated unnecessary ("+String:C10($Lon_formEvent)+")")
		
		  //______________________________________________________
End case 