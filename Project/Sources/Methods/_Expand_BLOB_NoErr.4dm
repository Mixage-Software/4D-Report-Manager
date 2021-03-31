//%attributes = {"invisible":true}
  // $1 BLOB pointer

C_POINTER:C301($1)

ON ERR CALL:C155("_NO_ERROR")
EXPAND BLOB:C535($1->)
ON ERR CALL:C155("")
