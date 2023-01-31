C_BOOLEAN:C305(gQR_AreaInited; gQR_ReportProtected; gQR_NewRecord)

C_LONGINT:C283($h1; $g; $h; $d; $b)
C_LONGINT:C283(nqr_area)  //quick report plug-in area
C_LONGINT:C283(nqr_cb_1; nqr_cb_2; nqr_cb_3; nqr_cb_4; nqr_cb_5)  //the options that effect the list of table and fields

C_LONGINT:C283(nqr_lh_sort)
C_LONGINT:C283(nqr_lh_field; nqr_lh_field2; nqr_lh_field3; nqr_lh_sort; nqr_lh_sort2; nqr_lh_sort3; nqr_lh_column; nqr_lh_column2)
C_LONGINT:C283(nqr_lh_field_detail; nqr_lh_field_detail2; nqr_lh_field_detail3)
C_LONGINT:C283(nqr_step_current)
C_LONGINT:C283(nqr_wizard; nqr_allowsearches; nqr_allowautomatic)

C_LONGINT:C283(nqr_nb_rows)
C_LONGINT:C283(nqr_FldDelimit; nqr_RecDelimit)
C_TEXT:C284(nqr_tc_column; nqr_tc_row; nqr_tc_cell)

C_LONGINT:C283(FldDelimit; RecDelimit)


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		gQR_SavedMenuBar:=Get menu bar reference:C979
		gQR_SavedMenuBar:=Create menu:C408(gQR_SavedMenuBar)  //copy the menu in memory
		SET MENU BAR:C67(<>QR_ReportMenu)
		ENABLE MENU ITEM:C149(1; 0)
		
		gQR_AreaInited:=False:C215
		gQR_Estensione:="4qr"
		
		FONT LIST:C460(at_FontName)
		
		// Hide 4DView Destination
		OBJECT SET VISIBLE:C603(*; "TrentadueBit@"; False:C215)
		
		If (gQR_ReportManager)
			
			OBJECT SET ENABLED:C1123(*; "reportType@"; gQR_NewRecord)
			
			GET USER LIST:C609(aQR_Users; $userNumbers)
			$n:=Find in array:C230(aQR_Users; gQR_ReportOwnerPtr->)
			If ($n=-1)
				$n:=Find in array:C230(aQR_Users; Current user:C182)
			End if 
			aQR_Users:=$n
			
			gQR_ReportComments:=gQR_ReportCommentsPtr->
			gQR_ReportModifiedDate:=gQR_ReportModifiedDatePtr->
			gQR_ReportModifiedBy:=gQR_ReportModifiedByPtr->
			gQR_ReportName:=gQR_ReportNamePtr->
			$n:=Find in array:C230(aQR_Users; gQR_ReportOwnerPtr->)
			If ($n=-1)
				aQR_Users:=1
			Else 
				aQR_Users:=$n
			End if 
			gQR_ReportProtected:=gQR_ReportProtectedPtr->
			
			vSize:=BLOB size:C605(gQR_ReportBLOBPtr->)
			If (vSize=0)
				gQR_ReportModifiedDatePtr->:=Current date:C33(*)
				gQR_ReportOwnerPtr->:=Current user:C182
				gQR_ReportModifiedByPtr->:=Current user:C182
				gQR_ReportMasterTableNumPtr->:=Table:C252(gQR_MasterTablePtr)
			End if 
			FORM SET HORIZONTAL RESIZING:C892(True:C214; 1055)
			FORM SET SIZE:C891(1055; 502)
		Else 
			FORM SET HORIZONTAL RESIZING:C892(True:C214; 788)
			FORM SET SIZE:C891(788; 502)
			OBJECT GET COORDINATES:C663(*; "BorderPageBackground"; $left; $top; $right; $bottom)
			OBJECT SET COORDINATES:C1248(*; "BorderPageBackground"; $left; $top; $left+788; $bottom)
		End if 
		
		// initialize the list of  the tables
		NQR_Tables_Init(Table:C252(gQR_MasterTablePtr))
		// never allow changing table if report manager
		OBJECT SET VISIBLE:C603(_nqr_tables; gQR_ReportManager=False:C215)
		OBJECT SET VISIBLE:C603(nqr_table_name; gQR_ReportManager=True:C214)
		
		// initialize the list of  the fields
		NQR_Init_Struct_Description
		
		//define the options (popup menu)
		STRING LIST TO ARRAY:C511(14905; _nqr_filter)
		_nqr_filter:=1
		nqr_cb_1:=1
		nqr_cb_2:=0
		nqr_cb_3:=0
		nqr_cb_4:=0
		nqr_cb_5:=0
		
		OBJECT SET VISIBLE:C603(*; "nqr_dest_@"; False:C215)
		OBJECT SET ENABLED:C1123(nqr_b_Step_Previous; False:C215)
		
		nqr_sc_1:=1
		nqr_sc_2:=0
		nqr_sc_3:=0
		nqr_sc_4:=0
		nqr_sc_5:=0
		
		OBJECT SET FORMAT:C236(nqr_sc_1; "1;4;#Images/14945.png;64")
		OBJECT SET FORMAT:C236(nqr_sc_4; "1;4;#Images/14949.png;208")
		OBJECT SET FORMAT:C236(nqr_sc_3; "1;4;#Images/14947.png;208")
		OBJECT SET FORMAT:C236(nqr_sc_2; "1;4;#Images/14946.png;208")
		OBJECT SET FORMAT:C236(nqr_sc_5; "1;4;#Images/14948.png;208")
		
		OBJECT SET VISIBLE:C603(*; "bttn@"; False:C215)
		
		nqr_current_col:=0
		nqr_current_row:=0
		nqr_current_cc:=0
		nqr_current_cl:=0
		nqr_coldel:=9
		nqr_rowdel:=13
		nqr_result_html:=""
		nqr_model_html:=""
		nqr_result_file:=""
		nqr_bc_font:=1
		nqr_bc_style:=1
		nqr_bc_alignment:=1
		nqr_bc_color:=1
		nqr_bc_border:=1
		nqr_with_total_rows:=False:C215
		nqr_with_total_columns:=False:C215
		nqr_step_following_ok:=True:C214
		
		$h1:=162
		OBJECT GET COORDINATES:C663(*; ("nqr_lh_field"); $g; $h; $d; $b)
		
		OBJECT MOVE:C664(*; ("nqr_lh_field"); $g; $h; $d; $h+$h1; *)
		OBJECT MOVE:C664(*; ("nqr_lh_field_detail"); 10000; 10000; 10000; 10000; *)
		
		nqr_lh_sort:=New list:C375
		nqr_lh_column:=New list:C375
		
		//the dialogue is in manual mode; consequently the height is adapted
		OBJECT GET COORDINATES:C663(*; "nqr_area"; $g; $h; $d; $b)
		OBJECT MOVE:C664(*; "nqr_area"; $g; $h; $d; 213; *)  //set the wizard available options
		OBJECT SET VISIBLE:C603(*; "wizard@"; (nqr_wizard=1))
		
		OBJECT SET ENABLED:C1123(*; "@_BreakSettings@"; False:C215)
		ARRAY REAL:C219(ar_LineWidth; 5)
		ar_LineWidth:=3
		ar_LineWidth{1}:=0
		ar_LineWidth{2}:=0.25
		ar_LineWidth{3}:=0.5
		ar_LineWidth{4}:=1
		ar_LineWidth{5}:=2
		LISTBOX SELECT ROW:C912(lb_LineWidth; ar_LineWidth)
		SET TIMER:C645(10)  // on v19.4 using SET TIMER(-1) will not redraw area
		
	: (Form event code:C388=On Timer:K2:25)
		
		If (gQR_AreaInited=False:C215)  // Executed once
			gQR_AreaInited:=True:C214
			QR SET AREA PROPERTY:C796(nqr_area; _o_qr view color toolbar:K14905:5; 1)
			QR SET AREA PROPERTY:C796(nqr_area; _o_qr view column toolbar:K14905:6; 1)
			QR SET AREA PROPERTY:C796(nqr_area; qr view contextual menus:K14905:7; 1)
			QR SET AREA PROPERTY:C796(nqr_area; _o_qr view menubar:K14905:1; 1)
			QR SET AREA PROPERTY:C796(nqr_area; _o_qr view operators toolbar:K14905:4; 1)
			QR SET AREA PROPERTY:C796(nqr_area; _o_qr view standard toolbar:K14905:2; 1)
			QR SET AREA PROPERTY:C796(nqr_area; _o_qr view style toolbar:K14905:3; 1)
			If (gQR_ReportManager)
				vSize:=BLOB size:C605(gQR_ReportBLOBPtr->)
				If (vSize>0)
					_Expand_BLOB_NoErr(gQR_ReportBLOBPtr)
					QR BLOB TO REPORT:C771(nqr_area; gQR_ReportBLOBPtr->)
				End if 
			End if 
			NQR_Init
		End if 
		
		If (True:C214)
			// QR Area "On Data Change" NOT CALLED WHEN CLICKING A LIST REPORT COLUMN
			// SO WE SET A POOL TIMER HERE :(
			QR GET SELECTION:C793(nqr_area; $left; $top; $right; $bottom)
			If ($top=0)
				NQR_OnAreaDataChange
			End if 
			SET TIMER:C645(60)
		Else 
			SET TIMER:C645(0)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (p_ok1=1)
			$ok:=True:C214
			
			gQR_ReportCommentsPtr->:=gQR_ReportComments
			gQR_ReportModifiedDatePtr->:=gQR_ReportModifiedDate
			gQR_ReportModifiedByPtr->:=gQR_ReportModifiedBy
			gQR_ReportNamePtr->:=gQR_ReportName
			gQR_ReportOwnerPtr->:=aQR_Users{aQR_Users}
			gQR_ReportProtectedPtr->:=gQR_ReportProtected
			SAVE RECORD:C53(gQR_ReportTablePtr->)
			
			If (gQR_ReportNamePtr->#Old:C35(gQR_ReportNamePtr->))
				SET QUERY DESTINATION:C396(Into variable:K19:4; $found)
				QUERY:C277(gQR_ReportTablePtr->; gQR_ReportMasterTableNumPtr->=gQR_ReportMasterTableNumPtr->; *)
				QUERY:C277(gQR_ReportTablePtr->;  & ; gQR_ReportNamePtr->=gQR_ReportNamePtr->)
				If ($found>0)
					BEEP:C151
					ALERT:C41("Esiste già un report con lo stesso nome in questo archivio!")
					REJECT:C38
					$ok:=False:C215
				End if 
				SET QUERY DESTINATION:C396(0)
			End if 
			If ($ok)
				QR_Manager_SaveRecord(nqr_area)
			End if 
		End if 
		
		
	: (Form event code:C388=On Unload:K2:2)
		NQR_Release
		SET MENU BAR:C67(gQR_SavedMenuBar)
		
		
	: (Form event code:C388=On Resize:K2:27)
		
		$currentPage:=FORM Get current page:C276
		Case of 
			: ($currentPage=12)
				NQR_TMP_Cross_Load
			: ($currentPage=13)
				NQR_TMP_List_Load
		End case 
		
	: (Form event code:C388=On Close Box:K2:21)
		If (gQR_ReportManager)
			BEEP:C151
			FILTER EVENT:C321
		Else 
			CANCEL:C270
		End if 
		
		
End case 