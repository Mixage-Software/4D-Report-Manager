nqr_cb_1:=0
nqr_cb_2:=0
nqr_cb_3:=0
nqr_cb_4:=0
nqr_cb_5:=0

Case of 
	: (_nqr_filter=1)
		nqr_cb_1:=1
	: (_nqr_filter=2)
		nqr_cb_2:=1
	: (_nqr_filter=3)
		nqr_cb_3:=1
	: (_nqr_filter=5)
		nqr_cb_5:=1
End case 


NQR_Get_Fields 