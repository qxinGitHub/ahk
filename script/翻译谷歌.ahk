#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Sleep, 100

MouseGetPos,,,Candy_CurWin_id         ;当前鼠标下的进程ID
WinActivate Ahk_ID %Candy_CurWin_id%
Candy_Saved_ClipBoard := ClipboardAll
Clipboard =
Send, ^c
ClipWait,0.5
If ( ErrorLevel  )          ;如果没有选择到什么东西，则退出
{
    Clipboard := Candy_Saved_ClipBoard    ;还原粘贴板
    Candy_Saved_ClipBoard =
    MsgBox 复制错误
    Return
}


url := "https://translate.google.com/?q=" . Clipboard
Run, % url
; MsgBox, % url

Clipboard := Candy_Saved_ClipBoard    ;还原粘贴板
Candy_Saved_ClipBoard =