#!/bin/bash
#cli_*重启&监控脚本
#日志文件
file_name="./cli.log"
proc_date=`date "+%Y%m%d"`

proc_name=("/Cli_Email/run" "/Cli_Third/run/key/btc_rmb_price" "/Cli_Third/run/key/eth_rmb_price" "/Cli_recordip/run" "/Cli_Sqldeal/run" "/Cli_Third/run/key/ebtcotc_price")


#启动脚本命令
function start()
{
cd /dobi/shell
nohup php Cli.php request_uri=$1 &
}

case "$1" in
check)
#单纯检查脚本是否存在
for proc in ${proc_name[@]}
do
proc_space=${proc//,/ }
number=`ps -ef | grep "$proc_space" | grep -v grep | wc -l`
# 判断进程是否存在
if [ $number -eq 0 ]
then
start $proc
pid=`ps -ef | grep "$proc_space" | grep -v grep | awk '{print $2}'`
# 将新进程号和重启时间记录
echo $pid, `date` >> $file_name
fi
done
;;
stop)
for proc in ${proc_name[@]}
do
proc_space=${proc//,/ }
#获取进程号
pid=`ps -ef | grep "$proc_space" | grep -v grep | awk '{print $2}'`
if [ $pid -ne 0 ]
then
kill -9 $pid
fi
done
;;
restart)
for proc in ${proc_name[@]}
do
proc_space=${proc//,/ }
#获取进程号
pid=`ps -ef | grep "$proc_space" | grep -v grep | awk '{print $2}'`
if [ $pid -ne 0 ]
then
kill -9 $pid
fi
number=`ps -ef | grep "$proc_space" | grep -v grep | wc -l`
#判断进程是否存在
if [ $number -eq 0 ]
then
sleep 2
start $proc
pid=`ps -ef | grep "$proc_space" | grep -v grep | awk '{print $2}'`
# 将新进程号和重启时间记录
echo $pid, `date` >> $file_name
fi
done
;;

*)
echo "it's need enter the param: check|restart"
exit 1
;;
esac
exit 0
