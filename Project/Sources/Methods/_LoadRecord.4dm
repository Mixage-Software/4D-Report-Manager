//%attributes = {"invisible":true}
  // $1 Table pointer
  // $2 (optional) attempts before asking for the line. default = 1
  // $3 (optional) dialog if locked. default = true 

C_BOOLEAN:C305($0;$retry)

$table_Ptr:=$1

If (Records in selection:C76($table_Ptr->)=0)
	$0:=False:C215
	ALERT:C41("Tentativo di caricare un record inesistente dell'archivio ["+Table name:C256($table_Ptr)+"]";"Annulla")
Else 
	
	$maxAttempts:=1  // default
	$showDialog:=True:C214  // default
	If (Count parameters:C259>=2)
		$maxAttempts:=$2
		If (Count parameters:C259>=3)
			$showDialog:=$3
		End if 
	End if 
	
	$attempt:=1
	Repeat 
		LOAD RECORD:C52($table_Ptr->)
		If (Locked:C147($table_Ptr->))
			$0:=False:C215
			If ($attempt<$maxAttempts)
				DELAY PROCESS:C323(Current process:C322;30)
				$attempt:=$attempt+1
				$retry:=True:C214
			Else 
				$retry:=False:C215
				If (Read only state:C362($table_Ptr->))
					ALERT:C41("L'archivio ["+Table name:C256($table_Ptr)+"] è in modalità di sola lettura";"Annulla")
				Else 
					C_REAL:C285($process)
					C_TEXT:C284($user;$machine;$processName)
					LOCKED BY:C353($table_Ptr->;$process;$user;$machine;$processName)
					If ($user="") & ($machine="")
						$user:=Current user:C182
						$machine:=Current machine:C483
					End if 
					$lockedBy:=Char:C90(13)+"Utente: "+$user+Char:C90(13)+"Machina: "+$machine+Char:C90(13)+"Processo: "+$processName+Char:C90(13)
					CONFIRM:C162("Il record dell'archivio ["+Table name:C256($table_Ptr)+"] è in uso da "+$lockedBy;"Riprova";"Annulla")
					$retry:=(ok=1)
				End if 
			End if 
		Else 
			$0:=True:C214
			$retry:=False:C215
		End if 
	Until ($retry=False:C215)
	
End if 