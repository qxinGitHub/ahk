/*
; 开始在其他脚本中出现 不再单独为分号快捷启动服务 更名为 runApp
; 绝大多数直接用系统自带的 run 就可以了
;=====================================================================o
;                         分号快捷启动                               ;|
;-------------------------------o------------------------------------o
;;;;;;;;;;;;;;;分号快捷启动;
;2016年1月16日 15:38:17
;使用 ; (分号)进行快捷启动,热字符串的使用 Hostring
; 解决:无法传入运行参数(2016-01-21 11:23:45) -2017-03-03 17:47:36
;runApp(program,title:="",cmd:=0,arg:=""),四个参数,包括三个可选参数
;参数
    ;program
        ;需要运行程序的名称,若为完整路径,需将 cmd 设为1
    ;title 可选,默认为空
        ; 运行程序窗口的标题或部分标题,防止程序多开,当检测到该程序已在后台运行,前
        ; 台显示.也可以是 窗口类 ahk_class 确切的类名,或窗口组 ahk_group GroupName
        ; 等其他 ahk WInTitle 匹配方式
    ; cmd 可选,默认为0
        ;若为1从系统环境变量中执行,等同命令 '运行'否则从自定义路径(% shortcuts . ) 中执行,
    ; arg 可选, 默认为空
        ; 运行程序的参数
;改变热字符串的结尾字符(下列回车与 Tab 之间有空格结尾字符)
;#Hotstring EndChars -()[]{}':;"/\,.?!`n `t
;自定义的快捷方式文件夹
;shortcuts = C:\shortcuts\;
*/
runApp(program,title:="",cmd:=0,arg:="")
{
    displayToast(program)
    RunAs, qxin, % info_winPassword 
    ;判断是否需要从环境变量中运行
    If !cmd
    {
        Global shortcuts
        ;判断进程是否已经打开
        If title
        {
            IfWinExist, %title%
            WinActivate
            Else
            Run %shortcuts%%program%%arg%
        }
        Else
            Run %shortcuts%%program%%arg%
    }
    Else
    {
        If title
        {
            IfWinExist,%title%
            WinActivate   ;WinRestore ;
            Else
            Run %program%%arg%
        }
        Else
            Run %program%%arg%
    }
    RunAs
}

; ?  即使此热字串在另一个单词中也会被触发;
; *  不需要终止符 (即空格, 句点或回车) 来触发热字串.

; ---------------------------------------------------------------------------- 日用软件
;计算器
:?:`;c::
:*:`;calc::
    runApp("calc","计算器",1)
Return
; 日历
:?:`;r::
:*:`;rl::
    runApp("日历")
Return
; todo
:?:`;td::
:*:`;todo::
    runApp("Microsoft To Do")
Return
:?:`;e::
:*:`;explore::
    Send, #e
Return
; idm  idm
:?:`;d::
:?:`;idm::
    runApp("Internet Download Manager")
Return
; 浏览器
:?:`;b::
:*:`;browser::
runApp("Microsoft Edge","ahk_exe msedge.exe")
Return
; 远程桌面
:?:`;nas::
    runApp("Default.rdp","ahk_exe mstsc.exe")
Return

; ---------------------------------------------------------------------------- 影音娱乐
;音乐 :  网易云音乐
:?:`;m::
:*:`;music::
    runApp("网易云音乐","ahk_exe cloudmusic.exe")
Return
; pot potplayer
:?:`;pot::
    runApp("PotPlayer 64 bit","PotPlayer64")
Return
; QQ
:?:`;qq::
    runApp("腾讯QQ","ahk_exe QQ.exe")
Return
:?:`;wx::
:*:`;wechat::
    runApp("微信")
Return

; ---------------------------------------------------------------------------- 学习
; mind XMind 思维导图
:?:`;x::
:?:`;mind::
    runApp("XMind","ahk_exe XMind.exe")
Return
; oneNote
:?:`;o::
:*:`;onenote::
    runApp("onenote","ahk_exe ONENOTE.EXE")
Return

; ---------------------------------------------------------------------------- 工作
; PS
:?:`;ps::
    runApp("Adobe Photoshop 2020","ahk_exe Photoshop.exe")
Return
:?:`;pr::
    runApp("Adobe Premiere Pro 2020","ahk_exe Adobe Premiere Pro.exe")
Return
:?:`;me::
    runApp("Adobe Media Encoder 2020","ahk_exe Adobe Media Encoder.exe")
Return
:?:`;ones::
    runApp("ONES")
Return


; ---------------------------------------------------------------------------- 编程软件
;sublime_text
:?:`;t::
:*:`;vscode::
runApp("vscode","ahk_exe Code.exe")
Return
; python3 idle 3.5.1
:?:`;p::
runApp("编程_idle","Python 3.5.1 Shell")
Return
:?:`;chrome::
runApp("chrome","ahk_exe chrome.exe")
Return
:?:`;ie::
runApp("ie","ahk_exe iexplore.exe")
Return
; github
:?:`;g::
:*:`;github::
runApp("GitHub","ahk_exe GitHub.exe")
Return


; ---------------------------------------------------------------------------- 其他快捷
; Registry Workshop 注册表编辑工具
:?:`;regist::
runApp("RegWorkshopX64","RegWorkshopX64.exe")
Return


; ---------------------------------------------------------------------------- 非快捷键，但是用分号触发
; 最小化
:?:`;w::
    displayToast("最小化")
    WinMinimize, A
Return
; 关闭标签页
:?:`;q::
    displayToast("关闭标签页")
    Send, ^w
Return
; 关闭软件;q
:?:`;quit::
    displayToast("关闭应用")
    Send, !{F4}
Return
