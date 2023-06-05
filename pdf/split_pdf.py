# 根据章节的起始页面来切分PDF文件
# 输入：section_info
# 输出：PDF当前目录下的split文件间

# 书签操作参考：https://www.zhihu.com/question/344805337/answer/1116258929

# pip install pikepdf
# Elegant, Pythonic API
import os.path
import sys
import io
import re

import pikepdf as pikepdf
from pikepdf import Array, Name, OutlineItem, Page, Pdf, String

import numpy as np
import os

from pathlib import Path
from distutils.version import LooseVersion


if LooseVersion(sys.version) < "3.7":
    raise NotImplementedError("pikepdf requires Python 3.7+")


#################
# Add bookmarks #
#################
def _get_parent_bookmark(current_indent, history_indent, bookmarks):
    '''The parent of A is the nearest bookmark whose indent is smaller than A's
    '''
    assert len(history_indent) == len(bookmarks)
    if current_indent == 0:
        return None
    for i in range(len(history_indent) - 1, -1, -1):
        # len(history_indent) - 1   ===>   0
        if history_indent[i] < current_indent:
            return bookmarks[i]
    return None


def addBookmark(pdf_path, bookmark_txt_path, page_offset):
    if not Path(pdf_path).exists():
        return "Error: No such file: {}".format(pdf_path)
    if not Path(bookmark_txt_path).exists():
        return "Error: No such file: {}".format(bookmark_txt_path)

    with io.open(bookmark_txt_path, 'r', encoding='utf-8') as f:
        bookmark_lines = f.readlines()

    pdf = Pdf.open(pdf_path)
    maxPages = len(pdf.pages)

    bookmarks, history_indent = [], []
    # decide the level of each bookmark according to the relative indent size in each line
    #   no indent:          level 1
    #     small indent:     level 2
    #       larger indent:  level 3
    #   ...
    with pdf.open_outline() as outline:
        for line in bookmark_lines:  # 遍历书签的所有行
            line2 = re.split(r'\s+', line.strip())
            if len(line2) == 1:
                continue

            indent_size = len(line) - len(line.lstrip())
            parent = _get_parent_bookmark(indent_size, history_indent, bookmarks)
            history_indent.append(indent_size)

            title, page = ' '.join(line2[:-1]), int(line2[-1]) - 1
            if page + page_offset >= maxPages:
                return "Error: page index out of range: %d >= %d" % (page + page_offset, maxPages)

            new_bookmark = OutlineItem(title, page + page_offset)
            if parent is None:
                outline.root.append(new_bookmark)
            else:
                parent.children.append(new_bookmark)
            bookmarks.append(new_bookmark)

    out_path = Path(pdf_path)
    out_path = out_path.with_name(out_path.stem + "-new.pdf")
    pdf.save(out_path)

    return "The bookmarks have been added to %s" % out_path


#################
# Extract bookmarks #
#################
def _getDestinationPageNumber(outline, names):
    def find_dest(ref, names):
        resolved = None
        if isinstance(ref, Array):
            resolved = ref[0]
        else:
            for n in range(0, len(names) - 1, 2):
                if names[n] == ref:
                    if names[n+1]._type_name == 'array':
                        named_page = names[n+1][0]
                    elif names[n+1]._type_name == 'dictionary':
                        named_page = names[n+1].D[0]
                    else:
                        raise TypeError("Unknown type: %s" % type(names[n+1]))
                    resolved = named_page
                    break
        if resolved is not None:
            return Page(resolved).index

    if outline.destination is not None:
        if isinstance(outline.destination, Array):
            # 12.3.2.2 Explicit destination
            # [raw_page, /PageLocation.SomeThing, integer parameters for viewport]
            raw_page = outline.destination[0]
            try:
                page = Page(raw_page)
                dest = page.index
            except:
                dest = find_dest(outline.destination, names)
        elif isinstance(outline.destination, String):
            # 12.3.2.2 Named destination, byte string reference to Names
            # dest = f'<Named Destination in document .Root.Names dictionary: {outline.destination}>'
            assert names is not None
            dest = find_dest(outline.destination, names)
        elif isinstance(outline.destination, Name):
            # 12.3.2.2 Named desintation, name object (PDF 1.1)
            # dest = f'<Named Destination in document .Root.Dests dictionary: {outline.destination}>'
            dest = find_dest(outline.destination, names)
        elif isinstance(outline.destination, int):
            # Page number
            dest = outline.destination
        else:
            dest = outline.destination
        return dest
    else:
        return find_dest(outline.action.D, names)


def _parse_outline_tree(outlines, level=0, names=None):
    """Return List[Tuple[level(int), page(int), title(str)]]"""
    ret = []
    if isinstance(outlines, (list, tuple)):
        for heading in outlines:
            # contains sub-headings
            ret.extend(_parse_outline_tree(heading, level=level, names=names))
    else:
        ret.append((level, _getDestinationPageNumber(outlines, names) + 1, outlines.title))
        for subheading in outlines.children:
            # contains sub-headings
            ret.extend(_parse_outline_tree(subheading, level=level+1, names=names))
    return ret


def extractBookmark(pdf_path, bookmark_txt_path):
    # https://github.com/pikepdf/pikepdf/issues/149#issuecomment-860073511
    def has_nested_key(obj, keys):
        ok = True
        to_check = obj
        for key in keys:
            if key in to_check.keys():
                to_check = to_check[key]
            else:
                ok = False
                break
        return ok

    def get_names(pdf):
        if has_nested_key(pdf.Root, ['/Names', '/Dests']):
            obj = pdf.Root.Names.Dests
            names = []
            ks = obj.keys()
            if '/Names' in ks:
                names.extend(obj.Names)
            elif '/Kids' in ks:
                for k in obj.Kids:
                    names.extend(get_names(k))
            else:
                assert False
            return names
        else:
            return None

    if not Path(pdf_path).exists():
        return "Error: No such file: {}".format(pdf_path)
    if Path(bookmark_txt_path).exists():
        print("Warning: Overwritting {}".format(bookmark_txt_path))

    pdf = Pdf.open(pdf_path)
    names = get_names(pdf)
    with pdf.open_outline() as outline:
        outlines = _parse_outline_tree(outline.root, names=names)
    if len(outlines) == 0:
        return "No bookmark is found in %s" % pdf_path
    # List[Tuple[level(int), page(int), title(str)]]
    max_length = max(len(item[-1]) + 2 * item[0] for item in outlines) + 1
    # print(outlines)
    # 第1列：目录级别（从0开始）
    # 第2列：书签指向的页码
    # 第3列：书签内容
    return outlines
    # 以下为把书签写入文件bookmark_txt_path中
    with open(bookmark_txt_path, 'w') as f:
        for level, page, title in outlines:
            level_space = '  ' * level
            title_page_space = ' ' * (max_length - level * 2 - len(title))
            f.write("{}{}{}{}\n".format(level_space, title, title_page_space, page))
    return "The bookmarks have been exported to %s" % bookmark_txt_path


def split_pdf(file_path):
    # 抽取书签
    outlines = extractBookmark(file_path, 'bookmark.txt')

    # 根据书签得到section_info
    section_lst = []
    for i in range(len(outlines)):
        if i == 0:
            continue
        indent_num, page, title = outlines[i]
        if indent_num == 0:
            section_lst.append(page)
    whole_pdf = Pdf.open(file_path)
    section_lst.append(len(whole_pdf.pages))
    section_info = np.array(section_lst)

    # 考虑只有 1 列的情况，最后一行为最后一个文件结束（扩充完成，需要删除）
    if section_info.ndim == 1:
        section_info = np.tile(section_info.reshape(section_info.size, 1), (1,2))  # #构造 (1X2) 个copy
        chapters, cols = section_info.shape
        for i in range(chapters - 1):
            section_info[i][1] = section_info[i+1][0] - 1  # 当前文件的结束页码为后一个文件开始的页面-1
        section_info = section_info[:chapters-1, :]  # 删除最后一行

    chapters, cols = section_info.shape

    # Python数组下标：开始页码-1，结束页面（不包括）
    for i in range(chapters):
        section_info[i][0] = section_info[i][0] - 1
    # 变成了list??
    # section_info = [x-1 for x in section_info]  # 页码在python 中需要-1（python从0开始）

    # dir_prefix = r'D:\BaiduSyncdisk\work\learn\neuro\神经科学'
    (dir_prefix, full_name) = os.path.split(file_path)
    output_dir = os.path.join(dir_prefix, 'split')  # 在PDF所在的同一目录下新建一个切分后的文件夹split
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    page_offset = 2  # 当前文件相对于总文件开始的偏移页数
    with pikepdf.open(file_path) as pdf:
        outlines_idx = 1  # 跳过第一个总目录标签（注意：其他文件会有问题）
        for i in range(chapters):  # 切分的数目（书的本数19）
            dst = Pdf.new() # 新建当前切分出来的文件
            cur_pdf = pdf.pages[section_info[i, 0] : section_info[i, 1]]  # 当前切分出来的文件的所有页面
            for p in range(len(cur_pdf)):
                dst.pages.append(
                    cur_pdf[p])  # TypeError: tried to insert object which is neither pikepdf.Page nor pikepdf.Dictionary with type page

            # 给当前文件添加标签
            bookmarks, history_indent = [], []
            # decide the level of each bookmark according to the relative indent size in each line
            #   no indent:          level 1
            #     small indent:     level 2
            #       larger indent:  level 3
            #   ...
            cur_file_title = ''
            with dst.open_outline() as outline:  # 打开当前pdf的书签
                is_end = 0
                while True:
                    if outlines_idx >= len(outlines):  # 遍历完所有的标签
                        break
                    indent_num, page, title = outlines[outlines_idx]
                    if indent_num == 0:
                        is_end = is_end+1  # 初始为0，开始当前文件为1，遇到下一个文件开头为2
                    if is_end == 2:
                        page_offset = page-1  # 当前切分出来的文件标签跳转到的页码需要减去第一页相对于整个文件的偏置
                        break
                    if indent_num == 0:
                        cur_file_title = title  # 每个文件对应的标签第一行为当前文件的文件名（用于保存文件）
                    outlines_idx = outlines_idx + 1

                    indent_size = indent_num*2  # 每一级子标签都缩进两个空格
                    parent = _get_parent_bookmark(indent_size, history_indent, bookmarks)  # 得到标签的父标签（用已有函数）
                    history_indent.append(indent_size)

                    new_bookmark = OutlineItem(title, page - page_offset-1)  # XYZ 指向了下一页
                    if parent is None:
                        outline.root.append(new_bookmark)  # 为1级标签就在文件的标签下添加
                    else:
                        parent.children.append(new_bookmark)  # 将新的标签添加的父标签中
                    bookmarks.append(new_bookmark)  # IndexError: Accessing nonexistent PDF page number。解决：增加第一个一级标签为不用的

            dst.save(os.path.join(output_dir, cur_file_title + '.pdf'))  # 保存文件
            pass

# TODO 按pdf一级标签进行切分


if __name__ == '__main__':
    file_path = 'C:/BaiduSyncdisk/learn/neuro/tmp/心理_脑与认知系列套装（15册）.pdf'
    # file_path = 'C:/BaiduSyncdisk/learn/neuro\/tmp/1-21《中信见识丛书精选套装（上）（套装共19册）.pdf'
    # 切分
    # 文件格式要求：第一个一级标签为不用的，后面按每个一级标签切分PDF
    split_pdf(file_path)

    # csv_path = 'split.csv'  # 切分的文件，第一列为开始页码，（第二列为结束页码）
    # section_info = np.loadtxt(csv_path, delimiter=',', dtype=int)
    #
    # pass

'''
# 每一个章节的开始和结束页码（绝对页码）
# section_info = np.array([
#     [52, 70],      # 1
#     [71, 100],     # 2
#     [101, 117],    # 3
#     [118, 141],    # 4
#     [141, 155],    # 5
#     [156, 172],    # 6
#     [178, 209],    # 7
#     [210, 234],    # 8
#     [235, 255],    # 9
#     [256, 280],    # 10
#     [286, 298],    # 11
#     [299, 317],    # 12
#     [318, 345],    # 13
#     [346, 368],    # 14
#     [369, 402],    # 15
#     [403, 423],    # 16
#     [430, 452],    # 17
#     [453, 479],    # 18
#     [480, 514],    # 19
#     [515, 540],    # 20
#     [541, 565],    # 21
#     [566, 589],    # 22
#     [590, 608],    # 23
#     [609, 626],    # 24
#     [627, 642],    # 25
#     [643, 673],    # 26
#     [674, 695],    # 27
#     [696, 726],    # 28
#     [727, 751],    # 29
#     [758, 781],    # 30
#     [782, 805],    # 31
#     [806, 827],    # 32
#     [828, 859],    # 33
#     [860, 904],    # 34
#     [905, 927],    # 35
#     [928, 952],    # 36
#     [953, 976],    # 37
#     [977, 997],    # 38
#     [998, 1018],   # 39
#     [1026, 1054],  # 40
#     [1055, 1089],  # 41
#     [1090, 1109],  # 42
#     [1110, 1124],  # 43
#     [1125, 1144],  # 44
#     [1152, 1174],  # 45
#     [1175, 1200],  # 46
#     [1201, 1225],  # 47
#     [1226, 1254],  # 48
#     [1255, 1280],  # 49
#     [1281, 1304],  # 50
#     [1305, 1329],  # 51
#     [1336, 1356],  # 52
#     [1357, 1383],  # 53
#     [1384, 1414],  # 54
#     [1415, 1436],  # 55
#     [1437, 1461],  # 56
#     [1466, 1491],  # 57
#     [1492, 1517],  # 58
#     [1518, 1532],  # 59
#     [1533, 1545],  # 60
#     [1546, 1567],  # 61
#     [1568, 1588],  # 62
#     [1589, 1605],  # 63
#     [1606, 1626],  # 64
# ])

# 将测试数据保存未.csv，便于测试函数
# np.savetxt('neuro.csv', section_info, delimiter=',', fmt='%d')
'''
