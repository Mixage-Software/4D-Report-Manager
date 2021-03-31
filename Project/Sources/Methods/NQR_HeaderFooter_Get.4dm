//%attributes = {"invisible":true}

  //........................................................................................................................

  //   Project Method:  Wizard_GetHeaderFooter

  //   Description:  Manages Header and Footer

  //   Called by:   Wiz Form

  //   Calls:  Nothing

  //   Parameters:  None

  //   Returns:   Nothing

  //   Created by  Jean-Yves Fock-Hoon

  //   Modified by Luis Piñeiros 
  //   2009

  //........................................................................................................................


C_TEXT:C284($fontname_t)
C_LONGINT:C283(vStyleBold;vStyleItalic;vStyleUnderline)

$selector:=$1
QR GET HEADER AND FOOTER:C775(nqr_area;$selector;vTextLeft;vTextCenter;vTextRight;vHeight;vPicture;vAlignment)
If ($selector=1)
	  // Header
	$section:=qr header:K14906:4
Else 
	  // Footer
	$section:=qr footer:K14906:5
End if 

$fontname_t:=QR Get text property:C760(nqr_area;0;$section;qr font name:K14904:10)
vSize:=QR Get text property:C760(nqr_area;0;$section;2)
vStyleBold:=QR Get text property:C760(nqr_area;0;$section;3)
vStyleItalic:=QR Get text property:C760(nqr_area;0;$section;4)
vStyleUnderline:=QR Get text property:C760(nqr_area;0;$section;5)

at_FontName:=Find in array:C230(at_FontName;$fontname_t)

alignment1:=Num:C11(vAlignment=1)
alignment2:=Num:C11(vAlignment=2)
alignment3:=Num:C11(vAlignment=3)
