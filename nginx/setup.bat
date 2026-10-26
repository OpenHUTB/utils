@echo off

rem if exist nginx process, kill it
tasklist /FI "IMAGENAME eq nginx.exe" 2>NUL | find /I /N "nginx.exe">NUL
if "%ERRORLEVEL%"=="0" (
    echo nginx.exe is running, killing it...
    taskkill /F /IM nginx.exe
) else (
    echo nginx.exe is not running.
)

if not exist nginx-1.30.6.zip (
    echo Downloading nginx-1.30.6.zip...
    curl -fsSL -o nginx-1.30.6.zip https://nginx.org/download/nginx-1.30.6.zip
) else (
    echo nginx-1.30.6.zip already exists.
)

if not exist nginx-1.30.6 (
    echo Extracting nginx-1.30.6.zip...
    tar -xf "nginx-1.30.6.zip"
) else (
    echo nginx-1.30.6 already exists.
)

copy /y conf\nginx.conf nginx-1.30.6\conf\nginx.conf

cd nginx-1.30.6
rem share files in C:\
start nginx.exe
rem nginx.exe -s reload
rem nginx.exe -s stop

rem search all nginx process
rem tasklist /fi "imagename eq nginx.exe"
rem Kill nginx process in any directory
rem taskkill /f /im nginx.exe
