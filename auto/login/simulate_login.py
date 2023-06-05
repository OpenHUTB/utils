import time
import os
import tempfile

import selenium
from selenium import webdriver
from selenium.webdriver.common.by import By

import yagmail

is_debug = True

# tmp_dir_name = tempfile.TemporaryDirectory()
# # with tempfile.TemporaryDirectory() as tmp_dir_name:
# print('created temporary directory', tmp_dir_name)
# # 设置下载配置选项
# options = webdriver.ChromeOptions()
# prefs = {'profile.default_content_setting.popups': 0,  # 设置为0表示禁止弹出下载窗口
#          'download.default_directory': tmp_dir_name}
# options.add_experimental_option('prefs', prefs)

sel = selenium.webdriver.Chrome()  # options=options

home_page_url = 'http://one.hutb.edu.cn/'

# 登录事务系统
loginurl = 'https://cas.hutb.edu.cn/lyuapServer/login'
# open the login in page
sel.get(loginurl)
time.sleep(1)

# sign in the username
# https://stackoverflow.com/questions/72773206/selenium-python-attributeerror-webdriver-object-has-no-attribute-find-el
# find_by_id已经移除了
try:
    sel.find_element("name", "username").send_keys('2929')
    print('user success!')
except:
    print('user error!')

time.sleep(1)
# sign in the pasword
try:
    sel.find_element("name", "password").send_keys('donghaiwang.1')
    print('pw success!')
except:
    print('pw error!')

time.sleep(1)
# click to login
try:
    sel.find_element("name", "login").click()
    print('click success!')
except:
    print('click error!')
time.sleep(10)


##
# 点击系统导航
sel.find_element('id', '0').click()
time.sleep(10)


# 登录腾讯企业邮箱（不需要页面登录就可以发送邮件）
# sel.find_element(by=By.XPATH, value='//*[@class="src-assets-style-allAffairs--index-imageRadius-1EY6r"]').click()

# 打开OA系统界面
sel.find_element(by=By.XPATH, value="/html/body/div[1]/span/div/div/div/div[1]/div[1]/div[1]/div/div[2]/div[1]/div[2]/div[2]/div/div/div/div/div/div/div/div[8]").click()

time.sleep(15)
# 跳转到OA系统
sel.find_element(By.ID, 'guide_handleButton').click()

time.sleep(5)

# 切换到当前页面
window_handles = sel.window_handles
sel.switch_to.window(window_handles[1])
time.sleep(3)
# sel.close() # 关闭第一个，第二个也获取不到信息

# 点击左侧栏中的“个人办公”
sel.find_element(By.XPATH, '//*[@id="id_00"]').click()
time.sleep(3)
# 点击左侧栏中的“待办已阅”
sel.find_element(By.XPATH, '/html/body/div[2]/div[1]/div[1]/div[1]/a[2]').click()

time.sleep(3)
# 切换到页面中间的frame上
frame_name = sel.find_element(By.XPATH, '//*[@id="Main"]')
# 切换到该iframe上
sel.switch_to.frame(frame_name)


while True:
    time.sleep(5)
    if is_debug:  # 选择“已阅事宜”进行调试
        sel.find_element(By.ID, '05').click()
        time.sleep(3)
        table = sel.find_element(By.TAG_NAME, 'table')
        if '1' in table.text:  # 存在事宜
            # 每次点击第一个事项的“详情”链接
            sel.find_element(By.XPATH, '/html/body/form/div[3]/div/table/tbody[2]/tr[1]/td[10]/a').click()
            time.sleep(3)

            from download_send_email import *
            download_send_email(sel=sel)
            pass
    else:
        # 点击“待阅事项”
        sel.find_element(By.ID, '03').click()
        try:
            sel.find_element(By.XPATH, '/html/body/div/div[1]/div[2]/div/div/ul/li[1]/a/div[2]').click()
            time.sleep(3)
            print('find a item')
        except:
            print('no item')

    # sel.refresh()

    window_handles = sel.window_handles
    sel.switch_to.window(window_handles[1])
    # 点击左侧栏中的“个人办公”
    sel.find_element(By.XPATH, '//*[@id="id_00"]').click()
    time.sleep(3)
    # 点击左侧栏中的“待办已阅”
    sel.find_element(By.XPATH, '/html/body/div[2]/div[1]/div[1]/div[1]/a[2]').click()
    time.sleep(3)
    # 切换到页面中间的frame上
    frame_name = sel.find_element(By.XPATH, '//*[@id="Main"]')
    # 切换到该iframe上
    sel.switch_to.frame(frame_name)

    time.sleep(3)

# # 切换到pdf信息页面
# # todo: 提取页面信信息作为所发送信息的摘要
# window_handles = sel.window_handles
# sel.switch_to.window(window_handles[2])
#
# table = sel.find_element(By.TAG_NAME, 'table')
# rows = sel.find_elements(By.TAG_NAME, 'tr')
# cols = sel.find_elements(By.TAG_NAME, "td")
# pdf_title = cols[14].text
# print(pdf_title)
# # for col in cols:
# #     print(col.text)
# # for row in rows:
# #     cols = sel.find_elements(By.TAG_NAME, "td")
# #     for col in cols:
# #         print(col.text)
#
#
# time.sleep(3)
#
# sel.find_element(By.XPATH, '//*[@onclick="content_word_Or_pdf()"]').click()
#
#
#
# time.sleep(3)
#
# window_handles = sel.window_handles
# sel.switch_to.window(window_handles[3])
#
# # 点击页面左上角进行文件下载
# sel.find_element(By.XPATH, '//*[@id="out"]').click()
# time.sleep(5)
#
# download_files = os.path.expanduser("~")+"\\Downloads\\" + pdf_title + "正文.pdf"
# # download_files = os.listdir(tmp_dir_name)
# # for i in download_files:
# #     print(i)
#
# # 连接邮箱服务器
# yag = yagmail.SMTP(user="wanghaidong@hutb.edu.cn", password="DongHaiWang.1",
#                    host='smtp.exmail.qq.com')
#
# # 邮件正文
# contents = ['OA系统的通知文件。']
#
# # 发送邮件
# yag.send('2929@hutb.edu.cn', 'OA通知：'+pdf_title, contents, download_files)
#

