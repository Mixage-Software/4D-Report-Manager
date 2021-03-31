If (_nqr_tables=0)
	NQR_Tables_Update (QR Get report table:C758(nqr_area))
Else 
	QR SET REPORT TABLE:C757(nqr_area;_nqr_table_id{_nqr_tables})
End if 
NQR_Get_Fields 