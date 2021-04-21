
;=====================================================================;
;=====================================================================;
;                           软件改造
;=====================================================================;
;=====================================================================;


;系统
;=====================================================================o
;                           资源管理器                               ;|
;----------------------------------o---------------------------------o
;资源管理器中实现鼠标中键后退                                        ;|
;---------------------------------------------------------------------;
; #IfWinActive ahk_class CabinetWClass
; $MButton::
;   WinGetClass,sClass,A
;   ;;MsgBox $%sClass%$
;   if (sClass="CabinetWClass") {
;     Send, {BS}
;   }
;   Return
; #IfWinActive

;=====================================================================o
;                        任务栏音量控制                              ;|
;-----------------------------------o---------------------------------o
;任务栏中滚动鼠标中键,实现音量加减,按下为静音                        ;|
;--------------------------------------------------------------------;|
; #If (MouseIsOver("ahk_class Shell_TrayWnd")||MouseIsOver("ahk_class Shell_SecondaryTrayWnd"))
; WheelUp::Send {Volume_Up}
; WheelDown::Send {Volume_Down}
; MButton::Send,{Volume_Mute}
; #If 

; MouseIsOver(WinTitle) {
;     MouseGetPos,,, Win
; 	; ToolTip, %WinTitle%
;     return WinExist(WinTitle . " ahk_id " . Win)
; }


;---------------------------------------------------------------------o

;=====================================================================o
;                           任务视图                                 ;|
;-------------------------------o------------------------------------o
;h j k l 快捷移动  ; 回车  m 关闭                                    ;|
;--------------------------------------------------------------------;|
#IfWinActive ahk_class MultitaskingViewFrame
  h::Up
  j::Right
  k::Left
  l::Down
  `;::Enter
  m::Send, ^w
  Return
#IfWinActive
;---------------------------------------------------------------------o



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;用户软件;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; ONENOTE -----------------------------------------                ONENOTE

#IfWinActive, ahk_exe ONENOTE.EXE
; 数字0  清除样式 
NumpadIns:: Send ^+n
; 数字1   一级标题
NumpadEnd:: run, %A_ScriptDir%\script\onenote\快捷键 一级标题.ahk
; 数字2   二级标题
NumpadDown:: run, %A_ScriptDir%\script\onenote\快捷键 二级标题.ahk
; 数字3   三级标题
NumpadPgDn:: run, %A_ScriptDir%\script\onenote\快捷键 三级标题.ahk
; 数字4   红色
NumpadLeft:: run, %A_ScriptDir%\script\onenote\快捷键 字体红色.ahk
; 数字5   绿色
NumpadClear:: run, %A_ScriptDir%\script\onenote\快捷键 字体绿色.ahk
; 数字6   金色
NumpadRight:: run, %A_ScriptDir%\script\onenote\快捷键 字体金色.ahk
; 数字7   紫色
NumpadHome:: run, %A_ScriptDir%\script\onenote\快捷键 字体紫色.ahk

#IfWinActive



;=====================================================================o
;                          PR 剪辑                                 |
;-------------------------------o-------------------------------------o
; 单独提取出来脚本 pr按钮.ahk







;=====================================================================o
;                           PS                                 ;|
;-------------------------------o------------------------------------o
;                                   ;|
;--------------------------------------------------------------------;|
#IfWinActive ahk_exe Photoshop.exe
  XButton1::send {Enter}
  XButton2::send {Delete}
  Return


  ; 填充
  F1::
    Send, +{F5}
  Return

  ; 盖印图层
  F5::
    Send, ^+!{e}
  Return

  ; 新建通过拷贝的图层
  F6::
    Send, ^{j}
  Return

  ; 液化
  F7::
    Send, +^{x}
  Return

  ; camera raw 滤镜
  F8::
    Send, +^{a}
  Return


  ; 磨皮滤镜
  F9::
    MouseClick, , 354, 20
    MouseClick, , 390, 482
    MouseClick, , 630, 482

    WinWaitActive  ahk_class #32770    ;磨皮组件
    Sleep, 2000
    MouseClick, , 855, 60    ;确定按钮
    Sleep, 5000
    ; MsgBox, % A_Cursor
    ;  Sleep, 3000
    ; MsgBox, % A_Cursor
    ; A_Cursor Wait
    ; while (A_Cursor="Wait")
    ; {
    ;  Sleep, 300
    ; }
    MouseClick, , 1760, 757
  Return

  ; F12::
    Send, {F4}
    Sleep, 1000
    Send, {F5}

    ; 等待 cmmera raw 窗口
    WinWaitActive  ahk_class PSFilter_WindowClass

    Sleep, 500

    ; 使用上一次调色
    MouseGetPos, posx, posy
    MouseClick, , 1150, 243
    Sleep, 300
    MouseClick, , 1179, 315
    ; Sleep, 1000
    ; Send, Enter
    ; MouseMove, posx, posy, 0

    Sleep, 300
    ; 关闭调色窗口
    MouseClick, , 1111, 1120

    WinWaitActive  ahk_class Photoshop
    Sleep, 300
    ; 液化窗口
    Send, {F3}
    ; 等待 cmmera raw 窗口
    WinWaitActive  ahk_class PSFilter_WindowClass
    Sleep, 300
    MouseClick, , 1766, 292
    Send, {a}
  Return

#IfWinActive

  ; ps CRaw 界面
#IfWinActive ahk_class PSFilter_WindowClass
  F11::
    MouseGetPos, posx, posy
    MouseClick, , 1150, 243
    Sleep, 300
    MouseClick, , 1179, 315
    ; Sleep, 1000
    ; Send, Enter
    MouseMove, posx, posy, 0
  Return
#IfWinActive


;---------------------------------------------------------------------o




;=====================================================================o
;                          PR 剪辑                                 |
;-------------------------------o-------------------------------------o
; 单独提取出来脚本 pr按钮.ahk




;=====================================================================o
;                          网易云音乐                                 |
;-------------------------------o-------------------------------------o
;鼠标手势，后划，实现后退功能
#IfWinActive,ahk_exe cloudmusic.exe
  ^!#9::
  MouseGetPos, posx, posy
  ;官方推荐使用 click ，相比于 MouseClick 更加简单易用，但此处需要将速度设为0，故用 MouseClick
  ;click 204,26
  ; 具体坐标视版本而定
  MouseClick, , 239, 30, , 0
  MouseMove, posx, posy, 0
  Return

  ^!#0::
  MouseGetPos, posx, posy
  ;click 231,26
  MouseClick, , 273, 26, , 0
  MouseMove, posx, posy, 0
  Return
#IfWinActive
;---------------------------------------------------------------------o



;=====================================================================o
;                          剪贴板 ClipX                               |
;-------------------------------o-------------------------------------o
;历史记录面板的快捷键
#IfWinActive,ahk_exe clipx.exe
  j::Down
  k::Up
  1::
  MouseGetPos, posx, posy
  MouseClick, , 45, 75, 2, 0
  MouseMove, posx, posy, 0
  Return
  2::
  MouseGetPos, posx, posy
  MouseClick, , 45, 90, 2, 0
  MouseMove, posx, posy, 0
  Return
  3::
  MouseGetPos, posx, posy
  MouseClick, , 45, 103, 2, 0
  MouseMove, posx, posy, 0
  Return
  4::
  MouseGetPos, posx, posy
  MouseClick, , 45, 114, 2, 0
  MouseMove, posx, posy, 0
  Return
  5::
  MouseGetPos, posx, posy
  MouseClick, , 45, 129, 2, 0
  MouseMove, posx, posy, 0
  Return
  6::
  MouseGetPos, posx, posy
  MouseClick, , 45, 141, 2, 0
  MouseMove, posx, posy, 0
  Return
  7::
  MouseGetPos, posx, posy
  MouseClick, , 45, 154, 2, 0
  MouseMove, posx, posy, 0
  Return
  8::
  MouseGetPos, posx, posy
  MouseClick, , 45, 167, 2, 0
  MouseMove, posx, posy, 0
  Return
  9::
  MouseGetPos, posx, posy
  MouseClick, , 45, 182, 2, 0
  MouseMove, posx, posy, 0
  Return
  0::
  MouseGetPos, posx, posy
  MouseClick, , 450, 340, 2, 0
  MouseMove, posx, posy, 0
Return
#IfWinActive
;---------------------------------------------------------------------o

;=====================================================================o
;                           朗文词典                                 ;|
;-------------------------------o------------------------------------o
;;;;;;;;;;;;;;;;;;
;朗文当代高级英语词典第4版:英英·英汉双解(光盘版).LDOCE4zh
;,无快捷键,按钮小,错误提示回车键无法关闭,滚轮无法进行文本滚动
;已知问题:在此窗口激活时,主脚本的键盘移动鼠标失效.合并后已解决
;滚轮与音量调节冲突
;方案：
;上下方向键,鼠标滚轮 : 上下滚动文本
;左右方向键 : 搜索历史前进后退
;home,end键 : 主页,发音
;+,-(加减号,指-=) : 增删书签,删书签时自动确定
;Enter : 关闭单词未找到的错误提示
; Alt + F4 关闭窗口
#IfWinActive,ahk_class ImlWinCls
  ;上下方向键,鼠标滚轮
  ;WheelDown:
  Down::
  Click 790,580
  Return
  ;WheelUp:
  Up::
  Click 790,120
  Return
  ;左右方向键
  Left::Click 720,80
  Right::Click 760,80
  ;home NewSearch搜索  end键 发音
  Home::
  NumpadHome::
  Click 410,77
  Return
  NumpadEnd::
  End::Click 525,80
  Return
  ;+-(加减号),增删书签
  =::
  NumpadAdd::
  Click 490,38
  Return
  -::
  NumpadSub::
  Click 716,46
  Click 350,340
  Return
  ;当出现错误提示时,让回车恢复该有的作用
  Enter::
  ;错误提示的颜色标识
  PixelGetColor,lwcolor,272,270,RGB
  IfEqual,lwcolor,0xFFCE00
  Click 400,345
  Else
  Send {Enter}
  Return
  Pgup::
  NumpadPgUp::
  Send {Up}
  Return
  PgDn::
  NumpadPgDn::
  Send {Down}
  Return
  !F4::Click 786,11
  Return
#IfWinActive
;---------------------------------------------------------------------o



;=====================================================================o
;                        Unreal Commander                            ;|
;-------------------------------o------------------------------------o

;;;;;;;;;;;;;Unreal Commander
;已解决：删--在打开驱动器列表或其他非主窗口的时候,进入收藏夹时,鼠标会点飞,可以通过让主窗口 WinActive 解决
;已解决：h 若打开的是无法预览的目标,文件夹或路径,会出现错误窗口提示,若使用空格关闭会导致进入到 insert 模式
; ahk_class #32770 有毒
;拥有 vim 的个别功能
; vim : j, k,方向; y,p,粘贴复制
; i 编辑键, 未按 i 之前, 方向键与 i 无法打字
;F1, o(字母) 进入收藏夹
; m 删除,n 新建文件,l,后退,u,驱动器列表,<,>(逗号,句号)PgUp,PgDn,文件过多时,方便翻页, '(单引号)，Tab键
; h 发送F3,预览窗口激活的情况下,点击发送 Esc
#IfWinActive,ahk_group g_UNCOM
i::Suspend,On  ; 给一个热键指定挂起的开关功能。

CapsLock::
Suspend,Off
Send,{Esc}
Return

Esc::
Suspend,Off
Send,{Esc}
Return

Enter::
Suspend,Off
Send,{Enter}
Return

F2::
Suspend,On
Send,{F2}
Return
;以上按键均带有将热键开启或关闭的选项
o::
F1::
WinActivate,ahk_class TxUNCOM
Click 1066,149        ;1064,182,大图标,小图标(现在)区别,
Return
h::F3
j::Down
k::Up
y::^c
p::^v
m::Delete
n::+F4
l::BackSpace
u::!f2
,::PgUp
.::PgDn
'::Tab
`;::Enter
Return
#IfWinActive
; Uncom、 Winrar 的查看器均会使用该设置
; uncom 内部查看器的相关快捷键
; 虽然可以按 i 进入 Insert， 但功能不完善
#IfWinActive,ahk_class TFormViewUV.UnicodeClass
CapsLock::
Suspend,Off
Send,{Esc}
Return
Esc::
Suspend,Off
Send,{Esc}
Return
i::Suspend,On
;;; 以上为挂起相关设置

h::Esc
j::Down
k::Up
y::^c
p::^v
m::Delete
,::PgUp
.::PgDn
Return
#IfWinActive
;---------------------------------------------------------------------o



;=====================================================================o
;                       XMind思维导图                                ;|
;-------------------------------o------------------------------------o
;;;;;;;;;;;;;;;;XMind思维导图
;已知缺陷:2016年1月21日,在备注和注释中,点击回车会回到h,j,k,l方向键,需要按i进入编辑

; caps 键需要配合 caps + h,j,k,l 来移动,故在此软件中无 ESC 效果
;增加一些按键操作,26个按键用来打字,着实浪费
#IfWinActive,ahk_class SWT_Window0
~F4::Suspend,On
~Space::Suspend,On
i::Suspend,On   ;此处可只保留最后一个 Suspend,On
;~Enter::Suspend,Off
~Esc::Suspend,Off
;~CapsLock::
;Suspend,Off
;Send,{Esc}


h::Left
j::Down
k::Up
l::Right
y::^c
p::^v
`;::Enter
m::Delete
Return
#IfWinActive
; 下面的两个设置均未按照预期的工作
#IfWinActive,ahk_exe XMind.exe  ; XMind 主窗口
~Enter::Suspend,Off
Return
#IfWinActive
#IfWinActive,ahk_class #32770   ; XMind 批注,备注窗口
~Enter::Suspend,On
Return
#IfWinActive
;---------------------------------------------------------------------o




;=====================================================================o
;                          IDM 下载                                  ;|
;-------------------------------o------------------------------------o
;;;  IDM 下载
;以 Unreal Commander 为原型制作的快捷键，删除大部分用不到的
; n 为添加任务，保留的按键功能未变
;
#IfWinActive,Internet Download Manager 6.25
i::Suspend,On  ; 给一个热键指定挂起的开关功能。
CapsLock::
Suspend,Off
Send,{Esc}
Return

Esc::
Suspend,Off
Send,{Esc}
Return

Enter::
Suspend,Off
Send,{Enter}
Return
;;;以上按键均带有将热键开启或关闭的选项;;;

j::Down
k::Up
m::Delete
y::^c
p::^v
n::
Click 42,81
Return
,::PgUp
.::PgDn
'::Tab
`;::Enter
Return
#IfWinActive
;---------------------------------------------------------------------o


;=====================================================================o
;                        WinRAR 压缩管理                             ;|
;-------------------------------o------------------------------------o
;;;  WinRAR 压缩管理  ;;;

#IfWinActive,ahk_class WinRarWindow
i::Suspend,On  ; 给一个热键指定挂起的开关功能。
CapsLock::
Suspend,Off
Send,{Esc}
Return

Esc::
Suspend,Off
Send,{Esc}
Return

Enter::
Suspend,Off
Send,{Enter}
Return

F2::
Suspend,On
Send,{F2}
Return
;以上按键均带有将热键开启或关闭的选项

o::Send {Alt}o
;h::F3
j::Down
k::Up
y::^c
p::^v
m::Delete
;n::+F4
l::BackSpace
;u::!f2
,::PgUp
.::PgDn
'::Tab
`;::Enter
Return
#IfWinActive
;---------------------------------------------------------------------o



;=====================================================================o
;                           有道词典                                 ;|
;----------------------------------o---------------------------------o
;发音                                        ;|
;---------------------------------------------------------------------;
#IfWinActive, ahk_exe YodaoDict.exe
CapsLock::
Esc::
Send, {Esc}
MouseClick, , 462, 68, 2, 0
;美式发音
F1::
ImageSearch, OutputVarX, OutputVarY, 250, 156, 340, 176, C:\Programs\autohotkey\caps\plugins\img\YodaoDict_1.bmp
;MsgBox, [ Options, Title, Text, Timeout]
if(!ErrorLevel){
  MouseMove, OutputVarX+10, OutputVarY+10
  ; MouseMove, OutputVarX+10, OutputVarY+20
}
Click
Return
Return
;全球发音
F2::
ImageSearch, VarX, VarY, 260, 156, 480, 176, C:\Programs\autohotkey\caps\plugins\img\YodaoDict_3.bmp
if(!ErrorLevel){
  MouseClick, ,VarX-18, VarY+8
}
;Click 384,165
Sleep, 500
;Click 126,284
MouseClick, ,126,284
Return
;全球发音 第二个
F3::click 128, 318
Return
#IfWinActive


;=====================================================================o
;                          欧陆词典                                 ;|
;----------------------------------o---------------------------------o
;发音                              eudic.exe                       ;|
;---------------------------------------------------------------------;
#IfWinActive, ahk_exe eudic.exe
F1::
; 获取现在的鼠标位置
MouseGetPos, posx, posy
ImageSearch, OutputVarX, OutputVarY, 220, 90, 740, 432,*100 C:\Programs\autohotkey\caps\plugins\img\eudic.png
;MsgBox, [ Options, Title, Text, Timeout]
if(!ErrorLevel){
  MouseMove, OutputVarX+10, OutputVarY+10
}
Click
MouseMove, posx, posy, 0
Return
#IfWinActive
