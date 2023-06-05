#NoTrayIcon
;
;一天 24小时，1440分，86400秒
;一周 168小时，10080分，604800秒
;30天 750小时，43200分，2592000秒
;365天 8760小时，525600分，31536000秒
CustomColor = ff3301
Gui, +AlwaysOnTop +LastFound +Owner
Gui, Color, %CustomColor%
gui, font,, Arial
gui, font, s30
Gui, Add, Text, vMyText cff3300, w600 XXXXX YYYYY
WinSet, TransColor, %CustomColor% 255
Gui, -Caption
SetTimer,UpdateOSD,1000
Gosub,UpdateOSD
Gui, Show, x860 y690 ;
UpdateOSD:
time=%A_MM%月%A_DD%日
time2=%A_Hour%:%A_Min%:%A_Sec%
GuiControl,,MyText,%time%,%time2%
F10::
msgbox,4100,退出成功,你已退出时间!,1
exitapp
return