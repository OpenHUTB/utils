
# Local variable
password=jjj

# update source 
echo $password | sudo -S cp /etc/apt/sources.list /etc/apt/bak.sources.list
echo $password | sudo dd if=/dev/null of=/etc/apt/sources.list

echo $password | sudo -S sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse" >> /etc/apt/sources.list'
echo $password | sudo -S sh -c 'echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe multiverse" >> /etc/apt/sources.list'
echo $password | sudo -S sh -c 'echo "" >> /etc/apt/sources.list'

echo $password | sudo -S sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list'
echo $password | sudo -S sh -c 'echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-security main restricted universe multiverse" >> /etc/apt/sources.list'
echo $password | sudo -S sh -c 'echo "" >> /etc/apt/sources.list'

echo $password | sudo -S sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list'
echo $password | sudo -S sh -c 'echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-updates main restricted universe multiverse" >> /etc/apt/sources.list'
echo $password | sudo -S sh -c 'echo "" >> /etc/apt/sources.list'

echo $password | sudo -S sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse" >> /etc/apt/sources.list'
echo $password | sudo -S sh -c 'echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-proposed main restricted universe multiverse" >> /etc/apt/sources.list'
echo $password | sudo -S sh -c 'echo "" >> /etc/apt/sources.list'

echo $password | sudo -S sh -c 'echo "deb http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list'
echo $password | sudo -S sh -c 'echo "deb-src http://mirrors.aliyun.com/ubuntu/ bionic-backports main restricted universe multiverse" >> /etc/apt/sources.list'
echo $password | sudo -S sh -c 'echo "" >> /etc/apt/sources.list'

echo $password | sudo -S apt-get update


# install necessary software
echo $password | sudo -S apt-get -y install libevent-dev
#显示显卡信息
echo $password | sudo -S apt-get -y install mesa-utils
#安装网速监控工具
echo $password | sudo -S apt-get -y install nethogs

echo $password | sudo -S apt-get -y install vim rar unrar uget flashplugin-installer

# Switch application
echo $password | sudo -S  apt-get install dconfig-editor


# Development tools
echo $password | sudo -S apt-get -y install vim git subversion make
echo $password | sudo -S apt-get -y install build-essential intltool libssl-dev pkg-config
# Development language
echo $password | sudo -S apt-get -y install openjdk-8-jdk
#mysql
echo $password | sudo -S apt-get -y install mysql-server mysql-client


#安装php和MySQL
echo $password | sudo -S apt-get -y install mysql-server mysql-client nginx
#安装pecl
echo $password | sudo -S apt-get -y install php-pear
#安装redis
echo $password | sudo -S apt-get -y install redis redis-tools redis-server
echo $password | sudo -S apt-get -y install memcached mcrypt
#安装curl
echo $password | sudo -S apt-get -y install curl
curl -s http://getcomposer.org/installer | php


##Python相关
#安装python开发版:
echo $password | sudo -S apt-get -y install python-dev python-all-dev
#安装easy_install:
echo $password | sudo -S apt-get -y install python-setuptools
# Anaconda
wget -P /tmp/ https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-2021.04-Linux-x86_64.sh
# -b: run install in batch mode (without manual intervention)
sh /tmp/Anaconda3-2021.04-Linux-x86_64.sh -b
sed -i '$aexport PATH=/home/d/anaconda3/bin:$PATH' ~/.bashrc  #这是在最后一行行后添加字符串
source ~/.bashrc
# test
type python
# 查看conda版本  
conda --version
# 创建名字为 XXX 的新环境 
# conda create -n XXX python=3.8
# 查看有哪些环境 
conda env list
# 切换到名字为 XXX 的环境 
# conda activate XXX
# 删除名字为 XXX 的环境 
# conda remove -n XXX


# 共享虚拟机的D盘 给宿主机目录 /data2/whd/win10
# echo "jjj" | sudo -S mount -t cifs -o rw,username=Administrator,password=jjj  //192.168.160.131/d/   /data2/whd/win10



# install other software from source code
cd /tmp/

git clone https://github.com/rayylee/mwget
cd mwget
./configure
make -j
echo $password | sudo -S make install

cd ~




