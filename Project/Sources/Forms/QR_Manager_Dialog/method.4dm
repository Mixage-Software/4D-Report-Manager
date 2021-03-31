C_BLOB:C604(gQR_EmptyReport)
C_BOOLEAN:C305(gQR_DeferredLoad)

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		SET MENU BAR:C67(<>QR_ReportManagerMenu)
		
		QR_Manager_LB_Update 
		NQR_Tables_Init (Table:C252(gQR_MasterTablePtr))
		
		OBJECT SET ENABLED:C1123(p_genera;False:C215)
		OBJECT SET ENABLED:C1123(p_cancella;False:C215)
		OBJECT SET ENABLED:C1123(p_duplica;False:C215)
		SET TIMER:C645(-1)
		
		
	: (Form event code:C388=On Timer:K2:25)
		
		If (gQR_DeferredLoad)
			
			gQR_DeferredLoad:=False:C215
			$size:=BLOB size:C605(gQR_ReportBLOBPtr->)
			If ($size>0)
				_Expand_BLOB_NoErr (gQR_ReportBLOBPtr)
				QR BLOB TO REPORT:C771(QR_Preview;gQR_ReportBLOBPtr->)
			End if 
			
		Else   // first call
			QR SET AREA PROPERTY:C796(QR_Preview;_o_qr view menubar:K14905:1;0)
			QR SET AREA PROPERTY:C796(QR_Preview;_o_qr view standard toolbar:K14905:2;0)
			QR SET AREA PROPERTY:C796(QR_Preview;_o_qr view operators toolbar:K14905:4;0)
			QR SET AREA PROPERTY:C796(QR_Preview;_o_qr view style toolbar:K14905:3;0)
			QR SET AREA PROPERTY:C796(QR_Preview;_o_qr view column toolbar:K14905:6;0)
			QR SET AREA PROPERTY:C796(QR_Preview;_o_qr view color toolbar:K14905:5;0)
			QR REPORT TO BLOB:C770(QR_Preview;gQR_EmptyReport)
			OBJECT SET VISIBLE:C603(QR_Preview;True:C214)
		End if 
		
		SET TIMER:C645(0)
		
	: (Form event code:C388=On Clicked:K2:4) | (Form event code:C388=On Double Clicked:K2:5) | (Form event code:C388=On Selection Change:K2:29)
		
		GOTO SELECTED RECORD:C245(gQR_ReportTablePtr->;aQR_ReportName)
		LOAD RECORD:C52(gQR_ReportTablePtr->)
		$selected:=Record number:C243(gQR_ReportTablePtr->)#-1
		OBJECT SET ENABLED:C1123(p_genera;$selected)
		OBJECT SET ENABLED:C1123(p_cancella;$selected)
		OBJECT SET ENABLED:C1123(p_duplica;$selected)
		
		gQR_NewRecord:=(p_nuovo=1)
		p_nuovo:=0
		$modifySelection:=(Form event code:C388=On Double Clicked:K2:5) & (_ClickedObject ("preview_button") | _ClickedObject ("LB_QR_Reports"))
		$changedSelection:=(Form event code:C388=On Selection Change:K2:29)
		
		If ($changedSelection | $modifySelection | gQR_NewRecord)
			If (gQR_NewRecord)
				QR_Manager_NewRecord (QR_Manager_UniqueName )
				$recnum:=Record number:C243(gQR_ReportTablePtr->)
				$modifySelection:=True:C214
				$ok:=QR_Manager_ModifyRecord 
				If ($ok=False:C215)
					DELETE RECORD:C58(gQR_ReportTablePtr->)
				End if 
				QR_Manager_LB_Update ($recnum)
			Else 
				If ($selected)
					If ($modifySelection)
						$ok:=QR_Manager_ModifyRecord 
						If ($ok)
							aQR_ReportName{Selected record number:C246(gQR_ReportTablePtr->)}:=gQR_ReportNamePtr->
						End if 
					Else 
						LOAD RECORD:C52(gQR_ReportTablePtr->)
					End if 
				Else 
					UNLOAD RECORD:C212(gQR_ReportTablePtr->)
					REDRAW WINDOW:C456
					QR BLOB TO REPORT:C771(QR_Preview;gQR_EmptyReport)
				End if 
				vQR_Commenti:=gQR_ReportCommentsPtr->
			End if 
			
			If ($modifySelection)
				  // 64 bit trick
				gQR_DeferredLoad:=True:C214
				SET TIMER:C645(-1)
			Else 
				$size:=BLOB size:C605(gQR_ReportBLOBPtr->)
				If ($size>0)
					_Expand_BLOB_NoErr (gQR_ReportBLOBPtr)
					QR BLOB TO REPORT:C771(QR_Preview;gQR_ReportBLOBPtr->)
				End if 
			End if 
		End if 
		
		
End case 