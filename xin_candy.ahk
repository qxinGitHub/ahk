; candy_lite
; 改自妖的 candy ,使其更轻量

candy_start_qxin:
    Gosub Label_Candy_Start
    Gosub extension
    Return

; 进制转换
; 十进制 十六进制转换
hex2dec(h)
{
SetFormat, integer, dec
d :=h+0
return %d% 
} 
;十进制转换为十六进制的函数，参数为10进制数整数.
dec2hex(d)
{
SetFormat, integer, hex
h :=d+0
SetFormat, integer, dec ;恢复至正常的10进制计算习惯
h := substr(h,3)  ; 去掉十六进制前面的 ox
return h
}

; candy Lite  candy轻量版  快捷菜单
Label_Candy_Start:
    MouseGetPos,,,Candy_CurWin_id         ;当前鼠标下的进程ID
    WinGet, Candy_CurWin_Fullpath,ProcessPath,Ahk_ID %Candy_CurWin_id%    ;当前进程的路径
    WinGetTitle, Candy_Title,Ahk_ID %Candy_CurWin_id%    ;当前进程的标题
    Candy_Saved_ClipBoard := ClipboardAll
    Clipboard =
    Send ^c
    ClipWait,0.5
    Send, {Ctrl Up}   ; 在 edge 浏览器中 会出现 ctrl 没有释放的情况
    If ( ErrorLevel  )          ;如果没有选择到什么东西，则退出
    {
        Clipboard := Candy_Saved_ClipBoard    ;还原粘贴板
        Candy_Saved_ClipBoard =
        Return
    }
    Candy_isFile := DllCall("IsClipboardFormatAvailable", "UInt", 15)   ;是否是文件类型
    Candy_isHtml := DllCall("RegisterClipboardFormat", "str", "HTML Format")  ;是否Html类型
    CandySel=%Clipboard%
    CandySel_Rich:=ClipboardAll
    Clipboard := Candy_Saved_ClipBoard  ;还原粘贴板
    Candy_Saved_ClipBoard = 

    If(Fileexist(CandySel) && RegExMatch(CandySel,"^(\\\\|.:\\)")) ;文件或者文件夹,不再支持相对路径的文件路径,但容许“文字模式的全路径”
    {
        Candy_isFile:=1     ;如果是“文字型”的有效路径，强制认定为文件
        SplitPath,CandySel,CandySel_FileNameWithExt,CandySel_ParentPath,CandySel_Ext,CandySel_FileNameNoExt,CandySel_Drive
        SplitPath,CandySel_ParentPath,CandySel_ParentName,,,, ;用这个提取“所在文件夹名”
        If InStr(FileExist(CandySel), "D")  ;区分是否文件夹,Attrib= D ,则是文件夹
        {
            CandySel_FileNameNoExt:=CandySel_FileNameWithExt
            CandySel_Ext:=RegExMatch(CandySel,"^.:\\$") ? "Drive":"Folder"  ;细分：盘符或者文件夹
        }
        Else  If (CandySel_Ext="")       ;若不是文件夹，且无后缀，则定义为NoExt
        {
            CandySel_Ext:="NoExt"
        }
        if (CandySel_ParentName="")
            CandySel_ParentName:=RTrim(CandySel_Drive,":")
    }
    Else if(instr(CandySel,"`n") And  Candy_isFile=1)  ;如果包含多行，且粘贴板性质为文件，则是“多文件”
    {
        CandySel_Ext:="MultiFiles" ;多文件的后缀=MultiFiles
        CandySel_FirstFile:=RegExReplace(CandySel,"(.*)\r.*","$1")  ;取第一行
        SplitPath ,CandySel_FirstFile,,CandySel_ParentPath,,  ;以第一行的父目录为“多文件的父目录”
        If RegExMatch(CandySel_ParentPath,"\:(|\\)$")  ;如果父目录是磁盘根目录,用盘符做父目录名。
            CandySel_ParentName:= RTrim(CandySel_ParentPath,":")
        else  ;否则，提取父目录名
            CandySel_ParentName:= RegExReplace(CandySel_ParentPath, ".*\\(.*)$", "$1")
    }
    Else     ;文本类型
    {
        CandySel_Ext:=StrLen(CandySel) < 80 ? "ShortText" : "LongText" ;区分长短文本
    }
  Return

extension:
    img_ext :="png|PNG|jpg|JPG|jpeg|gif|tiff|tif|psd|ico|arw|ARW|bmp"
    text_ext :="txt|ini|py|html|css|js|ahk|md|json|bat"
    if Candy_isFile{    ;匹配文件
        if RegExMatch(img_ext, CandySel_Ext){    ;匹配图片
            Run, % shortcuts . "ps.lnk "  CandySel
        }else if RegExMatch(text_ext, CandySel_Ext){    ;匹配文本
            Run, % shortcuts . "vscode.lnk " . """" . CandySel . """"
        }else if Instr(CandySel_Ext, "MultiFiles"){     ;如果是多个文件,则重命名
            Run %A_ScriptDir%\plugins\ReName\ReNamer.exe %CandySel_ParentPath% 
        }else{ ;如果是单文件, 则打开属性
            Send, {alt Down}
            Send, {Enter}
            Send, {alt Up}
        }

  }else{
        ; MsgBox, 文本  ;%CandySel%
        if RegExMatch(CandySel,"((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+",mUrl){
            ; todo: 只能匹配第一个  后续的所有均忽略掉
            ;((https|http|ftp|rtsp|mms)?:\/\/)[^\s]+  ;无限匹配 简单粗暴
            ;(https?://)?([\da-z\.-]+)\.([a-z\.]{2,6})([/\w \.-\?]*)*/? ;无法匹配汉字以及一些标点符号
            ; MsgBox, %mUrl% ;连接
            ; Run, ColorPicker_win.exe% col, C:\Programs\autohotkey\plugins
            run %mUrl%
        } else if RegExMatch(CandySel, "(0x|#){1}([a-f\d]){6}",mCol){ ;match color 匹配颜色
            ; MsgBox, % mCol
            mCol := "D:\Programs\autohotkey\caps\plugins\ColorPicker_win.exe " . SubStr(mCol, 2) . "ff"
            ; MsgBox, % mCol
            Run, % mCol
        } else if RegExMatch(CandySel, "\((?P<col1>25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\,(?P<col2>25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\,(?P<col3>25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\)",mCol){
            ; MsgBox, % mCol
            mCol := "ColorPicker_win.exe " . (dec2hex(mColcol1)dec2hex(mColcol2)dec2hex(mColcol3)) . "ff" ; RGB格式的颜色
            Run, % mCol, D:\Programs\autohotkey\caps\plugins
        }else if RegExMatch(CandySel,"\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}",mMail){
            ; MsgBox, %mEmail% ;邮箱地址
            Clipboard := mMail
            displayToast(mMail,"ffff00",24,-3000)
        }else if RegExMatch(CandySel,"0?(13|14|15|18)[0-9]{9}",mPhone){
            ; MsgBox, %mPhone% ;大陆手机号码
            Clipboard := mPhone
            displayToast(mPhone,"ffff00",24,-3000)
        }else if RegExMatch(CandySel,"(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)\.(25[0-5]|2[0-4]\d|[0-1]\d{2}|[1-9]?\d)",mIP){
            ; MsgBox, %mIP% ;ip地址
            Clipboard := mIP
            displayToast(mIP,"ffff00",24,-3000)
        ; }else if RegExMatch(CandySel,"(HKCU|HKCR|HKCC|HKU|HKLM|HKEY_CLASSES_ROOT|HKEY_CURRENT_USER|HKEY_LOCAL_MACHINE|HKEY_USERS|HKEY_CURRENT_CONFIG)\\",mReg){
            ; MsgBox, %mReg% ;注册表地址
            Clipboard := mReg
            displayToast(mReg,"ffff00",24,-3000)
        }else{
            ; 统计字符长度
            str := CandySel
            allLen :=StrLen(str)

            ; 如果字符少于6个,则开启搜索功能
            if(allLen<6){
                url := "https://www.baidu.com/s?wd=" . str
                Run, % url
            }

            ; 判断标点符号, 无法识别中文标点符号,序号,罗马符号
            str := RegExReplace(str,"[[:punct:]]",,punctLen)
            ; 排除掉英文字幕,数字   s+ 空白字符
            str := RegExReplace(str,"[\w]",,engLen)
            Str := RegExReplace(str, "\s+")
            ; 排除掉常见的中文标点
            str := RegExReplace(str,"。|，|；|：|、|？|！|‘|’|“|”|%|&",,biaodianLen)
            ; 常见的序号
            str := RegExReplace(str,"①|②|③|④|⑤|⑥|⑦|⑧|⑨|⑩|⑪|⑫|⑬|⑴|⑵|⑶|⑷|⑸|⑹|⑺|⑻|⑼|⑽|⑾|⑿|⒀|⒈|⒉|⒊|⒋|⒌|Ⅰ|Ⅱ|Ⅲ|Ⅳ|Ⅴ",,mathLen)
            
            cjkLen := StrLen(str)
            punctLen += biaodianLen
            ; 其中的标点符号未统计空白字符(空格 tab 换行)
            msg := "中文" cjkLen "字, 共" allLen "字符. 其中标点" punctLen "个"
            displayToast(msg,,24,-5000)
            str := 
        }
  }

Return