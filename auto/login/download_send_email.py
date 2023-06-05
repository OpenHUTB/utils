def download_send_email(sel):
    import time
    from selenium.webdriver.common.by import By
    import os
    import yagmail
    # 切换到pdf信息页面
    # todo: 提取页面信信息作为所发送信息的摘要
    window_handles = sel.window_handles
    sel.switch_to.window(window_handles[2])

    table = sel.find_element(By.TAG_NAME, 'table')
    rows = sel.find_elements(By.TAG_NAME, 'tr')
    cols = sel.find_elements(By.TAG_NAME, "td")
    pdf_title = cols[14].text
    print(pdf_title)
    # for col in cols:
    #     print(col.text)
    # for row in rows:
    #     cols = sel.find_elements(By.TAG_NAME, "td")
    #     for col in cols:
    #         print(col.text)

    time.sleep(3)

    sel.find_element(By.XPATH, '//*[@onclick="content_word_Or_pdf()"]').click()  # 点击“正文”来打开PDF

    time.sleep(3)

    window_handles = sel.window_handles
    sel.switch_to.window(window_handles[3])

    # 点击页面左上角进行文件下载
    sel.find_element(By.XPATH, '//*[@id="out"]').click()
    time.sleep(5)

    download_files = os.path.expanduser("~") + "\\Downloads\\" + pdf_title + "正文.pdf"
    # download_files = os.listdir(tmp_dir_name)
    # for i in download_files:
    #     print(i)

    # 连接邮箱服务器
    yag = yagmail.SMTP(user="wanghaidong@hutb.edu.cn", password="DongHaiWang.1",
                       host='smtp.exmail.qq.com')

    # 邮件正文
    contents = ['OA系统的通知文件。']

    # 发送邮件
    yag.send('2929@hutb.edu.cn', 'OA通知：' + pdf_title, contents, download_files)

    window_handles = sel.window_handles
    sel.switch_to.window(window_handles[3])
    sel.close()
    window_handles = sel.window_handles
    sel.switch_to.window(window_handles[2])
    sel.close()


