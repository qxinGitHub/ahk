;=====================================================================o
;                        自定义快捷键,快速输入                       ;|
;-----------------------------------o---------------------------------o
;	utf-8  html 注释快捷键 等其他                                    ;|
;   续:为了适配中文输入法又改回去了 悲,,,,                           ;|
;   只能借助剪贴板的形式,直接发送会导致在中文输入法输出中文来        ;|
;   使用剪贴板会干扰正常的剪贴板,可以先将剪贴板的内容存入变量来解决  ;|
;   2017.02.16： 日后的热字符串尽量用反斜杠开头，减少冲突        ;|
;--------------------------------------------------------------------;|
;    ~~~~~~~~ u8       # -*- coding:utf-8 -*-      python utf-8标识  ;|
:*:/u8::                                                               ;|
; text = # -*- coding:utf-8 -*-                                        ;|
; clipboard = %text%                                                   ;|
; Send ^v  # -*                                                             ;|
sendbyclip("# -*- coding:utf-8 -*- ")                                                 ;|
Return 
                                                              ;|
;    ~~~~~~~~ <!      <!-- -->      html 注释,光标移动到中间         ;|
::<!::                                                               ;|
; text = <!---->                                                       ;|
; clipboard = %text%                                                   ;|
sendbyclip("<!---->")                                                 ;|
Send {left 3}         ;向左移动鼠标                                ;|
Return 
                                                              ;|
;   ~~~~~~~~~ print()    hello world! py3也可以愉快的 hello world 了 ;|
::/pt::                                                               ;|
Send print (){left}                                                  ;|
Return                                                               ;|
::/pt'::                                                              ;|
Send print (""){left 2}                                              ;|
Return 

;;~~~~~~~~~~~~~ console.log()
:*:/cl::
sendbyclip("console.log()")                                   ;|
Send {Left}
Return

;   ~~~~~~~~~~~ mail                                                 ;|
:*:/wml::                                                              ;|                                       ;|
; send ^v                                                              ;|
sendbyclip("新年好啊,新年好")                                     ;|
Return  
:*:/ml::
sendbyclip("大家新年好")                                     ;|
Return                                                           ;|
;~~~~~~~~~~~~~~~  python2 python3
;此处的 O0 纯属找刺激,意为将结束字符也显示出来
;续:刺激寻求失败 该脚本里所有的结束字符都将显示出来
;再续:所有热字符串均需要加 O 才会和以前一样,之前的默认呢,,,,⊙﹏⊙‖∣
;继续:回到最初了     ▄︻┻═┳一    Orz
;:O0:p3:: python3                                                    ;|
::/p3::                                                               ;|
; text = python3                                                       ;|
; clipboard = %text%                                                   ;|
; Send ^v{space}
sendbyclip("python3",,1)                                                 ;|
Return                                                               ;|
::/p2::                                                               ;|
; text = python2                                                       ;|
; clipboard = %text%                                                   ;|
; Send ^v{space}
sendbyclip("python2",,1)                                               ;|
Return                                                               ;|
;中文字符转换为英
::a@::admin@mail.com
Return
;---------------------------------------------------------------------o

;----------身份证
::/id::
sendbyclip("啦啦啦,啦啦啦")                                     ;|
Return
;----------手机号
:*:/p::
sendbyclip("我是卖报的小行家")
Return

;------------- 百度
; :*:/bd::
; sendbyclip("www.baidu.com")
; Return
:*:/sbd::
sendbyclip("https://www.baidu.com")
Return
;------------- 谷歌 google
:*:/gg::
sendbyclip("www.google.com")
Return
:*:/sgg::
sendbyclip("https://www.google.com")
Return

:*://::
sendbyclip("//")
Return

:*:;;::
hwnd := WinExist("A")
 setIME(%hwnd%)
Return


