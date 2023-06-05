#!/bin/bash
# cp startup.sh /etc/init.d/

# cd /etc/init.d/
# 将脚本添加到启动脚本 (这里90表明一个优先级，越高表示执行的越晚)
# update-rc.d run_server defaults 90

# 移除脚本
# update-rc.d -f run_server.sh remove
