#!/bin/sh

timestanp=`date '+%Y-%m-%d %H:%M:%S'`

ps -ef | grep trade | awk '{print $2}' | xargs kill -9 &>/dev/null 2>2.xt
rm -rf /root/running.lock

sleep 5
nohup php /dobi/shell/Cli.php request_uri=/Cli_trade/run $timestanp >11.txt 2>222.txt &


echo 'timer...'$timestanp >> /tmp/1.txt

exit
