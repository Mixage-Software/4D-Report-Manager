//%attributes = {"invisible":true}
C_LONGINT:C283($find)

  //set up the sorting infomation

OBJECT SET VISIBLE:C603(*;"sort_tc@";True:C214)  //we are in the case of a cross table 
OBJECT SET VISIBLE:C603(*;"sort_list@";False:C215)  //we are not in a list report
QR GET SORTS:C753(nqr_area;_nqr_col;_nqr_order)  //get the current sorting information

$find:=Find in array:C230(_nqr_col;1)  //olumns 
Case of 
	: ($find<0)
		nqr_b_sort_columns:=2
		nqr_sort_column:=Get indexed string:C510(14907;13)  //"No sort"
	: (_nqr_order{$find}=1)
		nqr_b_sort_columns:=0
		nqr_sort_column:=Get indexed string:C510(14907;14)  //"From left to right "
	: (_nqr_order{$find}=-1)
		nqr_b_sort_columns:=1
		nqr_sort_column:=Get indexed string:C510(14907;15)  //"From right to left"
End case 

$find:=Find in array:C230(_nqr_col;2)  //rows
Case of 
	: ($find<0)
		nqr_b_sort_rows:=2
		nqr_sort_row:=Get indexed string:C510(14907;13)  //"No sort"
	: (_nqr_order{$find}=1)
		nqr_b_sort_rows:=0
		nqr_sort_row:=Get indexed string:C510(14907;17)  //"From left to right"
	: (_nqr_order{$find}=-1)
		nqr_b_sort_rows:=1
		nqr_sort_row:=Get indexed string:C510(14907;16)  //"From right to left"
End case 
