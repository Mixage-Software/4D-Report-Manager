//%attributes = {"invisible":true,"shared":true}
  // $1 Pointer to host report master table
  // $2 Boolean - Allow automatic relations (optional: defaults to True)
  // $3 Boolean - Enable wizard (optional: defaults to True)
  // $4 Boolean - Allow changing table and queries (optional: defaults to False)

C_POINTER:C301($1)

$userCancelled:=False:C215
$reportManagerTableName:="_ReportManager"  // If you change this default name, ALSO CHANGE IT IN THE SQL CODE BELOW!
gQR_ReportTablePtr:=_GetTableNamed ($reportManagerTableName)
If (Is nil pointer:C315(gQR_ReportTablePtr))
	CONFIRM:C162("To use the report manager, the ["+String:C10($reportManagerTableName)+"] table must be created in the host database.";"Create Now";"Cancel")
	If (OK=1)
		  // -----------------------  HARD CODED TABLE NAME!!! ----------------------- 
		Begin SQL
			CREATE TABLE IF NOT EXISTS _ReportManager
			(Name ALPHA_NUMERIC, Comments TEXT, MasterTableNumber INT16, Report BLOB, ModifiedDate TIMESTAMP, ModifiedBy ALPHA_NUMERIC, Protected BOOLEAN, Owner ALPHA_NUMERIC );
		End SQL
		gQR_ReportTablePtr:=_GetTableNamed ($reportManagerTableName)
	Else 
		$userCancelled:=True:C214
	End if 
End if 

Case of 
	: ($userCancelled)
	: (Not:C34(Asserted:C1132(Count parameters:C259>=1;"Missing mandatory parameter: pointer to master table")))
	: (Asserted:C1132(Not:C34(Is nil pointer:C315(gQR_ReportTablePtr));"The ["+String:C10($reportManagerTableName)+"] table is not defined!"))
		
		gQR_MasterTablePtr:=$1
		
		QR_Startup 
		
		gQR_ReportManager:=True:C214
		
		C_LONGINT:C283($reportTableNum)
		$reportTableNum:=Table:C252(gQR_ReportTablePtr)
		gQR_ReportNamePtr:=Field:C253($reportTableNum;1)
		gQR_ReportCommentsPtr:=Field:C253($reportTableNum;2)
		gQR_ReportMasterTableNumPtr:=Field:C253($reportTableNum;3)
		gQR_ReportBLOBPtr:=Field:C253($reportTableNum;4)
		gQR_ReportModifiedDatePtr:=Field:C253($reportTableNum;5)
		gQR_ReportModifiedByPtr:=Field:C253($reportTableNum;6)
		gQR_ReportProtectedPtr:=Field:C253($reportTableNum;7)
		gQR_ReportOwnerPtr:=Field:C253($reportTableNum;8)
		
		nqr_allowautomatic:=1  //allow automatic relations 
		nqr_wizard:=1  //allow Quick Report Wizard
		nqr_allowsearches:=0  //allow changing table and queries 
		If (Count parameters:C259>1)
			nqr_allowautomatic:=Num:C11($2)
			If (Count parameters:C259>2)
				nqr_wizard:=Num:C11($3)
				If (Count parameters:C259>3)
					nqr_allowsearches:=Num:C11($4)
				End if 
			End if 
		End if 
		nrq_allow_table_selection:=0
		
		  //compiler
		ARRAY TEXT:C222(aQR_ReportName;0)
		
		READ WRITE:C146(gQR_ReportTablePtr->)
		MESSAGES OFF:C175
		
		
		  // Wizard_LoadStructure
		
		If (_ComponentRunningInHostMode  | Is Windows:C1573)
			gQR_ReportFormWindow:=Open form window:C675("QR_Manager_Dialog";*)  // se no i menu non funzionano...
		Else 
			gQR_ReportFormWindow:=Open form window:C675("QR_Manager_Dialog";Movable dialog box:K34:7;*)
		End if 
		
		SET WINDOW TITLE:C213("Report")
		$savedMenuBar:=Get menu bar reference:C979
		$savedMenuBar:=Create menu:C408($savedMenuBar)  //copy the menu in memory
		DIALOG:C40("QR_Manager_Dialog")
		CLOSE WINDOW:C154
		SET MENU BAR:C67($savedMenuBar)
		ENABLE MENU ITEM:C149(1;0)
		
		Case of 
			: (p_genera=1)
				
				ON ERR CALL:C155("QR_Expand_Err")
				EXPAND BLOB:C535(gQR_ReportBLOBPtr->)
				ON ERR CALL:C155("")
				$QR_Area:=QR New offscreen area:C735
				QR BLOB TO REPORT:C771($QR_Area;gQR_ReportBLOBPtr->)
				
				COPY NAMED SELECTION:C331(Table:C252(QR Get report table:C758($QR_Area))->;"QR_Selezione")
				SET AUTOMATIC RELATIONS:C310(True:C214;True:C214)  //this may modify selection...
				QR RUN:C746($QR_Area)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				USE NAMED SELECTION:C332("QR_Selezione")
				CLEAR NAMED SELECTION:C333("QR_Selezione")
				
				QR DELETE OFFSCREEN AREA:C754($QR_Area)
				
				
		End case 
		
		MESSAGES ON:C181
		READ ONLY:C145(gQR_ReportTablePtr->)
		
End case 