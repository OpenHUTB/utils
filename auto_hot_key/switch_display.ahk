; 参考：https://superuser.com/questions/1162680/is-there-a-windows-10-hotkey-or-shortcut-for-switching-to-a-specific-display
; 仅电脑屏幕 C:\Windows\System32
^PgDn::
run C:\Windows\System32\DisplaySwitch.exe /internal
return

^PgUp::
run C:\Windows\System32\DisplaySwitch.exe /extend
return
