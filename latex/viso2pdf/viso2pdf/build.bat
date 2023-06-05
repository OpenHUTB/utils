:: 命令行构建viso转pdf的工程
:: 参考：https://blog.csdn.net/guo_lei_lamant/article/details/108713255

:: 后面跟"Debug|64"或者"Debug|Win32"还构建失败！！！
:: 使用.sln的绝对路径双击运行才有效
C:\"Program Files (x86)"\"Microsoft Visual Studio 14.0"\Common7\IDE\devenv.exe Z:\data3\dong\ai\tools\latex\viso2pdf\viso2pdf.sln /Build
:: Z:\data3\dong\ai\tools\latex\viso2pdf\

:: 清除解决方案
:: C:\"Program Files (x86)"\"Microsoft Visual Studio 14.0"\Common7\IDE\devenv.exe viso2pdf.sln /Clean