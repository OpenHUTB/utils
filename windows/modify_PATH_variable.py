# 参考：https://www.cnpython.com/qa/226711
# No module named '_winreg'
# Python3 中将 _winreg 换成 winreg
import winreg  # as winreg
import ctypes

ENV_HTTP_PROXY = u'http://87.254.212.121:8080'


class Registry(object):
    def __init__(self, key_location, key_path):
        self.reg_key = winreg.OpenKey(key_location, key_path, 0, winreg.KEY_ALL_ACCESS)

    def set_key(self, name, value):
        try:
            _, reg_type = winreg.QueryValueEx(self.reg_key, name)
        except WindowsError:
            # If the value does not exists yet, we (guess) use a string as the
            # reg_type
            reg_type = winreg.REG_SZ
        winreg.SetValueEx(self.reg_key, name, 0, reg_type, value)

    def delete_key(self, name):
        try:
            winreg.DeleteValue(self.reg_key, name)
        except WindowsError:
            # Ignores if the key value doesn't exists
            pass


class EnvironmentVariables(Registry):
    """
    Configures the HTTP_PROXY environment variable, it's used by the PIP proxy
    """

    def __init__(self):
        super(EnvironmentVariables, self).__init__(winreg.HKEY_LOCAL_MACHINE,
                                                   r'SYSTEM\CurrentControlSet\Control\Session Manager\Environment')

    def on(self):
        self.set_key('HTTP_PROXY', ENV_HTTP_PROXY)
        self.refresh()

    def off(self):
        self.delete_key('HTTP_PROXY')
        self.refresh()

    def refresh(self):
        HWND_BROADCAST = 0xFFFF
        WM_SETTINGCHANGE = 0x1A

        SMTO_ABORTIFHUNG = 0x0002

        result = ctypes.c_long()
        SendMessageTimeoutW = ctypes.windll.user32.SendMessageTimeoutW
        SendMessageTimeoutW(HWND_BROADCAST, WM_SETTINGCHANGE, 0, u'Environment', SMTO_ABORTIFHUNG, 5000, ctypes.byref(result));


# 参考：https://zhuanlan.zhihu.com/p/474712424
# regedit
# print(winreg.HKEY_CLASSES_ROOT)  # 存储应用和shell的信息
# print(winreg.KEY_ALL_ACCESS)  # 所有权限
# print(winreg.KEY_WOW64_64KEY)

access_registry = winreg.ConnectRegistry(None, winreg.HKEY_LOCAL_MACHINE)  # 第一个参数：计算机名：\\DESKTOP-M7I8RFS，None表示连接本地计算机的注册表；返回值是所开打键的句柄
access_key = winreg.OpenKey(access_registry, r"SOFTWARE\Microsoft\Windows\CurrentVersion")  # 枚举出这个目录下的所有项
n = 0
while True:
    try:
        x = winreg.EnumKey(access_key, n)  # 枚举出目录access_key中的第n项
        n += 1
        print(x)
    except:
        break


# 2.获取到chrome 浏览器的版本
key = winreg.OpenKey(winreg.HKEY_CURRENT_USER, r'Software\Google\Chrome\BLBeacon')
version, types = winreg.QueryValueEx(key, 'version')  # 获取BLBeacon目录下version这个变量的值
print(version, types)

#
# 创建Key
# winreg.CreateKey(YOUR_KEY,SUB_KEY)
# # 删除key
# winreg.DeleteKey(YOUR_KEY,SUB_KEY)
# #删除键值
# winreg.DeleteValue(KEY,VALUE)
# # 赋值，给新建的或者是已有的，修改
# winreg.SetValue(KEY,SUB_KEY,TYPE,VALUE)
# 连接完成注册表之后，需要关闭该注册表
regRoot = winreg.ConnectRegistry(None, winreg.HKEY_LOCAL_MACHINE)
winreg.CloseKey(regRoot)



KEY_ProxyEnable = "ProxyEnable"
KEY_ProxyServer = "ProxyServer"
KEY_ProxyOverride = "ProxyOverride"
KEY_XPATH = "Software\Microsoft\Windows\CurrentVersion\Internet Settings"


# 获取当前代理状态
def win_proxy_status():
    hKey = winreg.OpenKey(winreg.HKEY_CURRENT_USER, KEY_XPATH, 0, winreg.KEY_READ)
    retVal = winreg.QueryValueEx(hKey, KEY_ProxyEnable)
    winreg.CloseKey(hKey)
    hKey.Close()
    return int(retVal[0])==1


if __name__ == "__main__":

    if win_proxy_status():
        # win_disable_proxy()
        print('关闭代理')
    else:
        # win_start_proxy('127.0.0.1:8000')
        print('打开代理')

    print(win_proxy_status())



pass


