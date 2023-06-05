# 传递参数：所需转换的pdf所在路径
# /data3/dong/mot/sture/latex/cviu/figs

# ref: https://blog.csdn.net/wwj_748/article/details/78135879
# 将latex中fig目录中的所有pdf文件转成jpg,eps

# pdf 转成 eps 的文件太大了，所以先将pdf转成jpg再转成eps
# convert tracking_result.jpg eps3:tracking_result.eps

import sys
import os
import glob

# pip3 install wand
from wand.image import Image
from wand.color import Color

# ImportError: MagickWand shared library not found.
# You probably had not installed ImageMagick library.

# Python Imaging Library （简称PIL）
# pip install Pillow
from PIL import Image as pil


from subprocess import call


# 将pdf转成jpg再转成eps（废弃）
def convert_pdf_to_jpg(filename):
    with Image(filename=filename) as img:
        # 解决转化出来的图片是黑底的问题(ref:https://stackoverflow.com/questions/46491452/python-wand-convert-pdf-to-black-image)
        img.background_color = Color("white")
        img.alpha_channel = 'remove'

        with img.convert('jpeg') as converted:
            # 保存到和*.pdf相同的目录下的*.jpeg
            img_filename = filename[:-4] + '.jpg'
            converted.save(filename=img_filename)

        # 将jpg转换为eps
        eps_filename = filename[:-4] + '.eps'
        img = pil.open(img_filename)
        img.save(eps_filename)

        pass


# 使用方法：
# C:\Progra~1\Anaconda3\python D:\workspace\dong\ai\tools\latex\pdf2eps.py D:\workspace\dong\mot\sture\latex\cviu
if __name__ == '__main__':
    target_dir = sys.argv[1]
    target_suffix = "*.pdf"
    pdfs = glob.glob(os.path.join(target_dir, target_suffix))

    for cur_pdf in pdfs:
        # print('Processing: ', cur_pdf)
        # convert_pdf_to_jpg(cur_pdf)
        eps_filename = cur_pdf[:-4] + ".eps"
        # pdf2ps
        # 可以指定输出文件的dpi(i.e., 使用-r number)
        # 比如把文件输出为100dpi, 默认是300dpi, 可能你的文件会变小一些
        # call(["pdftops", "-r", "200", cur_pdf, eps_filename])
		call(["pdftops", "-eps", cur_pdf])  # pdftops -eps network.pdf  (win10 笔记本上执行）
        # 单独缩小这个最大的文件		
        # pdftops -r 55 tracking_result.pdf tracking_result.eps
        # pdftops -r 200 network.pdf network.eps

    pass
