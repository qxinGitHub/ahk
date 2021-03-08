#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

WinActivate, ahk_exe ONENOTE.EXE
Sleep, 200
MouseGetPos, posx, posy
  ;官方推荐使用 click ，相比于 MouseClick 更加简单易用，但此处需要将速度设为0，故用 MouseClick
  ;click 204,26
Send, !{3}
Sleep 400
MouseClick, , 145, 102, , 0
Sleep 200
MouseMove, posx, posy, 0


Return