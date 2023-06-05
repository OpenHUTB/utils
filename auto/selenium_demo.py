import time

from selenium import webdriver
from selenium.webdriver.chrome.service import Service  # 新增
from selenium import webdriver
from selenium.webdriver.common.by import By

# service = Service(executable_path='C:\buffer\temp\chromedriver.exe')
# driver = webdriver.Chrome(service=service)
driver = webdriver.Chrome()

driver.get('https://www.baidu.com')
driver.find_element(by=By.XPATH, value='//form[@id="form"]//span')

'''
driver.get('https://www.csdn.net/')
# 找到搜索框（通过F12并按Ctrl+Shift+C进行定位）
driver.find_element(by=By.ID, value='toolbar-search-input').send_keys('python')
# 点击搜索按钮
driver.find_element(by=By.ID, value='toolbar-search-button').click()
'''

time.sleep(6)
driver.quit()



# import time
#
# from selenium import webdriver
#
# # web = Chrome()
# driver = webdriver.Chrome()    # Chrome浏览器
#
# # web.get('https://www.hnsydwpx.cn/center.html')
# driver.get('https://www.hnsydwpx.cn/center.html')

# driver.find_element('password')

# 获取课程信息
# username = web.find_element('tel')  # layui-input
# username.send_keys('430503199207273012')
# password = web.find_element('password')
# password.send_keys('donghaiwang.1')

pass
