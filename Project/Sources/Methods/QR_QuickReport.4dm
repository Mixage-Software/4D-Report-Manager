//%attributes = {"invisible":true,"shared":true}
  // $1 pointer to master table (optional: using default table if omitted)
  // $2 QR document to load (not handled at this time)
  // $3 Boolean - Allow automatic relations (optional: defaults to True)
  // $4 Boolean - Enable wizard (optional: defaults to True)
  // $5 Boolean -Allow changing table and queries (optional: defaults to False)


Case of 
	: (Not:C34(Asserted:C1132(Count parameters:C259>=1;"Missing mandatory parameter: pointer to master table")))
		
	Else 
		
		QR_Startup 
		gQR_ReportManager:=False:C215
		
		  // defaults
		gQR_MasterTablePtr:=Current default table:C363
		nqr_allowautomatic:=1  //allow automatic relations 
		nqr_wizard:=1  //allow Quick Report Wizard
		nqr_allowsearches:=0  //allow queries 
		
		If (Count parameters:C259>0)
			gQR_MasterTablePtr:=$1
			If (Count parameters:C259>1)
				$document:=$2  //ignored
				If (Count parameters:C259>2)
					nqr_allowautomatic:=Num:C11($3)
					If (Count parameters:C259>3)
						nqr_wizard:=Num:C11($4)
						If (Count parameters:C259>4)
							nqr_allowsearches:=Num:C11($5)
						End if 
					End if 
				End if 
			End if 
		End if 
		
		nrq_allow_table_selection:=nqr_allowsearches
		
		If (_ComponentRunningInHostMode  | Is Windows:C1573)
			$wRef:=Open form window:C675("NQR_Dialog";*)  // Su windows i menu non funzionano se Movable dialog box...
		Else 
			$wRef:=Open form window:C675("NQR_Dialog";Movable dialog box:K34:7;*)
		End if 
		
		If (nqr_allowautomatic=1)
			SET AUTOMATIC RELATIONS:C310(True:C214;True:C214)
		End if 
		DIALOG:C40("NQR_Dialog")
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		CLOSE WINDOW:C154
		
End case 
  //End of method 