#!/bin/bash
  
# Start the first process
export VISUAL=vim
export EDITOR="$VISUAL"
chmod 777 /data
env > /etc/.cronenv
rm /etc/cron.d/dockercron

# catchall email
echo "myhostname = ${POSTFIX_MAIL_HOST}" >> /etc/postfix/main.cf
echo "relayhost = ${POSTFIX_RELAY_HOST}" >> /etc/postfix/main.cf
echo "/.*@.*/ ${POSTFIX_CATCHALL_EMAIL}" > /etc/postfix/virtual
echo "/^Subject:/ WARN" > /etc/postfix/header_checks
postmap /etc/postfix/header_checks
postmap /etc/postfix/sasl/sasl_passwd
postmap /etc/postfix/virtual
# catchall email

CONFIG_LOCATION=/etc/docker-image-configs/
SCREEN_FILE=.screenrc
BASH_RC_FILE=.bashrc
HOME_DIR=/data/
if [ -f "$HOME_DIR$SCREEN_FILE" ]; then
   echo "$SCREEN_FILE exists."
else
   cp $CONFIG_LOCATION$SCREEN_FILE $HOME_DIR
fi

if [ -f "$HOME_DIR$BASH_RC_FILE" ]; then
   echo "$SCREEN_FILE exists."
else
   cp $CONFIG_LOCATION$BASH_RC_FILE $HOME_DIR
fi


ln -s /etc/contanercron/dockercron /etc/cron.d/dockercron
service cron start &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start cron: $status"
  exit $status
fi

# Start the second process
cp /etc/postfix-conf/sasl_passwd /etc/postfix/sasl/
#cp /etc/postfix-conf/main.cf /etc/postfix/
echo container > /etc/mailname
#postmap /etc/postfix/sasl/sasl_passwd

service syslog-ng start &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start syslog-ng: $status"
  exit $status
fi


service postfix start &
status=$?
if [ $status -ne 0 ]; then
	  echo "Failed to start postfix: $status"
    exit $status
fi

# Start the second process
service ssh start &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start ssh: $status"
  exit $status
fi

#/sbin/rpcbind
#service nfs-kernel-server start &
#status=$?
#if [ $status -ne 0 ]; then
#  echo "Failed to start nfs: $status"
#  exit $status
#fi

ifconfig eth0:1 10.17.0.1 up
bash
