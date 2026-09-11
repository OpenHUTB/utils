rem powershell -Command "Expand-Archive -Path '%cd%\ros_noetic_humble_gazebov11_linux_win_v1.zip' -DestinationPath '%cd%\' -Force" || exit /b

rem 如果不存在 7zr.exe，则下载
if not exist "7zr.exe" (
    echo 7zr.exe not found, downloading...
    curl --ssl-no-revoke -L -o 7zr.exe  https://github.com/ip7z/7zip/releases/download/26.03/7zr.exe
)

if not exist "7z.7z" (
    echo 7z.7z not found, downloading...
    curl --ssl-no-revoke -L -o 7z.7z  https://github.com/ip7z/7zip/releases/download/26.03/7z2603-extra.7z
)

if not exist "7z" (
    echo 7z not found, extracting...
    7zr.exe x 7z.7z -o%cd%\7z -y
)


if not exist "ros_noetic_humble_gazebov11_linux_win_v1" (
    echo ros_noetic_humble_gazebov11_linux_win_v1 not found, extracting...
    .\7z\7za.exe x ros_noetic_humble_gazebov11_linux_win_v1.zip -o%cd%\ros_noetic_humble_gazebov11_linux_win_v1 -y
)
