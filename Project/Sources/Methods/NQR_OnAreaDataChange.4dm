//%attributes = {"invisible":true}
NQR_Update_Destination 
$currentPage:=FORM Get current page:C276
Case of 
	: ($currentPage=1)
		NQR_List_Get_Sorts (False:C215)
		NQR_List_Get_Selection 
	: ($currentPage=3)
		NQR_List_Get_Selection 
		NQR_Get_lh_Column 
	: ($currentPage=4)
		NQR_Get_lh_Column 
	: ($currentPage=5)
		NQR_List_Get_Selection 
	: ($currentPage=9)
		QR SET SELECTION:C794(nqr_area;2;2;2;2)
	: ($currentPage=10)
		QR SET SELECTION:C794(nqr_area;2;3;2;3)
	: ($currentPage=11)
		QR SET SELECTION:C794(nqr_area;3;2;3;2)
	: ($currentPage>=16)
		NQR_List_Get_Selection 
		
End case 
