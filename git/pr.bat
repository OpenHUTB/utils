chcp 65001 > nul

setlocal enabledelayedexpansion

rem 判断脚本有且仅有一个参数
if "%~1"=="" (
    echo Error: Please provide a pull request ID.
    exit /b 1
)

rem 将脚本的第一个参数赋值给 pr_id
set pr_id=%1


rem 判断本地是否存在名为 pr_id 的分支
git rev-parse --verify %pr_id% >nul 2>&1
if %errorlevel% neq 0 (
    echo Branch %pr_id% does not exist locally. Fetching from remote...
    git fetch origin pull/%pr_id%/head:%pr_id% && git switch %pr_id%
    exit /b 1
) else (
    echo Branch %pr_id% exists locally. Updating it...
    git pull origin pull/%pr_id%/head
)

