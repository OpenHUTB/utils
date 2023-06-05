import uiautomation as auto
import time
import pyautogui as pg
import pyperclip as pc
import schedule


def send_msg():
    """
    定时发送信息给微信联系人
    参考：https://cloud.tencent.com/developer/article/2080611?from=15425
    """
    # 这里是微信联系人名字，或者群名称都可以
    name = ['文件传输助手']  # , 'Sunshine'
    msg = ['Hi,这是自动发送邮件工具，调试哦！', '晚上好呀！',  '各位抱歉，调试结束，给您带来不便，深表歉意！']
    # self.msg = ['Hi, 坤少，这是一个test!', 'AMP接口人', 'AG业务专家']
    # 操作间隔为1秒
    pg.PAUSE = 1.5
    # 快捷键调出桌面微信客户端
    pg.hotkey('ctrl', 'alt', 'w')
    # 搜索栏
    pg.hotkey('ctrl', 'f')

    # 找到好友
    for dex in name:
        pc.copy(dex)
        # 粘贴
        pg.hotkey('ctrl', 'v')
        # 回车
        pg.press('enter')
        # 发送消息
        for i in msg:
            pc.copy(i)
            pg.hotkey('ctrl', 'v')
            pg.press('enter')
        # 搜索栏
        pg.hotkey('ctrl', 'f')

    # 隐藏微信
    time.sleep(1)
    pg.hotkey('ctrl', 'alt', 'w')


# 定位到windows自带的inspect.exe，对微信窗口进行定位
# C:\Program Files (x86)\Windows Kits\10\bin\10.0.19041.0\x86\inspect.exe
def get_webchat_info():
    wechat_window = auto.WindowControl(searchDepth=1, Name="微信", ClassName='WeChatMainWndForPC')
    # wechatWindow.SetFocus()
    # 消息、会话
    results = []
    messages = wechat_window.ListControl(Name="消息")
    for message in messages.GetChildren():
        content = message.Name
        results.append(content)
        # print(content)
    return results


if __name__ == "__main__":
    send_msg()

    # # 每天定时发送消息给固定的人
    # schedule.every().day.at("19:05").do(send_msg)
    # while True:
    #     schedule.run_pending()
    #     time.sleep(1)


    #messages = get_webchat_info()
    #print(messages)
