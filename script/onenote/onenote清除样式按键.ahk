#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

WinActivate, ahk_exe ONENOTE.EXE
Sleep, 200

Send ^+n

Return
