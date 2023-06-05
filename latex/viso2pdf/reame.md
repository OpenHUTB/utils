
使用方法：
D:\dong\ai\tools\latex\viso2pdf\viso2pdf\bin\Debug\viso2pdf.exe mot\sture\latex\cviu C:\texlive\2016\bin\win32\pdfcrop.exe

还需要解决的bug：

1. viso保存Save()后会修改源文件

2. 改成不需要修改viso所在的相对路径（使用viso2pdf.bat）


# 部署
使用`Listdlls`工具导出`viso2pdf.exe`所依赖的`dll`文件列表`dep_dll.txt`，