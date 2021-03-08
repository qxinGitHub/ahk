; 2020-11-09 快捷键分离
; 把与 csps 无关的热键分离
;

; ---------------------------------------------------------------------------- 鼠标 x1 x2
XButton1::send {Enter}
XButton2::send {BackSpace}

; ---------------------------------------------------------------------------- win  快捷键

#ESc::Send ^+{Esc} ;打开任务管理器
#F1::Gosub, candy_start_qxin        ;candy
#F4::run script\caps_关机.ahk       ;快捷关机
#t::活动窗口置顶()      ;当前活动窗口置顶
#q::WinClose, A     ; 关闭窗口
#w:: WinMaximize, A
#f::#+f     ;屏蔽win10 自动反馈, 更改为listary搜索
#s:: Send {PrintScreen}

; ---------------------------------------------------------------------------- Alt 快捷键

Alt & e:: switchToExplorer()
Alt & q::Send, ^w
Alt & w::WinMinimize, A


; ---------------------------------------------------------------------------- 媒体控制

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
Return


; ---------------------------------------------------------------------------- 单引号替换为双引号

$'::
    if(!IME_GetConverting(nowProcess)){
        ;输入中文的状态下依旧发送单引号
        Send, {"}
    }
    Return
$"::Send, {'}          ;双引号替换为单引号


; ---------------------------------------------------------------------------- 输入法切换 ctrl

; LCtrl 会导致无法使用组合键 ctrl+a 类似的键
$Ctrl::
    ; 在pr中屏蔽该快捷键
    ; MsgBox, an
    IfWinActive ahk_exe Adobe Premiere Pro.exe
    {
        return
    }
    ;默认发送了自身
    hwnd := WinExist("A")
    setIME(%hwnd%)
Return

; ----------------------------------------------------------------------------  Claunch启动 F1
; ctrl + win + alt + j    ahk：f1
F1::
    IfWinActive ahk_exe CLaunch.exe
    {
        Send, {esc}
        Return
    }
    IfWinActive ahk_exe Photoshop.exe
    {
        Return
    }
    IfWinActive ahk_exe Adobe Premiere Pro.exe
    {
        run %A_ScriptDir%\script\caps_pr.ahk
        return
    }
    IfWinActive ahk_exe ONENOTE.EXE
    {
        Send, ^#!j
        Sleep, 50
        Send, {3}
        Return
    }
    Send, ^#!j
    Sleep, 100
Return

; ---------------------------------------------------------------------------- 小键盘提示
Numlock::
GetKeyState, NumlockState, Numlock, T
    if (NumlockState = "D"){
        SetNumLockState , AlwaysOff
        displayToast("小键盘 快捷键","f00",24)
    }else{
        SetNumLockState , AlwaysOn
        displayToast("小键盘 数字","0f0",24)
    }
    KeyWait, scf
Return

; ---------------------------------------------------------------------------- 主键盘数字
;  主键盘数字与上面的字符相替换
    ;放在脚本后面会失效，所以放到了最前面
#If, NUMLK
    $1::+1
    $+1::Send, 1
    $2::+2
    $+2::Send, 2
    $3::+3
    $+3::send,{3}
    $4::+4
    $+4::send,{4}
    $5::+5
    $+5::send,{5}
    $6::+6
    $+6::send,{6}
    $7::+7
    $+7::send,{7}
    $8::+8
    $+8::send,{8}
    $9::+9
    $+9::send,{9}
#If