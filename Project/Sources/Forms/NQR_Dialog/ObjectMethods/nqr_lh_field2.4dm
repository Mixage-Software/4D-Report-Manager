NQR_Hdl_dc_Field (Self:C308)

  //C_LONGINT($evt)
  //C_LONGINT($position;$table;$field;$subfield;$ref_field;$column)
  //C_POINTER($fieldptr)
  //C_TEXT($text)
  //
  //$evt:=Form event
  //Case of
  //: ($evt=On Double Clicked )
  //C_LONGINT($ref_field)
  //$position:=Selected list items(nqr_lh_field2)
  //If ($position>0)
  //GET LIST ITEM(nqr_lh_field2;$position;$ref_field;$text)
  //If ($ref_field>0)
  //$table:=($ref_field & 0x00FFFFFF) >> 16
  //$field:=$ref_field & 0xFFFF
  //$subfield:=$ref_field >> 24
  //
  //Case of
  //: ($table>0) & ($field>0) & ($subfield=0)
  //$fieldptr:=Field($table;$field)
  //$column:=QR Count columns(nqr_area)+1
  //
  //QR INSERT COLUMN(nqr_area;$column;$fieldptr)
  //
  //: ($table>0) & ($field>0) & ($subfield>0)
  //$fieldptr:=Field($table;$field;$subfield)
  //$column:=QR Count columns(nqr_area)+1
  //
  //QR INSERT COLUMN(nqr_area;$column;$fieldptr)
  //
  //End case

NQR_Get_lh_Column 

  //End if
  //End if
  //End case

NQR_View_Fields 