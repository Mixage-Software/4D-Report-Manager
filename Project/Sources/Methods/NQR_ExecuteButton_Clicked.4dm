//%attributes = {"invisible":true}

Case of 
	: (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Long Click:K2:37)
		
		$doit:=True:C214
		  // On Arrow Click ????
		  // https://kb.4d.com/assetid=36706
		  // empirical method to get the arrow rect of the button...
		If (Form event code:C388=On Long Click:K2:37) | (_ClickedRightBottomCorner (Self:C308;20))
			
			$s:=Get indexed string:C510(14908;180)
			$newDestination:=Pop up menu:C542($s)
			If ($newDestination>0)
				QR SET DESTINATION:C745(nqr_area;$newDestination)
				NQR_ExecuteButton_Update 
			Else 
				$doit:=False:C215
			End if 
		End if 
		
		If ($doit)
			NQR_Executer (qr cmd generate:K14900:26)
		End if 
		
End case 
