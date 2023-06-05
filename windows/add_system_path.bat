@echo off
::设置要永久加入到系统path环境变量中的路径（不是用户路径）
::需要管理员权限来运行
::参考：https://www.cnblogs.com/LiuYanYGZ/p/11853763.html
set My_PATH=D:\matlab\latex\bin\win32
  
set PATH=%PATH%;%My_PATH%
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "Path" /t REG_EXPAND_SZ /d "%PATH%" /f
exit