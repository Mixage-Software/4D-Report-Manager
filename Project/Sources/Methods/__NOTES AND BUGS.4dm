//%attributes = {"invisible":true}
  // KNOWN BUGS on 4D v18.4 Build 18.261070
  // Also earch for "**BUG**"

  // HOST MODE AND COMPONENT MODE

  // The "On Data Change" form event is not called when clicking a column in the LIST report area. See nqr_area object method.
  // Using a pool timer to update UI as a workaround

  // There's a bug workaround to make the FONT PICKER working on the Mac platform.
  // The original code on GitHub (<https://github.com/4d/4D-Report>) revealed me the mechanism used by the 4D Report area.
  // Search for "gFontPicker" to investigate the workaround implementation here

  // Header/Footer picture is always rendered at 72dpi - Is this a bug?

  // COMPONENT MODE

  // On the Mac platform, the focused variable "After Edit" form event is not called when editing the COLOR PICKER. See gColorPicker object method.

SET DATABASE LOCALIZATION:C1104("IT")
xliff_EDITOR 