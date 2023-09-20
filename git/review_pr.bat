@echo off
:: 使用示例：review_pr.bat 14
:: 参考：https://docs.github.com/zh/pull-requests/collaborating-with-pull-requests/reviewing-changes-in-pull-requests/checking-out-pull-requests-locally

:: 第0个参数为文件名
echo param[0] = %0
:: 第1个参数为pull request的编号
echo param[1] = %1

:: 根据其 ID 号获取对该拉取请求的引用，在该过程中创建一个新分支。
git fetch origin pull/%1/head:%1

:: 切换到基于此拉取请求的新分支：
git checkout %1
:: git checkout -f 14


echo ...
pause