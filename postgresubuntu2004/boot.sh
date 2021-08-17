#!/bin/bash
  
# Start the first process
env > /etc/.cronenv

service cron start &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start cron: $status"
  exit $status
fi
echo "listen_addresses = '*'" >> /etc/postgresql/12/main/postgresql.conf
echo "host    all             all             172.17.0.1/8            md5" >> /etc/postgresql/12/main/pg_hba.conf
mv /var/lib/postgresql /var/lib/postgresql-docker-version
ln -s /data/postgresql-lib/ /var/lib/postgresql
#ln -s /var/lib/postgresql-mount /var/lib/postgresql

mv /etc/postgresql /etc/postgresql-docker-version
ln -s /data/postgresql-etc/ /etc/postgresql
#ln -s /etc/postgresql-mount /etc/postgresql

mv /etc/postgresql-common /etc/postgresql-common-docker-version
ln -s /data/postgresql-common-etc/ /etc/postgresql-common
#ln -s /etc/postgresql-common-mount /etc/postgresql-common


mv /var/log/postgresql /var/log/postgresql-docker-version
ln -s /data/postgresql-log /var/log/postgresql
#ln -s /var/log/postgresql-mount /var/log/postgresql
chown root.postgres /data/postgresql-log
chmod 775 /data/postgresql-log
chmod 775 /data/postgresql-log
#chown root.postgres /var/log/postgresql-mount
#chmod 775 /var/log/postgresql-mount
#chmod +t /var/log/postgresql-mount



# Start the second process
service postgresql start &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start apache2: $status"
  exit $status
fi
bash
