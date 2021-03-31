//%attributes = {"invisible":true}
  // $1 pointer to report master table
  // $2 name (unique for the specified master table)
  // $0 corresponding record number or -1 if not found

  // this stuff could be refined by adding an ID field in the report manager table ...

C_LONGINT:C283($1;$table)

$table:=$1
$name:=$2

COPY NAMED SELECTION:C331(gQR_ReportTablePtr->;"reports")
QUERY:C277(gQR_ReportTablePtr->;gQR_ReportMasterTableNumPtr->=$table;*)
QUERY:C277(gQR_ReportTablePtr->; & ;gQR_ReportNamePtr->=$name)
$0:=Record number:C243(gQR_ReportTablePtr->)
USE NAMED SELECTION:C332("reports")
CLEAR NAMED SELECTION:C333("reports")