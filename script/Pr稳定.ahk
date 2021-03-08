#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

WinActivate, ahk_exe Adobe Premiere Pro.exe
Sleep, 200

MouseGetPos, posx, posy


; 通过搜图寻找
; CoordMode, Pixel,Screen
; ImageSearch, OutputVarX, OutputVarY, 0, 200, 1000, 1000, *2 *Trans2 C:\Users\qxin\OneDrive\AHK\caps\script\img\search.bmp
; If (!OutputVarX){
;   ImageSearch, OutputVarX, OutputVarY, 0, 200, 1000, 1000, *2 *Trans2 C:\Users\qxin\OneDrive\AHK\caps\script\img\search_blue.bmp
; }
; CoordMode,mouse,Screen
; Click,%OutputVarX%,%OutputVarY%


; 定位到 “效果栏”
send ^!+7
sleep 50
send +f
sleep 50

; MouseMove, %A_CaretX%, %A_CaretY%, 0



Sleep, 100
Send,^a
sendbyclip("变形稳定器")
Sleep, 100

OutputVarX := A_CaretX + 150
OutputVarY := A_CaretY + 150

Click,%OutputVarX%,%OutputVarY%

; CoordMode,mouse,Window
; Sleep 200

; Click ,posx2,posy2

; MouseClickDrag, Left, posx2, posy2, posx, posy, 30





; MouseGetPos, posx, posy

  ;官方推荐使用 click ，相比于 MouseClick 更加简单易用，但此处需要将速度设为0，故用 MouseClick
  ;click 204,26
; MouseClick, , 165, 87, , 0


; MouseMove, posx, posy, 0

Return


;函数

; 从剪贴板输入到界面
; 四个参数 三个可选
  ; move 可选,光标是否移动 (默认 0, 不移动)
  ; left,right 可选,前后空格 (默认 0, 无空格)
sendbyclip(var_string,move:=0,left:=0,right:=0){
    ClipboardOld := ClipboardAll
    Clipboard = %var_string%
  	ClipWait
  	; loop,%left%{
  		Send, {space %left%}
  	; }
    send ^v
    send,{Space %right%}
    Sleep 100
    Clipboard := ClipboardOld  ; Restore previous contents of clipboard.
    ClipboardOld = ;若原文件过大的情况下可以释放内存

    Send {Left %move%}
}