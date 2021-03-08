; ----------------------------------------------------------------------------
; 2020年11月9日 19:05:09
; 屏幕边缘操作
 ;相关实现节选自 OneQuick
; 左边缘:音量调节
; 右边缘:page UP/down
; 上边缘:切换便签页
; 下边缘:虚拟桌面

#if (CursorCornerPos()="L")
WheelUp::Send {Volume_Up}
WheelDown::Send {Volume_Down}
MButton::Send,{Volume_Mute}
#if
#if (CursorCornerPos()="R")
wheelup::send {PgUp}
wheeldown::send {PgDn}
#if
#if (CursorCornerPos()="T")
wheelup::send ^{PgUp}
wheeldown::send ^{PgDn}
#if
#if (CursorCornerPos()="B")
wheelup::send ^#{Left}
wheeldown::send ^#{Right}
#if
; 边缘角触发
; #if CursorIsPos("LT")
; wheelup::send ^#{Left}
; wheeldown::send ^#{Right}
; #if

CursorCornerPos(cornerPix = 8)
{
	CoordMode, mouse,Screen    ; 相较于屏幕获取鼠标坐标
	MouseGetPos, X, Y
	CoordMode, mouse,Relative

	; Multi Monitor Support
	SysGet, MonitorCount, MonitorCount   ;获取显示器的总数
	Loop, % MonitorCount
	{
		SysGet, Mon, Monitor, % A_Index ;获取第index块屏幕的边界坐标
		; MsgBox, 左%MonLeft%上%MonTop%右%MonRight%下%MonBottom%X%X%Y%Y%
		if(X>=MonLeft && Y>= MonTop && X<MonRight && Y<MonBottom)
		{
			str =
			if ( X < MonLeft + cornerPix )
				str .= "L"
			else if ( X >= MonRight - cornerPix)
				str .= "R"
			if ( Y < MonTop + cornerPix )
				str .= "T"
			else if ( Y >= MonBottom - cornerPix)
				str .= "B"

			return % str
		}
	}
	return
}

CursorIsPos(pos, cornerPix = 8)
{
	StringUpper, pos, pos  ;转换为大写
	pos_now := CursorCornerPos() ;获取当前的位置
	if (pos_now == "") && (pos == "")
		Return
	if StrLen(pos_now) == 1     ;获取字符串中包含的字符数量.
		Return % (pos_now == pos)
	Else
		pos_now2 := SubStr(pos_now,2,1) SubStr(pos_now,1,1)
	Return ((pos_now == pos) || (pos_now2 == pos))
}
