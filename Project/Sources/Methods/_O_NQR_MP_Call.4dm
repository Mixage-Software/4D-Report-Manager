//%attributes = {"invisible":true}
C_LONGINT:C283($1;$2)

C_LONGINT:C283($h;$d;$g;$b)
C_LONGINT:C283($find;$find2)
C_LONGINT:C283($command)

  // never called  on 64bit version...

$command:=$2

Case of 
	: ($command=0)
		  // nothing to make
	: ($command=qr cmd new:K14900:18) | ($command=qr cmd revert to save:K14900:22) | ($command=qr cmd open:K14900:19)
		QR EXECUTE COMMAND:C791(nqr_Area;$command)
		NQR_Init 
		
	: ($command=qr cmd save:K14900:20)
		If (gQR_ReportManager)
			QR_Manager_SaveRecord (nqr_Area)
		Else 
			QR EXECUTE COMMAND:C791(nqr_Area;$command)
		End if 
		
		  //2004
		
		
	: ($command=qr cmd print preview:K14900:25) | ($command=qr cmd generate:K14900:26)
		
		NQR_Executer ($command)
		
	: ($command>=2500) & ($command<=2504)  // set destination
		QR EXECUTE COMMAND:C791(nqr_Area;$command)
		NQR_Update_Destination 
		
		
	: ($command=qr cmd insert column:K14900:37)  //2600)  `
		QR EXECUTE COMMAND:C791(nqr_Area;qr cmd insert column:K14900:37)
		NQR_Get_Fields 
		NQR_Get_lh_Column 
		
	: ($command=qr cmd delete column:K14900:38)  // 2601
		QR EXECUTE COMMAND:C791(nqr_Area;qr cmd delete column:K14900:38)
		NQR_Get_Fields 
		NQR_Get_lh_Column 
		
	: ($command=qr cmd edit column:K14900:40)  // 2603
		QR EXECUTE COMMAND:C791(nqr_Area;qr cmd edit column:K14900:40)
		NQR_Get_Fields 
		NQR_Get_lh_Column 
		
	: ($command=qr cmd add column:K14900:45)  // 2608
		QR EXECUTE COMMAND:C791(nqr_Area;qr cmd add column:K14900:45)
		NQR_Get_Fields 
		NQR_Get_lh_Column 
		
	: ($command=3003) | ($command=3002)  //qr cmd move
		QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)
		QR GET SELECTION:C793(nqr_area;$g;$h;$d;$b)
		$find:=Find in array:C230(_nqr_col;$g)
		If ($find>0)
			If ($command=3003)
				$find2:=Find in array:C230(_nqr_col;$g+1)
				If ($find2>0)
					_nqr_col{$find2}:=_nqr_col{$find2}-1
				End if 
				_nqr_col{$find}:=_nqr_col{$find}+1
			Else 
				$find2:=Find in array:C230(_nqr_col;$g-1)
				If ($find2>0)
					_nqr_col{$find2}:=_nqr_col{$find2}+1
				End if 
				_nqr_col{$find}:=_nqr_col{$find}-1
			End if 
			QR SET SORTS:C752(nqr_area;_nqr_col;_nqr_order)
		End if 
		QR EXECUTE COMMAND:C791(nqr_Area;$command)
		NQR_Get_Fields 
		
	Else 
		QR EXECUTE COMMAND:C791(nqr_Area;$command)
		
End case 

NQR_List_Get_Selection 