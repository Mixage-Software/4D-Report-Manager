Case of 
	: (Form event code:C388=On After Edit:K2:43)
		OBJECT GET RGB COLORS:C1074(gColorPicker;$temp;$colorNum)
		For ($i;1;6)
			If (OBJECT Get visible:C1075(*;"Border"+String:C10($i)))
				OBJECT SET RGB COLORS:C628(*;"Border"+String:C10($i);$colorNum;$colorNum)
			End if 
		End for 
		
	: (Form event code:C388=On Losing Focus:K2:8)  // **BUG** NOT CALLED IN COMPONENT MODE (Mac platform)
		OBJECT SET VISIBLE:C603(*;"color_picker_button_focus";False:C215)
		
End case 