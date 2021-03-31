//%attributes = {"invisible":true}
C_LONGINT:C283($i)

  // pass to the next step
nqr_step_current:=nqr_step_current+1
  // we are not in the last step
nqr_final_step:=False:C215
  // set so we can pass to the following step
nqr_step_following_ok:=True:C214
  // check for maximum value
If (nqr_step_maximum<nqr_step_current)
	nqr_step_maximum:=nqr_step_current
End if 
  //activate the navigation buttons
OBJECT SET ENABLED:C1123(nqr_b_Step_Next;True:C214)
OBJECT SET ENABLED:C1123(nqr_b_Step_Previous;True:C214)

Case of 
	: (nqr_tr_1=1)  //report in list
		Case of 
			: (nqr_step_current=1)
				nqr_step_1:="1 - "+Get indexed string:C510(14907;24)  //"Report type"
				nqr_step_title:=Get indexed string:C510(14907;22)  //"Report type"
				FORM GOTO PAGE:C247(2)
				  //for step 1, it does not have a previous step
				OBJECT SET ENABLED:C1123(nqr_b_Step_Previous;False:C215)
				nqr_explanation_1:=Get indexed string:C510(14931;14907)
				nqr_explanation_2:=Get indexed string:C510(14931;14908)
				nqr_explanation_3:=Get indexed string:C510(14931;14909)
				
			: (nqr_step_current=(1+nqr_allowsearches))
				nqr_step_2:="2 - "+Get indexed string:C510(14907;2)  //"Master Table"
				nqr_step_title:=Get indexed string:C510(14907;67)  //"Select the Master Table"
				FORM GOTO PAGE:C247(14)
				nqr_explanation_1:=Get indexed string:C510(14931;14921)
				nqr_explanation_2:=Get indexed string:C510(14931;14922)
				
			: (nqr_step_current=(2+nqr_allowsearches))
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;29)  //"Data Sources"
				nqr_step_title:=Get indexed string:C510(14907;28)  //"Data Sources"
				FORM GOTO PAGE:C247(3)
				GOTO OBJECT:C206(nqr_lh_field2)
				If (nqr_cb_5=1)
					nqr_cb_5:=0
					nqr_cb_1:=1
				End if 
				nqr_explanation_1:=Get indexed string:C510(14931;14910)
				NQR_Get_lh_Column 
				NQR_Get_Fields 
				
			: (nqr_step_current=(3+nqr_allowsearches))
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;33)  //"Sort Order"
				nqr_step_title:=Get indexed string:C510(14907;32)  //"Sort Order"
				nqr_explanation_1:=Get indexed string:C510(14931;14911)
				FORM GOTO PAGE:C247(4)
				NQR_Get_lh_Column 
				NQR_List_Get_Sorts 
				
			: (nqr_step_current=(4+nqr_allowsearches))
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;37)  //"Computations"
				nqr_step_title:=Get indexed string:C510(14907;36)  //"Adding Computations"
				FORM GOTO PAGE:C247(5)
				nqr_explanation_1:=Get indexed string:C510(14931;14912)
				OBJECT SET VISIBLE:C603(*;"rectCol";False:C215)
				OBJECT SET VISIBLE:C603(*;"Border";False:C215)
				OBJECT SET VISIBLE:C603(*;"rectCel";False:C215)
				NQR_TMP_LoadComputations 
				NQR_List_Get_Selection (5)
				
			: (nqr_step_current=(5+nqr_allowsearches))
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;48)  //"Output Type"
				nqr_step_title:=Get indexed string:C510(14907;47)  //"Output Type"
				FORM GOTO PAGE:C247(6)
				nqr_explanation_1:=Get indexed string:C510(14931;14913)
				NQR_Update_Destination 
				
			: (nqr_step_current=(6+nqr_allowsearches)) & ((nqr_sc_1=1) | (nqr_sc_5=1))
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;69)  //"Presentation"
				nqr_step_title:=Get indexed string:C510(14907;68)  //"Presentation Template"
				FORM GOTO PAGE:C247(13)
				nqr_explanation_1:=Get indexed string:C510(14931;14923)
				NQR_TMP_List_LoadList 
				
				
			: (nqr_step_current=(6+nqr_allowsearches)) & (nqr_sc_1#1) & (nqr_sc_5#1)
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;95)  //"Finalization"
				nqr_step_title:=Get indexed string:C510(14907;96)  //"Finalizing the report."
				FORM GOTO PAGE:C247(15)
				nqr_final_step:=True:C214
				
			: (nqr_step_current=(7+nqr_allowsearches)) & ((nqr_sc_1=1) | (nqr_sc_5=1))
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;95)  //"Finalization"
				nqr_step_title:=Get indexed string:C510(14907;96)  //"Finalizing the report."
				FORM GOTO PAGE:C247(15)
				nqr_final_step:=True:C214
				
		End case 
		
	: (nqr_tr_2=1)  // Cross Tab Report
		Case of 
			: (nqr_step_current=1)
				nqr_step_1:="1 - "+Get indexed string:C510(14907;24)  //"Report type"
				nqr_step_title:=Get indexed string:C510(14907;22)  //"Report type"
				FORM GOTO PAGE:C247(2)
				OBJECT SET ENABLED:C1123(nqr_b_Step_Previous;False:C215)
				nqr_explanation_1:=Get indexed string:C510(14931;14907)
				nqr_explanation_2:=Get indexed string:C510(14931;14908)
				nqr_explanation_3:=Get indexed string:C510(14931;14909)
				
			: (nqr_step_current=(1+nqr_allowsearches))
				nqr_step_2:="2 - "+Get indexed string:C510(14907;2)  //"Master Table"
				nqr_step_title:=Get indexed string:C510(14907;67)  //"Select the Master Table"
				FORM GOTO PAGE:C247(14)
				nqr_explanation_1:=Get indexed string:C510(14931;14921)
				nqr_explanation_2:=Get indexed string:C510(14931;14922)
				
			: (nqr_step_current=(2+nqr_allowsearches))
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;29)  //"Data Sources"
				nqr_step_title:=Get indexed string:C510(14907;28)  //"Data Sources"
				FORM GOTO PAGE:C247(7)
				If (nqr_cb_5=1)
					nqr_cb_5:=0
					nqr_cb_1:=1
				End if 
				nqr_explanation_1:=Get indexed string:C510(14931;14916)
				nqr_explanation_2:=Get indexed string:C510(14931;14917)
				nqr_explanation_3:=Get indexed string:C510(14931;14918)
				nqr_explanation_4:=Get indexed string:C510(14931;14919)
				If (nqr_tc_column#"")
					OBJECT SET ENABLED:C1123(nqr_Btn_p7_Col;False:C215)
					OBJECT SET VISIBLE:C603(*;"p7_col@";False:C215)
				End if 
				If (nqr_tc_row#"")
					OBJECT SET ENABLED:C1123(nqr_Btn_p7_row;False:C215)
					OBJECT SET VISIBLE:C603(*;"p7_row@";False:C215)
				End if 
				If (nqr_tc_cell#"")
					OBJECT SET ENABLED:C1123(nqr_Btn_p7_Cel;False:C215)
					OBJECT SET VISIBLE:C603(*;"p7_cel@";False:C215)
				End if 
				NQR_Cross_Get_tc_lc 
				NQR_Get_Fields 
				
			: (nqr_step_current=(3+nqr_allowsearches))
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;65)  //"Sort Order"
				nqr_step_title:=Get indexed string:C510(14907;66)  //"Sort Order"
				FORM GOTO PAGE:C247(8)
				nqr_explanation_1:=Get indexed string:C510(14931;14920)
				NQR_Cross_Get_Sorts 
				
			: (nqr_step_current=(4+nqr_allowsearches))
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;73)  //"Computations"
				nqr_step_title:=Get indexed string:C510(14907;72)  //"Adding Computations"
				FORM GOTO PAGE:C247(9)
				nqr_explanation_1:=Get indexed string:C510(14931;14924)
				NQR_Cross_Get_Cell_Base 
				
			: (nqr_step_current=(5+nqr_allowsearches))
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;77)  //"Column Totals"
				nqr_step_title:=Get indexed string:C510(14907;76)  //"Define the Total for a Column"
				FORM GOTO PAGE:C247(10)
				nqr_explanation_1:=Get indexed string:C510(14931;14925)
				NQR_Cross_Get_Total_Column 
				
			: (nqr_step_current=(6+nqr_allowsearches))
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;81)  //Row Totals"
				nqr_step_title:=Get indexed string:C510(14907;80)  //"Define the Total for Rows"
				FORM GOTO PAGE:C247(11)
				nqr_explanation_1:=Get indexed string:C510(14931;14926)
				NQR_Cross_Get_Total_Row 
				
			: (nqr_step_current=(7+nqr_allowsearches))
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;48)  //"Output Type"
				nqr_step_title:=Get indexed string:C510(14907;47)  //"Output Type"
				FORM GOTO PAGE:C247(6)
				nqr_explanation_1:=Get indexed string:C510(14931;14913)
				NQR_Update_Destination 
				
			: (nqr_step_current=(8+nqr_allowsearches)) & ((nqr_sc_1=1) | (nqr_sc_5=1))
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;69)  //"Presentation"
				nqr_step_title:=Get indexed string:C510(14907;68)  //"Presentation Template"
				FORM GOTO PAGE:C247(12)
				nqr_explanation_1:=Get indexed string:C510(14931;14923)
				NQR_TMP_Cross_LoadList 
				
				
			: (nqr_step_current=(8+nqr_allowsearches)) & (nqr_sc_1#1) & (nqr_sc_5#1)
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;95)  //"Finalization"
				nqr_step_title:=Get indexed string:C510(14907;96)  //"Finalizing the report."
				FORM GOTO PAGE:C247(15)
				nqr_final_step:=True:C214
				
			: (nqr_step_current=(9+nqr_allowsearches))
				Get pointer:C304("nqr_step_"+String:C10(nqr_step_current))->:=String:C10(nqr_step_current)+" - "+Get indexed string:C510(14907;95)  //"Finalization"
				nqr_step_title:=Get indexed string:C510(14907;96)  //"Finalizing the report."
				FORM GOTO PAGE:C247(15)
				nqr_final_step:=True:C214
				
		End case 
End case 

  //Define the title
nqr_step_title:=Get indexed string:C510(14907;21)+" "+String:C10(nqr_step_current)+" : "+nqr_step_title
  //mask all the buttons
OBJECT SET VISIBLE:C603(*;"bttn@";False:C215)

  //set the authorized buttons to be seen
For ($i;1;nqr_step_maximum;1)
	OBJECT SET RGB COLORS:C628(*;"step_"+String:C10($i);0x00303030)  //dark gray
	OBJECT SET VISIBLE:C603(*;"bttn"+String:C10($i);True:C214)
	Get pointer:C304("nqr_bttn"+String:C10($i))->:=0
End for 


  //set the color of the step according the current report
If (nqr_step_following_ok)
	OBJECT SET RGB COLORS:C628(*;"step_"+String:C10($i);0x0000)  // Black
Else 
	OBJECT SET RGB COLORS:C628(*;"step_"+String:C10($i);0x007F7F7F)  //Grey
End if 
  //activate all the buttons
OBJECT SET ENABLED:C1123(*;"bttn@";True:C214)

  //except that of the current step
OBJECT SET ENABLED:C1123(*;"bttn"+String:C10(nqr_step_current);False:C215)
Get pointer:C304("nqr_bttn"+String:C10(nqr_step_current))->:=1
  //management of the last step
If (nqr_final_step) | Not:C34(nqr_step_following_ok)
	OBJECT SET ENABLED:C1123(nqr_b_Step_Next;False:C215)
Else 
	OBJECT SET ENABLED:C1123(nqr_b_Step_Next;True:C214)
End if 

