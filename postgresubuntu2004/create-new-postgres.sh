#!/bin/bash

cp -Rp /var/lib/postgresql-docker-version /data/postgresql-lib/
cp -Rp /etc/postgresql-docker-version /data/postgresql-etc
cp -Rp /etc/postgresql-common-docker-version /data/postgresql-common-etc
cp -Rp /var/log/postgresql-docker-version /data/postgresql-log
echo "Copied postgres files to shared directory"



#mv /var/lib/postgresql /var/lib/postgresql-docker-version
#ln -s /data/postgresql-lib/ /var/lib/postgresql
#ln -s /var/lib/postgresql-mount /var/lib/postgresql

#mv /etc/postgresql /etc/postgresql-docker-version
#ln -s /data/postgresql-etc/ /etc/postgresql
#ln -s /etc/postgresql-mount /etc/postgresql

#mv /etc/postgresql-common /etc/postgresql-common-docker-version
#ln -s /data/postgresql-common-etc/ /etc/postgresql-common
#ln -s /etc/postgresql-common-mount /etc/postgresql-common


#mv /var/log/postgresql /var/log/postgresql-docker-version
#ln -s /data/postgresql-log /var/log/postgresql

