//%attributes = {"invisible":true}
If (False:C215)
	C_LONGINT:C283(NQR_Tables_Update ;$1)
End if 

$master_table_num:=$1
$find:=Find in array:C230(_nqr_table_id;$master_table_num)
If ($find>0)
	_nqr_tables:=$find
Else 
	_nqr_tables:=1  // ???
End if 
nqr_table_name:=_nqr_tables{_nqr_tables}
