//%attributes = {"invisible":true}
C_TEXT:C284(<>QR_ReportMenu)
If (<>QR_ReportMenu="")
	C_TEXT:C284($NQR_FileMenu)
	$NQR_FileMenu:=Create menu:C408
	$s:=Get indexed string:C510(14908;161)  // New
	_AppendMenuItem ($NQR_FileMenu;$s;Character code:C91("N");"NQR_Menu_File";"1")
	$s:=Get indexed string:C510(14908;165)  // Open…
	_AppendMenuItem ($NQR_FileMenu;$s;Character code:C91("O");"NQR_Menu_File";"2")
	$s:=Get indexed string:C510(14907;99)  // Save
	_AppendMenuItem ($NQR_FileMenu;$s;Character code:C91("S");"NQR_Menu_File";"3")
	$s:=Get indexed string:C510(14908;164)  // Save As…
	_AppendMenuItem ($NQR_FileMenu;$s;0;"NQR_Menu_File";"4")
	APPEND MENU ITEM:C411($NQR_FileMenu;"(-")
	$s:=Get indexed string:C510(14908;167)  // Page Setup…
	_AppendMenuItem ($NQR_FileMenu;$s;0;"NQR_Menu_File";"5")
	
	C_TEXT:C284($NQR_EditMenu)
	$NQR_EditMenu:=Create menu:C408
	$s:=Get indexed string:C510(14908;169)  // Cut;Copy;Paste;Select All
	APPEND MENU ITEM:C411($NQR_EditMenu;$s)
	SET MENU ITEM SHORTCUT:C423($NQR_EditMenu;1;Character code:C91("X"))
	SET MENU ITEM PROPERTY:C973($NQR_EditMenu;1;Associated standard action:K28:8;ak cut:K76:53)
	SET MENU ITEM SHORTCUT:C423($NQR_EditMenu;2;Character code:C91("C"))
	SET MENU ITEM PROPERTY:C973($NQR_EditMenu;2;Associated standard action:K28:8;ak copy:K76:54)
	SET MENU ITEM SHORTCUT:C423($NQR_EditMenu;3;Character code:C91("V"))
	SET MENU ITEM PROPERTY:C973($NQR_EditMenu;3;Associated standard action:K28:8;ak paste:K76:55)
	SET MENU ITEM SHORTCUT:C423($NQR_EditMenu;4;Character code:C91("A"))
	SET MENU ITEM PROPERTY:C973($NQR_EditMenu;4;Associated standard action:K28:8;ak select all:K76:57)
	
	<>QR_ReportMenu:=Create menu:C408
	APPEND MENU ITEM:C411(<>QR_ReportMenu;Get indexed string:C510(14908;170);$NQR_FileMenu)
	$s:=Get indexed string:C510(14908;168)  // Edit
	APPEND MENU ITEM:C411(<>QR_ReportMenu;$s;$NQR_EditMenu)
End if 

C_TEXT:C284(<>QR_ReportManagerMenu)
If (<>QR_ReportManagerMenu="")
	
	C_TEXT:C284($QR_FileMenu)
	$QR_FileMenu:=Create menu:C408
	$s:=Get indexed string:C510(14908;130)  // Close
	_AppendMenuItem ($QR_FileMenu;$s;Character code:C91("W");"QR_Manager_M_File";"Close")
	
	C_TEXT:C284($QR_EditMenu)
	$QR_EditMenu:=Create menu:C408
	$s:=Get indexed string:C510(14908;169)  // Cut;Copy;Paste;Select All
	APPEND MENU ITEM:C411($QR_EditMenu;$s)
	SET MENU ITEM SHORTCUT:C423($QR_EditMenu;1;Character code:C91("X"))
	SET MENU ITEM PROPERTY:C973($QR_EditMenu;1;Associated standard action:K28:8;ak cut:K76:53)
	SET MENU ITEM SHORTCUT:C423($QR_EditMenu;2;Character code:C91("C"))
	SET MENU ITEM PROPERTY:C973($QR_EditMenu;2;Associated standard action:K28:8;ak copy:K76:54)
	SET MENU ITEM SHORTCUT:C423($QR_EditMenu;3;Character code:C91("V"))
	SET MENU ITEM PROPERTY:C973($QR_EditMenu;3;Associated standard action:K28:8;ak paste:K76:55)
	SET MENU ITEM SHORTCUT:C423($QR_EditMenu;4;Character code:C91("A"))
	SET MENU ITEM PROPERTY:C973($QR_EditMenu;4;Associated standard action:K28:8;ak select all:K76:57)
	
	<>QR_ReportManagerMenu:=Create menu:C408
	APPEND MENU ITEM:C411(<>QR_ReportManagerMenu;Get indexed string:C510(14908;170);$QR_FileMenu)
	$s:=Get indexed string:C510(14908;168)  // Edit
	APPEND MENU ITEM:C411(<>QR_ReportManagerMenu;$s;$QR_EditMenu)
End if 