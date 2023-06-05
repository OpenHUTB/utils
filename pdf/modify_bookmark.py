# 参考： https://www.cnblogs.com/shengou/p/16931826.html
# pip install pymupdf　　　　　　　　　　　　　　　　# pip安装pymupdf库

import fitz  # 导入pymupdf库
doc = fitz.open("test.pdf")  # 获取一个pdf对象
toc = doc.get_toc()  # get_toc()方法获取pdf对象的书签
print(toc)  # toc是一个二维的列表。
