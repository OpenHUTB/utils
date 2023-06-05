@echo off
:: 设置要永久加入到path环境变量中的路径
:: 需要管理员权限
:: set My_PATH=C:\BaiduSyncdisk\shortcut
set My_PATH=%1
 
set PATH=%PATH%;%My_PATH%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "Path" /t REG_EXPAND_SZ /d "%PATH%" /f
:: 通过Dos窗口打印要修改的环境变量来刷新环境变量，从而使立刻环境变量生效，就不需要重启了。
echo %PATH% 
exit