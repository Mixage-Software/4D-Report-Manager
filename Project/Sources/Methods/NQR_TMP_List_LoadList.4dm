//%attributes = {"invisible":true}
  // Loads list templates

$jsonFile:=Get 4D folder:C485(Current resources folder:K5:16)+"Templates_list.json"
$vt_templates:=Document to text:C1236($jsonFile)

ARRAY OBJECT:C1221(at_Templates;0)
JSON PARSE ARRAY:C1219($vt_templates;at_Templates)

ARRAY TEXT:C222(_nqr_format;Size of array:C274(at_Templates))
For ($i;1;Size of array:C274(at_Templates);1)
	$template:=at_Templates{$i}
	$title:=$template.title
	_nqr_format{$i}:=$title
End for 
If (_nqr_format=0) | (_nqr_format>Size of array:C274(_nqr_format))
	_nqr_format:=1
End if 
NQR_TMP_List_Load 