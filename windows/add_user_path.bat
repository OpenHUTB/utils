:: 添加用户变量path路径
:: 注意要用分号结束，否则可能会重复添加以前的一些路径（比如：C:\Users\d\.dnx\bin），这个bug未找到
:: 参考：https://blog.csdn.net/justlpf/article/details/121080101
:: 测试命令：add_user_path.bat D:\matlab\latex\bin\win32;
set ec="%1"

echo off
::color 0d
 
setlocal enabledelayedexpansion 
 
rem 定义一个以分号作为分隔的字符串
set str=%path%
rem set str=C:\Program Files (x86)\Common Files\Oracle\Java\javapath;123
 
echo %path%
rem str的副本
set remain=%str%
 
set new_path=
set next_path=
set flg=0
 
rem ============================== for循环 ====================================
echo %path%|findstr %ec%>nul
if %errorlevel%==0 (
	echo baohan4
	goto :yoop
) 
 
:loop
for /f "tokens=1* delims=;" %%a in ("%remain%") do (
	echo  --------------------- next for ----------------------
    ::输出第一个分段(令牌)
    echo next_path --- %%a
	
	set next_path=%%a
	
	call:judge_flag
	if !flg!==1 (
		echo flg ----1
	) else (
		call:judge_path
	)
	
	rem 将截取剩下的部分赋给变量remain，其实这里可以使用延迟变量开关
    set remain=%%b
)
::如果还有剩余,则继续分割
if defined remain goto :loop
 
echo new_path end end end ----------------- %new_path%
echo;
 
echo %new_path%|findstr %ec%>nul
if %errorlevel%==0 (
	echo baohan3
) else (
	setx Path ""
	echo;
	setx "Path" "%new_path%%ec%;"
    :: 如果设置完后，本窗口立即使用，需要下面的代码
    echo;
	set "Path=%new_path%%ec%;"
)
 
:yoop
:: 运行完显示“按任意键结束”
:: pause
 
goto:eof
 
rem ============================== func 1 ====================================
rem 判断是否有分号
:judge_flag
	echo;
	echo judge_flag
	
	rem ------------------------ cond1 -------------------------
	rem 判断是否存在引号"
	set "bk=%next_path:~4%"
	echo bk --- %bk%
	::将引号"替换为特殊字符串lpf，再进行比较
	set "bk=%bk:"=lpf%"
	echo bk2 --- %bk%
	echo %bk%|findstr /c:lpf>nul
	echo 0000 --- %errorlevel% 
	if %errorlevel%==0 (
		set flg=1
		echo baohan-yinhao
		
		goto :judge2
	) else ( 
		echo bubaohan-yinhao
		echo;
	)
	
	rem ------------------------ cond2 -------------------------
	set "kl=C:\windows"
	echo kl ---- %kl%
	echo %next_path%|findstr %kl%>nul
	if %errorlevel%==0 (
		set flg=1
		echo baohan0
	) else (
		set flg=0
		echo bubaohan0
	)
	
	:judge2
	::pause
	
goto:eof
rem ============================== func 2 ====================================
rem path判断
:judge_path
	echo;
	echo judge_path
	echo new_path ---- !new_path!
	echo next_path ---- %next_path%
	
	rem 这里必须加"号
	echo;"%new_path%"|findstr "%next_path%">nul
	if %errorlevel%==0 (
		echo baohan
	) else (
		echo buhaohan
		set "new_path=%new_path%!next_path!;"
		echo last_new_path --- !new_path!
	)
goto:eof