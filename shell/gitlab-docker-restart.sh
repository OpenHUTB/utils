#!/bin/bash

serverName="gitlab"
imageName="gitlab/gitlab-ce:11.6.4-ce.0"

function runServer(){
    sudo docker run --detach \
	  --hostname gitlab.example.com \
	  --publish 8443:443 --publish 80:80 --publish 10022:22 \
	  --name ${serverName} \
	  --restart always \
	  --volume /var/lib/docker/volumes/gitlab-data/etc:/etc/gitlab \
	  --volume /var/lib/docker/volumes/gitlab-data/log:/var/log/gitlab \
	  --volume /var/lib/docker/volumes/gitlab-data/data:/var/opt/gitlab \
	  --shm-size 256m \
	  ${imageName}
}

runningCount=`docker ps -f status=running -f status=restarting | grep -w ${serverName} |wc -l`;
if [[ ${runningCount} > 0 ]];then
    echo "docker restart 重启项目：${serverName}"
    docker restart ${serverName}
    exit 0
fi

serverCount=`docker ps -f status=exited -f status=created | grep -w ${serverName} |wc -l`;
# 判断是否已经启动过，且端口为默认端口
if [[ ${serverCount} > 0 ]];then
    if [[ ${serverCount} > 1 ]]; then
        echo "Error : 查找到多个 ${serverName} 容器，请手动启动"
        exit 1
    else
        echo "docker start 启动项目：${serverName}"
        docker start ${serverName}
    fi
else
    name=${imageName%%:*}
    tag=${imageName##*:}
    # 判断是否有该镜像
    imageCount=`docker images | grep -w ${name} | wc -l`;

    if [[ ${imageCount} > 0 ]];then
        echo "docker run 第一次启动项目: ${imageName}"
        runServer
    else
        echo "Error : 还没有该镜像"
        exit 1
    fi
fi
