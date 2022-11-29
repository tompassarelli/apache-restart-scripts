#!/bin/bash
HTTP_STATUS = systemctl show httpd | grep StatusText | cut -d "=" -f2

if [ $HTTP_STATUS != "Running" ]; then
  systemctl restart httpd
  systemctl restart php-fpm
  systemctl restart mysqld
  /bin/mail -s "server halted, server will restart" "you@YourEmailAddress" < textBody.letter
fi
