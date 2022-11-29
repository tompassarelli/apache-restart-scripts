#!/bin/bash
MYFQDN="www.company.com";
MYTITLE="company";
MYHOST="www";
MYTLD="com";
MY_APACHE_LOG="/var/log/apache2/company-access.log";
ADMIN_EMAIL="youremail@example.com"
DATESTAMP=`date +"%d-%m-%y"`;
CHECK_LOG=/root/${MYFQDN}-apache-access-log-${DATESTAMP}.log
 
# inspect last 100 logs and parse errors, if > 10% restart server later
# we want to overwrite the log so we are only keeping track of recent errors
tail -100 ${MY_APACHE_LOG} | awk '($9 ~ /500/)' | > ${CHECK_LOG};
tail -100 ${MY_APACHE_LOG} | awk '($9 ~ /503/)' | > ${CHECK_LOG};

 
ERRORS = $(cat $CHECK_LOG | tail -11)
ERROR_COUNT = $($LAST_ERRORS | wc -l)
if [ $ERRORS gt 10 ] 
  systemctl restart httpd
  systemctl restart php-fpm
  systemctl restart mysqld
  /bin/mail -s "server halted, server will restart" "you@YourEmailAddress" < textBody.letter
fi
