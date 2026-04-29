chcp 65001 > nul

setlocal enabledelayedexpansion

rem 判断脚本有且仅有一个参数
if "%~1"=="" (
    echo Error: Please provide a pull request ID.
    exit /b 1
)

rem 将脚本的第一个参数赋值给 pr_id
set pr_id=%1

git fetch origin pull/%pr_id%/head:%pr_id% && git switch %pr_id%