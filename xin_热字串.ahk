;
;                        自定义快捷键,快速输入
;   2017.02.16： 日后的热字符串尽量用反斜杠开头，减少冲突


; ---------------------------------------------------------------------------- 临时
::/-::
    sendbyclip("; ----------------------------------------------------------------------------",,,1)
    Return
::/-1::
    sendbyclip("; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -")
    Return
;中文字符转换为英
::a@::admin@mail.com
; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -



; ---------------------------------------------------------------------------- WEB
; <!-- -->      html 注释,光标移动到中间
::<!::
    sendbyclip("<!---->",3)
    Return
; console.log()
:*:/cl::
    sendbyclip("console.log()",1)
    Return

; ---------------------------------------------------------------------------- Python
; # -*- coding:utf-8 -*-      python utf-8标识
:*:/u8::
    sendbyclip("# -*- coding:utf-8 -*- ")
    Return
; print()
::/pt::
    Send print (){left}
    Return
::/pt'::
    Send print (""){left 2}
    Return
::/p3::
    sendbyclip("python3",,,1)Return
::/p2::
    sendbyclip("python2",,,1)
    Return

; ---------------------------------------------------------------------------- 个人使用
;  mail
::/m::
:*:/ml::
    sendbyclip("qxguge@gmail.com")
    Return
:*:/wml::
    sendbyclip("wqxwangyi@163.com")
    Return
; 身份证
; ::/id::
;     sendbyclip("")
;     Return
; 手机号
::/p::
    ; sendbyclip("18773822412")
    sendbyclip("150203096")
    Return

