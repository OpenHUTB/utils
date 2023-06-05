#!/bin/bash
# /usr/bin/cpulimit_daemon.sh
# ==============================================================
# CPU limit daemon - set PID's max. percentage CPU consumptions
#
# 参考：https://github.com/losywee/cpulimit-ubuntu/blob/master/cpulimit_daemon.sh
# vi /etc/rc.local
# nohup /data2/whd/workspace/AI/tools/shell/cpulimit_daemon.sh >/dev/null 2>/dev/null &
# ==============================================================

# Variables
CPU_LIMIT=55            # Maximum percentage CPU consumption by each PID
DAEMON_INTERVAL=1       # Daemon check interval in seconds

# Search and limit violating PIDs
while sleep $DAEMON_INTERVAL
do
   # 新的违反规则（进程名不包括cpulimit、CPU使用率大于55.0、用户名不是d或者root）的进程号
   NEW_PIDS=$(ps aux | grep -v "cpulimit" | awk '{if($3>55.0 && $1!="d" && $1!="root") print $2}')                                                                    # Violating PIDs
   # 已经被限制的进程（需要剔除）
   # -e: Select all processes
   # -o: format; args: command with all its arguments as a string（将 带所有参数的命令 作为一个字符串）
   #     进程名($1)为cpulimit，输出第三个参数（进程号）: cpulimit -p 1691 -l 55 -z
   LIMITED_PIDS=$(ps -eo args | gawk '$1=="cpulimit" {print $3}')                                          # Already limited PIDs
   # man: 当前查询需要重新限制的进程
   # 第 1 列仅是在第 1 个文件中出现过的列
   # -2(3) 不显示只在第 2(3) 个文件里出现过的列。
   # sort -u: unique
   QUEUE_PIDS=$(comm -23 <(echo "$NEW_PIDS" | sort -u) <(echo "$LIMITED_PIDS" | sort -u) | grep -v '^$')   # PIDs in queue comm - 23只显示在第一个文件中出现而未在第二个文件中出现的行；

   for i in $QUEUE_PIDS
   do
       cpulimit -p $i -l $CPU_LIMIT -z &   # Limit new violating processes
   done
done
