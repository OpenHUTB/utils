# 参考： https://www.51cto.com/article/665103.html
# https://blog.csdn.net/SL_World/article/details/95493897

# TODO: 修改.pdf的默认打开方式

# encoding:utf-8
from __future__ import print_function
from winreg import *
import ctypes, sys

subDir = r'Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\\'
standard = r'\StandardProfile'
public = r'\PublicProfile'
enableKey = 'EnableFirewall'
value = 1

def is_admin():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False

def updateFireWall(keyName):
    # 1.连接注册表根键
    regRoot = ConnectRegistry(None, HKEY_LOCAL_MACHINE)
    # 2.获取指定目录下键的控制
    keyHandel = OpenKey(regRoot, subDir+keyName)
    if is_admin():
        # 3.设置该键的指定键值enableKey为value
        SetValueEx(keyHandel, enableKey, value, REG_DWORD, value)
    else:
        if sys.version_info[0] == 3:
            ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, __file__, None, 1)
    # 4.关闭键的控制
    CloseKey(keyHandel)
    CloseKey(regRoot)


def update_default_app(keyName):
    # 1.连接注册表根键
    regRoot = ConnectRegistry(None, HKEY_CURRENT_USER)
    # 2.获取指定目录下键的控制
    keyHandel = OpenKey(regRoot, subDir+keyName)
    if is_admin():
        # 3.设置该键的指定键值enableKey为value
        SetValueEx(keyHandel, enableKey, value, REG_DWORD, value)
    else:
        if sys.version_info[0] == 3:  # 不回了！！！
            ctypes.windll.shell32.ShellExecuteW(None, "runas", sys.executable, __file__, None, 1)
    # 4.关闭键的控制
    CloseKey(keyHandel)
    CloseKey(regRoot)


if __name__ == '__main__':
    keyName = r'.pdf'
    update_default_app(keyName)
    # updateFireWall(standard)
    # updateFireWall(public)


# access_registry = winreg.ConnectRegistry(None, winreg.HKEY_CURRENT_USER)  # 第一个参数：计算机名：\\DESKTOP-M7I8RFS，None表示连接本地计算机的注册表；返回值是所开打键的句柄
# access_key = winreg.OpenKey(access_registry, r"Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\OpenWithList")  # 枚举出这个目录下的所有项
#
# OpenKeyEx = winreg.OpenKeyEx(access_registry, r"Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf\OpenWithList")  # 枚举出这个目录下的所有项