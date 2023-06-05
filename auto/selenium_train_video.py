import time
from selenium import webdriver
from selenium.webdriver.common.by import By


browser = webdriver.Chrome()
browser.get('https://www.hnsydwpx.cn')
browser.maximize_window()  #将浏览器最大化显示
# 找到搜索框（通过F12并按Ctrl+Shift+C进行定位）
# driver.find_element(by=By.ID, value='toolbar-search-input').send_keys('python')
# 点击搜索按钮
# driver.find_element(by=By.ID, value='toolbar-search-button').click()

# 关闭页面提示视频
time.sleep(3)  # 需要等待，不然视频没有弹出
browser.find_element(By.XPATH, '//span[@class="layui-layer-setwin"]/a').click()

# 点击登录按钮
time.sleep(1)
# driver.find_element(By.XPATH, '/html/body/div[1]/div[1]/div[1]/div[1]/div[3]/span').click()
browser.find_element(By.XPATH, '/html/body/div[1]/div[1]/div[1]/div[1]/div[3]/span').click()

# 填写登录信息：账号
# driver.find_element(By.NAME, 'username')
# browser.find_element(By.XPATH, "//div[@class='loginform']")  # div弹出窗口定位不到???
# 手动登录
time.sleep(30)


browser.get('https://www.hnsydwpx.cn/center.html')
browser.find_element(By.XPATH, '//div[@class="myname"]')


time.sleep(6)
browser.quit()