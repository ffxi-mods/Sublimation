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
; Globals
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

;------------------------------------------------------------------------------
; Functions
;------------------------------------------------------------------------------

; convert boolean to string
Boolean(bool)
{
  return bool = true ? "True" : "False"
}

; refresh the splash window
UpdateSplashStatus(CmdRouterActive, ActiveCharacter)
{
  splashText := ""

  If (CmdRouterActive = "True") {
    splashText := Format("Command Router Active: {} || Character: {}", CmdRouterActive, ActiveCharacter)
  }
  If (CmdRouterActive = "False") {
    splashText := Format("Command Router Active: {}", CmdRouterActive)
  }

  SplashTextOn, 400, 25, Cmd Router, %splashText%
  WinMove, Cmd Router, , , 0,
  WinSet, Transparent, 200, Cmd Router,
}


;------------------------------------------------------------------------------
; Init
;------------------------------------------------------------------------------

; initial splash on load
CharActive := CharPrimary
UpdateSplashStatus(Active, CharActive)
WinShow, %CharActive%
WinActivate, %CharActive%


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
  UpdateSplashStatus(Active, CharActive)
return

; Toggle Characters
#Tab::
  CharActive := CharActive = CharPrimary ? CharSecondary : CharPrimary
  UpdateSplashStatus(Active, CharActive)
  WinShow, %CharActive%
  WinActivate, %CharActive%
return
