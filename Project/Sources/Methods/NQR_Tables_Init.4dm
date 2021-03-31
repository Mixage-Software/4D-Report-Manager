//%attributes = {"invisible":true}
C_BOOLEAN:C305(gQR_ReportManager)

If (False:C215)
	C_LONGINT:C283(NQR_Tables_Init ;$1)
End if 

  // the arrays for tables
ARRAY TEXT:C222(_nqr_tables;0)
ARRAY LONGINT:C221(_nqr_table_id;0)
GET TABLE TITLES:C803(_nqr_tables;_nqr_table_id)
$cnt:=Size of array:C274(_nqr_table_id)
For ($table_num;$cnt;1;-1)
	$id_table:=_nqr_table_id{$table_num}
	If (Not:C34(Is table number valid:C999($id_table)))
		DELETE FROM ARRAY:C228(_nqr_table_id;$table_num)
	Else 
		GET TABLE PROPERTIES:C687($id_table;$invisible)
		If ($invisible)
			DELETE FROM ARRAY:C228(_nqr_table_id;$table_num)
		End if 
	End if 
End for 


OBJECT SET VISIBLE:C603(*;"table@";(nqr_allowsearches=1))
OBJECT SET VISIBLE:C603(nqr_table_name;(nqr_allowsearches=0))

NQR_Tables_Update ($1)