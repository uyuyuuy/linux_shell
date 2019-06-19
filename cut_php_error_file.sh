#!/bin/bash

mv_log_dir='/var/log/php/'
file_name=$(date -d '-1day' +'%Y-%m-%d')
log_file="$mv_log_dir$file_name".txt
mv /var/log/php/error.log ${log_file}
exit 0
