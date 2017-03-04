;Alt-Tab热键
RAlt & j::AltTab
RAlt & k::ShiftAltTab
RAlt & l::Send #{Tab}

; Ctrl + Tab
; LAlt & q::Send, ^{Tab}

;当前活动窗口置顶
#t::
; WinGetActiveTitle, OutputVar
WinExist("A")
WinSet, AlwaysOnTop, Toggle ;,%OutputVar%
WinGet, ExStyle, ExStyle
if(ExStyle & 0x8){
    displayToast("置顶","0f0",24)
}else{
    displayToast("取消置顶","f00",24)   
}
Return

;快捷关机
#F4::run script\caps_关机.ahk

;打开任务管理器
#ESc::
{
    KeyWait, LWin
    Send ^+{Esc}
    Return
}


; 移动窗口
#c::
Send {Alt Down}{Space Down}
; sleep 50
Send {m}
; sleep 50
Send {Alt Up}{Space Up}
Send, {ctrl}{Down}
Send, {ctrl}{Up}
Return

;candy
#F1::
Gosub,  Label_Candy_Start
Gosub extension
Return
;=====================================================================o
;                   Feng Ruohang's AHK Script                         |
;                      CapsLock Enhancement                           |
;---------------------------------------------------------------------o
;Description:
;    This Script is wrote by Feng Ruohang via AutoHotKey Script. It   |
; Provieds an enhancement towards the "Useless Key" CapsLock, and     |
; turns CapsLock into an useful function Key just like Ctrl and Alt   |
; by combining CapsLock with almost all other keys in the keyboard.   |
;                                                                     |
;Summary:                                                             |
;o----------------------o---------------------------------------------o
;|CapsLock;             | {ESC}  Especially Convient for vim user     |
;|CaspLock + `          | {CapsLock}CapsLock Switcher as a Substituent|
;|CapsLock + hjklwb     | Vim-Style Cursor Mover                      |
;|CaspLock + uiop       | Convient Home/End PageUp/PageDn             |
;|CaspLock + nm,.       | Convient Delete Controller                  |
;|CapsLock + zxcvay     | Windows-Style Editor                        |
;|CapsLock + Direction  | Mouse Move                                  |
;|CapsLock + Enter      | Mouse Click                                 |
;|CaspLock + {F1}~{F6}  | Media Volume Controller                     |
;|CapsLock + qs         | Windows & Tags Control                      |
;|CapsLock + ;'[]       | Convient Key Mapping                        |
;|CaspLock + dfert      | Frequently Used Programs (Self Defined)     |
;|CaspLock + 123456     | Dev-Hotkey for Visual Studio (Self Defined) |
;|CapsLock + 67890-=    | Shifter as Shift                            |
;-----------------------o---------------------------------------------o
;|Use it whatever and wherever you like. Hope it help                 |
;=====================================================================o
;=====================================================================o
;                       CapsLock Switcher:                           ;|
;---------------------------------o-----------------------------------o
; 已改              CapsLock + ` | {CapsLock}已改为capslock+Tab      ;|
;---------------------------------o-----------------------------------|
CapsLock & scf::                                                     ;|
GetKeyState, CapsLockState, CapsLock, T                              ;|
if CapsLockState = D                                                 ;|
    SetCapsLockState, AlwaysOff                                      ;|
else                                                                 ;|
    SetCapsLockState, AlwaysOn                                       ;|
KeyWait, scf                                                         ;|
Return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                         系统语言切换                               ;|
;---------------------------------------------------------------------o
;更换为ctrl + Space,                                                 ;|
;---------------------------------------------------------------------o
;^Space::#Space                                                       ;|
;---------------------------------------------------------------------o


;====================================================================o
;                          按键替换                                 ;|
;----------------------------------o---------------------------------o
;                        CapsLock  |  {ESC}                         ;|
;                        分号  |  单双引号互换                         ;|
;----------------------------------o---------------------------------o
CapsLock::Send, {ESC}                                              ;|
;Ralt::Rshift                                                      ;|
; SC56::Shift          ;外接键盘使用,shift旁边键                        ;|
$'::                  ;单引号替换为双引号                       ;|
if(!IME_GetConverting(nowProcess)){
    ;输入中文的状态下依旧发送单引号
    Send, {"}
}
Return
$"::Send, {'}          ;双引号替换为单引号                        ;|
;--------------------------------------------------------------------o

;====================================================================o
;                   CapsLock 方向键                                 ;|
;----------------------------------o---------------------------------o
;                     CapsLock + h |  Left                          ;|
;                     CapsLock + j |  Down                          ;|
;                     CapsLock + k |  Up                            ;|
;                     CapsLock + l |  Right                         ;|
;   这四个按键会被免于挂起                                          ;|
;----------------------------------o---------------------------------o
CapsLock & h::
Suspend,permit                                                      ;|
if GetKeyState("control") = 0                                       ;|
{                                                                   ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, {Left}                                                ;|
    else                                                            ;|
        Send, +{Left}                                               ;|
    Return                                                          ;|
}                                                                   ;|
else {                                                              ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, ^{Left}                                               ;|
    else                                                            ;|
        Send, +^{Left}                                              ;|
    Return                                                          ;|
}                                                                   ;|
Return                                                              ;|
;-----------------------------------o                               ;|
CapsLock & j::                                                      ;|
Suspend,permit                                                      ;|
if GetKeyState("control") = 0                                       ;|
{                                                                   ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, {Down}                                                ;|
    else                                                            ;|
        Send, +{Down}                                               ;|
    Return                                                          ;|
}                                                                   ;|
else {                                                              ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, ^{Down}                                               ;|
    else                                                            ;|
        Send, +^{Down}                                              ;|
    Return                                                          ;|
}                                                                   ;|
Return                                                              ;|
;-----------------------------------o                               ;|
CapsLock & k::                                                      ;|
Suspend,permit                                                      ;|
if GetKeyState("control") = 0                                       ;|
{                                                                   ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, {Up}                                                  ;|
    else                                                            ;|
        Send, +{Up}                                                 ;|
    Return                                                          ;|
}                                                                   ;|
else {                                                              ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, ^{Up}                                                 ;|
    else                                                            ;|
        Send, +^{Up}                                                ;|
    Return                                                          ;|
}                                                                   ;|
Return                                                              ;|
;-----------------------------------o                               ;|
CapsLock & l::                                                      ;|
Suspend,permit                                                      ;|
if GetKeyState("control") = 0                                       ;|
{                                                                   ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, {Right}                                               ;|
    else                                                            ;|
        Send, +{Right}                                              ;|
    Return                                                          ;|
}                                                                   ;|
else {                                                              ;|
    if GetKeyState("alt") = 0                                       ;|
        Send, ^{Right}                                              ;|
    else                                                            ;|
        Send, +^{Right}                                             ;|
    Return                                                          ;|
}                                                                   ;|
Return                                                              ;|
;--------------------------------------------------------------------o


;====================================================================o
;                     CapsLock Home/End Navigator                    ;|
;----------------------------------o---------------------------------o
;                      CapsLock + i |  Home                          ;|
;                      CapsLock + o |  End                           ;|
;                      Ctrl, Alt Compatible                          ;|
;-----------------------------------o---------------------------------o
CapsLock & i::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {Home}                                                 ;|
    else                                                             ;|
        Send, +{Home}                                                ;|
    Return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{Home}                                                ;|
    else                                                             ;|
        Send, +^{Home}                                               ;|
    Return                                                           ;|
}                                                                    ;|
Return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & o::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {End}                                                  ;|
    else                                                             ;|
        Send, +{End}                                                 ;|
    Return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{End}                                                 ;|
    else                                                             ;|
        Send, +^{End}                                                ;|
    Return                                                           ;|
}                                                                    ;|
Return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                      CapsLock Page Navigator                       ;|
;-----------------------------------o---------------------------------o
;                      CapsLock + u |  PageUp                        ;|
;                      CapsLock + p |  PageDown                      ;|
;                      Ctrl, Alt Compatible                          ;|
;----------------------------------o---------------------------------o
CapsLock & u::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {PgUp}                                                 ;|
    else                                                             ;|
        Send, +{PgUp}                                                ;|
    Return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{PgUp}                                                ;|
    else                                                             ;|
        Send, +^{PgUp}                                               ;|
    Return                                                           ;|
}                                                                    ;|
Return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & p::                                                       ;|
if GetKeyState("control") = 0                                        ;|
{                                                                    ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, {PgDn}                                                 ;|
    else                                                             ;|
        Send, +{PgDn}                                                ;|
    Return                                                           ;|
}                                                                    ;|
else {                                                               ;|
    if GetKeyState("alt") = 0                                        ;|
        Send, ^{PgDn}                                                ;|
    else                                                             ;|
        Send, +^{PgDn}                                               ;|
    Return                                                           ;|
}                                                                    ;|
Return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                     CapsLock 鼠标移动                              ;|
;-----------------------------------o---------------------------------o
;                   CapsLock + Up   |  Mouse Up                      ;|
;                   CapsLock + Down |  Mouse Down                    ;|
;                   CapsLock + Left |  Mouse Left                    ;|
;                  CapsLock + Right |  Mouse Right                   ;|
;    CapsLock + Enter(Push Release) |  Mouse Left Push(Release)      ;|
;-----------------------------------o---------------------------------o
CapsLock & Up::
    if GetKeyState("alt"){ 
       opacityControl(True)                                             ;|
    }else                                                            ;|
        MouseMove, 0, -10, 0, R                           ;|                                          ;|
    Return 
CapsLock & Down::
    if GetKeyState("alt"){
        opacityControl()
    }else{
            MouseMove, 0, 10, 0, R                            ;|
    }
    Return
CapsLock & Left::  MouseMove, -10, 0, 0, R                           ;|
CapsLock & Right:: MouseMove, 10, 0, 0, R                            ;|
;-----------------------------------o                                ;|
CapsLock & Enter::                                                   ;|
SendEvent {Blind}{LButton down}                                      ;|
KeyWait Enter                                                        ;|
SendEvent {Blind}{LButton up}                                        ;|
Return                                                               ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                           CapsLock 删除                            ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + n  |  Ctrl + Delete (Delete a Word) ;|
;                     CapsLock + m  |  Delete                        ;|
;                     CapsLock + ,  |  BackSpace                     ;|
;                     CapsLock + .  |  Ctrl + BackSpace              ;|
;-----------------------------------o---------------------------------o
CapsLock & ,:: Send, {Del}                                           ;|
CapsLock & .:: Send, ^{Del}                                          ;|
CapsLock & m:: Send, {BS}                                            ;|
CapsLock & n:: Send, ^{BS}                                           ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                            CapsLock Editor                         ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + z  |  Ctrl + z (Cancel)             ;|
;                     CapsLock + x  |  Ctrl + x (Cut)                ;|
;                     CapsLock + c  |  Ctrl + c (Copy)               ;|
;                     CapsLock + v  |  Ctrl + v (Paste)              ;|
;                     CapsLock + a  |  Ctrl + a (Select All)         ;|
;                     CapsLock + s  |  Ctrl + Tab (Swith Tag) 保存    ;|
;                     CapsLock + y  |  Ctrl + y (Yeild)              ;|
;                     CapsLock + r  |  Ctrl + Right(Move as [vim: w]);|88888888888888888888888888888888888888888888888888
;                     CapsLock + b  |  Ctrl + Left (Move as [vim: b]);|
;-----------------------------------o---------------------------------o
CapsLock & z:: Send, ^z                                              ;|
CapsLock & x:: Send, ^x                                              ;|
CapsLock & c:: Send, ^c                                              ;|
CapsLock & v:: Send, ^v                                              ;|
CapsLock & a:: Send, ^a                                              ;|
CapsLock & s:: Send, ^s                                               ;|
CapsLock & y:: Send, ^y                                              ;|
CapsLock & r:: Send, ^{Right} ;semicolon("onenote","ahk_exe ONENOTE.EXE",1)          ;|
                                                      ;|
CapsLock & b:: Send, ^{Left}                                         ;|
;---------------------------------------------------------------------o

;=====================================================================o
;                      CapsLock Window Controller                    ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + q  |  Ctrl + W   (Close Tag)        ;|
;               Alt + CapsLock + q  |  alt + f4 (Close Windows)      ;|
;                     CapsLock + g  |  AppsKey    (Menu Key)         ;|
;-----------------------------------o---------------------------------o
;-----------------------------------o                                ;|
CapsLock & w::                                                       ;|
if GetKeyState("alt") = 0                                            ;|
{                                                                    ;|
    Send, ^w                                                         ;|
}                                                                    ;|
else {                                                               ;|
    Send, !{F4}                                                      ;|
    Return                                                           ;|
}                                                                    ;|
Return   
CapsLock & q:: Send, ^{Tab}                                                      ;|
;-----------------------------------o                                ;|
CapsLock & g:: Send, {AppsKey}                                       ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                        CapsLock 自定义启动                         ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + d  |  Alt + d(Dictionary)           ;|
;                     CapsLock + f  |  Alt + f(Search listary)       ;|
;                     CapsLock + e  |  Open Search Engine            ;|
;                     CapsLock + r  |  Open Shell                    ;|
;                     CapsLock + t  |  Open Text Editor              ;|
;-----------------------------------o---------------------------------o
CapsLock & d:: 
    ; closeYoDaoAD()                   ;|
    ; WinSet, Transparent, 40, ahk_exe YodaoDict.exe
    ; Return
    runApp("词典_欧陆","eudic.exe")
    WinWaitActive, ahk_class TFormMainEudic, , 60
    ; sleep 200
    WinSet, Transparent,220,ahk_class TFormMainEudic
Return
CapsLock & f:: Send, ^g                                              ;|
; CapsLock & e::runApp("onenote","ahk_exe ONENOTE.EXE",1)
    ; IfWInExist ahk_exe ONENOTE.EXE;                                  ;|
    ;WinActivate;                                                     ;|
    ;Else;                                                            ;|
    ;Run ONENOTE.EXE;                                                 ;|
    ;Return;                                                          ;|
; CapsLock & r:: Run Powershell                                        ;|
CapsLock & t:: Run C:\Program Files\Sublime Text 3\sublime_text.exe  ;|
;---------------------------------------------------------------------o


;=====================================================================o
;                        CapsLock Char Mapping                       ;|
;-----------------------------------o---------------------------------o
;                     CapsLock + ;  |  Enter (Cancel)                ;|
;                     CapsLock + '  |  =                             ;|
;                     CapsLock + [  |  Back         (Visual Studio)  ;|
;                     CapsLock + ]  |  Goto Define  (Visual Studio)  ;|
;                     CapsLock + /  |  Comment      (Visual Studio)  ;|
;                     CapsLock + \  |  Uncomment    (Visual Studio)  ;|
;                     CapsLock + 1  |                                ;|
;                     CapsLock + 2  |                                ;|
;                     CapsLock + 3  |                                ;|
;                     CapsLock + 4  |                                ;|
;                     CapsLock + 5  |                                ;|
;                     CapsLock + 6  |  Shift + 6     ^               ;|
;                     CapsLock + 7  |  Shift + 7     &               ;|
;                     CapsLock + 8  |  Shift + 8     *               ;|
;                     CapsLock + 9  |  Shift + 9     (               ;|
;                     CapsLock + 0  |  Shift + 0     )               ;|
;-----------------------------------o---------------------------------o
CapsLock & `;:: Send, {Enter}                                        ;|
CapsLock & ':: Send, =                                               ;|
CapsLock & [:: Send, ^-                                              ;|
CapsLock & ]:: Send, {F12}                                           ;|
;-----------------------------------o                                ;|
CapsLock & /::                                                       ;|
Send, ^e                                                             ;|
Send, c                                                              ;|
Return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & \::                                                       ;|
Send, ^e                                                             ;|
Send, u                                                              ;|
Return                                                               ;|
;-----------------------------------o                                ;|
CapsLock & 1:: Run, ScreenToolkit.exe, C:\Programs\autohotkey\plugins, ;Send,+1 ;|
CapsLock & 2:: Send,+2                                               ;|
CapsLock & 3:: Send,+3                                               ;|
CapsLock & 4:: Send,+4                                               ;|
CapsLock & 5:: Send,+5                                               ;|
;-----------------------------------o                                ;|
CapsLock & 6:: Send,+6                                               ;|
CapsLock & 7:: Send,+7                                               ;|
CapsLock & 8:: Send,+8                                               ;|
CapsLock & 9:: Send,+9                                               ;|
CapsLock & 0:: Send,+0                                               ;|
;---------------------------------------------------------------------o


;=====================================================================#
;                        水平滚动-垂直滚动                           ;|
;--------------------------------------------------------------------;|
;按住capslock滚动中键达到左右滚动的目的                              ;|
;--------------------------------------------------------------------;|
 ; 向左滚动.                                                         ;|
CapsLock & WheelUp::                                                 ;|
ControlGetFocus, fcontrol, A                                         ;|
; <-- 增加这个值来加快滚动速度.                                      ;|
Loop 3                                                               ;|
    ; 0x114 是 WM_HSCROLL, 它后面的 0 是 SB_LINELEFT.                ;|
    SendMessage, 0x114, 0, 0, %fcontrol%, A                          ;|
Return                                                               ;|
;---------------------------------------------------------------------o
; 向右滚动.
CapsLock & WheelDown::
ControlGetFocus, fcontrol, A
; <-- 增加这个值来加快滚动速度.
Loop 3
; 0x114 是 WM_HSCROLL, 它后面的 1 是 SB_LINERIGHT.
    SendMessage, 0x114, 1, 0, %fcontrol%, A
Return
;--------------------------------------------------------------------;|


;=====================================================================|
;                          下拉菜单键                                ;|
;---------------------------------------------------------------------o
;鼠标右键          AppsKey    (Menu Key)  上下文菜单        	     ;|
;---------------------------------------------------------------------o
AppsKey::  ; LeftWin + AppsKey => Right-click
SendEvent {Blind}{RButton down}
KeyWait AppsKey  ; 防止键盘自动重复导致重复的鼠标点击.
SendEvent {Blind}{RButton up}
return ;Send ^{F1} Up Right
;---------------------------------------------------------------------o

;======================================================================|
;                         ONENOTEM                                   ;|
;---------------------------------------------------------------------o
;win + s    全局截图                                                 ;|
;win + n    新建笔记                                                 ;|
;---------------------------------------------------------------------o

#s::
IfWinActive, ahk_exe ONENOTE.EXE
{
    Send, Alt
    MouseGetPos, posx, posy
    MouseClick, , 107, 18, , 0
    MouseMove, posx, posy , 0
    Return
}
Else
{
    ;run C:\Program Files\Microsoft Office\Office15\ONENOTEM.EXE
    ;sleep 100
    ;;IfWinActive ahk_class Clipping Experience
    ;sleep 200
    ;Send s
    ;Send {Enter}
    ;Return
    Send, #+s
}
Return

#n::
run C:\Program Files\Microsoft Office\Office15\ONENOTEM.EXE
sleep 250
IfWinActive ahk_class Clipping Experience
Send ^0
sleep 100
Send n
Send ^9
Return
;---------------------------------------------------------------------o

; 歌曲播放
;下一曲
^!Right::
Send, {vkB0sc119}
displayToast("下一曲",,24,,"方正兰亭超细黑简体")
Return
; ^!+Right::Send, {vkB0sc119}  ;无提示
;上一曲
^!Left::
Send, {vkB1sc110}
displayToast("上一曲",,24,,"方正兰亭超细黑简体")
Return
; ^!+Left::Send, {vkB1sc110}
;暂停/播放
^!End::
Send, {vkB3sc122}
displayToast("播放/暂停",,24,,"方正兰亭超细黑简体")
Return
; ^!+End::Send, {vkB3sc122}



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 输入法, 分组, ctrl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;ctrl 特殊定义
; LCtrl 会导致无法使用组合键 ctrl+a 类似的键
$Ctrl::
;默认发送了自身
hwnd := WinExist("A")
 setIME(%hwnd%)

Return
; #IfWinActive, ahk_group g_en
; #IfWinActive


;Send, {Ctrl}
/*if(!IME_GET(%hwnd%) and IME_GetConvMode(%hwnd%) = 1024)
  {
    ;中文输入法 禁用输入法
      ;IME_SetConvMode(0x01,%hwnd%)
      ; Sleep, 500
    Send, ^{Space}
      ;displayToast( "CTRL 1中","AED900" )
      ;Return
  }
;判断当前是否为中文输入法,给予提示
if( IME_GetConvMode(%hwnd%) = 1025)
{
  displayToast( "CTRL 1中","AED900" )
}else{
  displayToast( "CTRL en","FF2B00" )
}*/

Return
; 输入法相关
    ; 两个分号后切换为中文输入法
; :*:;;::
; setEN_1(WinExist("A"))
; Send {;}
; Return;

