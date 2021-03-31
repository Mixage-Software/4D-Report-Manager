//%attributes = {"invisible":true}
$value:=0
Case of 
	: (nqr_page_break=1)
		$value:=32000
	: (nqr_extra_space=1)
		If (nqr_extra_space_kind=1)
			$value:=nqr_extra_space_value
		Else 
			$value:=-nqr_extra_space_value
		End if 
End case 
$breakLevel:=nqr_current_row-2
QR SET TOTALS SPACING:C761(nqr_area;nqr_current_row-2;$value)