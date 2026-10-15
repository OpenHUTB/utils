chcp 65001 > nul

setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Error: Please provide a pull request ID.
    exit /b 1
)

set pr_id=%1

git rev-parse --verify %pr_id% >nul 2>&1
if %errorlevel% neq 0 (
    echo Branch %pr_id% does not exist locally. Fetching from remote...
    git switch %pr_id%
    git fetch origin pull/%pr_id%/head:%pr_id%
    exit /b 1
) else (
    echo Branch %pr_id% exists locally. Updating it...
    git pull origin pull/%pr_id%/head
)

