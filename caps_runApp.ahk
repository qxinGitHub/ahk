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
            WinActivate
            Else
            Run %program%%arg%
        }
        Else
            Run %program%%arg%
    }
}

; ?  即使此热字串在另一个单词中也会被触发;
; *  不需要终止符 (即空格, 句点或回车) 来触发热字串.

;计算器
:?:`;c::
:*:`;calc::
runApp("calc","计算器",1)
;未改动之前的版本 ↓
;IfWinExist,计算器
;WinActivate
;Else
;Run calc
;...............  ↑
Return

;sublime_text
:?:`;t::
runApp("编辑_sublime_text")
Return

; python3 idle 3.5.1
:?:`;p::
runApp("编程_idle","Python 3.5.1 Shell")
Return

;英语词典 : 朗文、有道词典、欧陆词典
;默认使用:朗文当代高级英语辞典(英英·英汉双解)(第四版)
; :?:`;d::
; Run %shortcuts%词典_欧陆
;Return

:?:`;dict::
runApp("词典_dict","ImlWinCls")
Return

:?:`;d::
; runApp("词典_YodaoDict","有道词典");
runApp("词典_欧陆","eudic.exe")
WinWaitActive, ahk_class TFormMainEudic, , 60
; sleep 200
WinSet, Transparent,210,ahk_class TFormMainEudic
Return

;音乐 : AIMP、 网易云音乐
;默认使用: AIMP
:?:`;m::
:?:`;music::
runApp("影音_AIMP","TAIMPMainForm")
Return

; mm 网易云音乐
:?:`;mm::
runApp("影音_网易云音乐","ahk_exe cloudmusic.exe")
Return

; pot potplayer
:?:`;pot::
runApp("影音_pot","PotPlayer64")
Return


;其他快捷
;下载
; xl  迅雷
:?:`;xl::
runApp("下载_迅雷")
Return
; idm  idm
:?:`;idm::
runApp("下载_idm")
Return

;QQ拼音符号输入器
;参数传入失败,所以用不同参数创建了两个快捷方式
:?:`;zf::
runApp("QQPYFace")
Sleep, 100
WinActivate, ahk_exe QQPYFace.exe
Return
; ::`;bq::
; runApp("QQ拼音表情")
; Return

; mind XMind 思维导图
:?:`;mind::
runApp("工具_XMind 7","ahk_exe XMind.exe")
Return

; Registry Workshop 注册表编辑工具
:?:`;regist::
runApp("工具_regist","RegWorkshopX64.exe")
Return


;Unreal Commander
;#e::
;::`;e::
;runApp("Unreal Commander","ahk_class TxUNCOM")
;Return
;---------------------------------------------------------------------o

:?:`;ps::
runApp("ps","ahk_exe Photoshop.exe")
Return

:?:`;q::
:?:`;qq::
runApp("TIM","ahk_class TXGuiFoundation")
Return

; 浏览器
:?:`;b::
:*:`;browser::
:?:`;chrome::
runApp("chrome","ahk_exe chrome.exe")
Return
:?:`;ie::
runApp("ie","ahk_exe iexplore.exe")
Return

; oneNote
:?:`;o::
:?:`;onenote::
runApp("onenote","ahk_exe ONENOTE.EXE")
Return

; github
:?:`;g::
:?:`;github::
runApp("GitHub","ahk_exe GitHub.exe")
Return