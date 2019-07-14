#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable war--nings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;------------------------------------------------------------------------------
; Enable these if windows are not activating correctly
;------------------------------------------------------------------------------
; #WinActivateForce
; #SingleInstance force


;------------------------------------------------------------------------------
; Characters
;------------------------------------------------------------------------------
CharPrimary := "Biggs"
CharSecondary := "Wedge"
CharActive := ""


;------------------------------------------------------------------------------
; Init
;------------------------------------------------------------------------------
CmdRouterSwitch := true
Active := Boolean(CmdRouterSwitch)
WinGet, CharPrimaryId, ID, %CharPrimary%
WinGet, CharSecondaryId, ID, %CharSecondary%

If (!CharPrimaryId)
{
  MsgBox % "FFXI client instance for " . CharPrimary . " not found."
}
If (!CharSecondaryId)
{
  MsgBox % "FFXI client instance for " . CharSecondary . " not found."
}

; initial load
CharActive := CharPrimary
Sublimation(CharActive)  


;------------------------------------------------------------------------------
; Onscreen Display
;------------------------------------------------------------------------------

StatusFont = "Arial"  ; list of available fonts https://www.autohotkey.com/docs/misc/FontsStandard.htm
StatusFontSize = "14"
StatusErrColor := "FF0000"  ; https://www.autohotkey.com/docs/commands/Progress.htm#colors 
StatusOkColor := "009900"   ; or use the Hex values from https://www.google.com/search?q=rgb+colour+picker 
GuiBgColor := "000000"  ; Can be any RGB color (it will be made transparent below).

Gui +LastFound +AlwaysOnTop -Caption +ToolWindow  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Color, %GuiBgColor%
Gui, Font, s%StatusFontSize% c%StatusOkColor% bold, %StatusFont%
Gui, Add, Text, vStatusText c%StatusOkColor%, XXXXXX YYYYYY  ; XX & YY serve to auto-size the window.
; Make all pixels of this color transparent and make the text itself translucent (150):
WinSet, TransColor, %GuiBgColor% 255
SetTimer, UpdateOSD, 200
Gosub, UpdateOSD  ; Make the first update immediate rather than waiting for the timer.
Gui, Show, y20, NoActivate  ; NoActivate avoids deactivating the currently active window.
Return

UpdateOSD:
If (Active == "True") 
{
  UpdateStatus(StatusOkColor, CharActive)
} 
Else 
{
  UpdateStatus(StatusErrColor, "Sublimation ❌")
}
Return


;------------------------------------------------------------------------------
; Key Binds
;------------------------------------------------------------------------------

#F12::
  Suspend, Permit
  ExitApp
return

; Toggle CmdRouter
F12::
  Suspend, Permit
  Suspend
  CmdRouterSwitch := !CmdRouterSwitch
  Active := Boolean(CmdRouterSwitch)
return

; Toggle Characters
#Tab::
  CharActive := CharActive = CharPrimary ? CharSecondary : CharPrimary
  Sublimation(CharActive)
return


;------------------------------------------------------------------------------
; Functions
;------------------------------------------------------------------------------

; Convert boolean to string
Boolean(bool)
{
  return bool = true ? "True" : "False"
}

; Switch active Windows
; https://en.wikipedia.org/wiki/Sublimation_(phase_transition)
; Black magic!! ✨🧙✨
Sublimation(char)
{
  WinShow, %char%
  WinActivate, %char%
  Return
}

; Update GUI status text
UpdateStatus(StatusColor, StatusMessage)
{
  Gui, Font, s%StatusFontSize% c%StatusColor%, %StatusFont%
  GuiControl, Font, Static1  ; Static1 is the AHK ClassNN - changing this will break the OSD!!
  GuiControl, Move, StatusText, W1400
  GuiControl,, StatusText, %StatusMessage%`
}

