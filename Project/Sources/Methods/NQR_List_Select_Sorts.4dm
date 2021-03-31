//%attributes = {"invisible":true}
C_LONGINT:C283($1;$item)

Case of 
	: (nqr_tr_1=1)
		$item:=$1
		SELECT LIST ITEMS BY POSITION:C381(nqr_lh_sort;$item)
End case 
