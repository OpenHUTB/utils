#!/bin/bash

# 压缩当前目录中所有的文件夹，每个文件夹都命名为：*.tar.gz
# 参考： https://www.modb.pro/db/98761

# ls --file-type -1 相比于直接使用 ls 命令 
# 是目录的后面会多一个'/'
for dir in `ls --file-type -1`;

do

        if [ `echo $dir | grep "/$"` ]; then

				# [basename]：用于去掉文件名的目录和后缀。
                dir=`basename $dir`;

                tar -zcf $dir\.tar.gz $dir;

        fi

done
