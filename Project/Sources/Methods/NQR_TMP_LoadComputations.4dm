//%attributes = {"invisible":true}
$path:=Get localized document path:C1105("Formulas.json")
$formulas:=Document to text:C1236($path)

ARRAY OBJECT:C1221($ao_formulas;0)
JSON PARSE ARRAY:C1219($formulas;$ao_formulas)
$count:=Size of array:C274($ao_formulas)
ARRAY TEXT:C222(_nqr_oper_cell;$count)
ARRAY TEXT:C222(_nqr_oper_cell_format;$count)

For ($i;1;$count;1)
	_nqr_oper_cell{$i}:=$ao_formulas{$i}.name
	_nqr_oper_cell_format{$i}:=$ao_formulas{$i}.format
End for 