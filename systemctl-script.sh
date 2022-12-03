#!/bin/bash
HTTP_STATUS = systemctl show httpd | grep StatusText | cut -d "=" -f2

if [ $HTTP_STATUS != "Running" ]; then
  systemctl restart httpd;
  systemctl restart php-fpm;
  systemctl restart mysqld;
  #/bin/mail -s "server halted, server will restart" "you@YourEmailAddress" < textBody.letter
fi

# cron info:
# first chmod 755 systemctl-script.sh (enable script execute permissions)
# then
# run crontab -e
# enter */10  *  *  *  *  /path/to/systemctl-script.sh (every 10 minutes)
# if the restart fails, see https://upcloud.com/resources/tutorials/fix-common-problems-apache2
