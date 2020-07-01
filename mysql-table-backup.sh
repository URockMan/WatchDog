#!/bin/bash
 
################################################################
##
##   MySQL Database Backup Script 
##   Written By: Virat Puvvala
##   Last Update: July 01, 2020
##
##   #Add following settings to enable backup at 2 in the morning.
##	 0 2 * * * root /backup/mysql-backup.sh
################################################################
 
export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=`date +"%d%b%Y"`
 
################################################################
################## Update below values  ########################
 
DB_BACKUP_PATH='/backup/dbbackup'
MYSQL_HOST='wpaasdb.cydwunev2mr4.us-west-2.rds.amazonaws.com'
MYSQL_PORT='3306'
MYSQL_USER='wpadmin'
MYSQL_PASSWORD='wpadmin1234'
DATABASE_NAME='wpaascmdb'
TABLE_NAME='wp_track_softwares_installed'
 
#################################################################
 
mkdir -p ${DB_BACKUP_PATH}/${TODAY}
echo "Backup started for database - ${DATABASE_NAME}"
 
 
mysqldump -h ${MYSQL_HOST} \
   -P ${MYSQL_PORT} \
   -u ${MYSQL_USER} \
   -p${MYSQL_PASSWORD} \
   ${DATABASE_NAME} ${TABLE_NAME} | gzip > ${DB_BACKUP_PATH}/${TODAY}/${DATABASE_NAME}-${TABLE_NAME}-${TODAY}.sql.gz
 
if [ $? -eq 0 ]; then
  echo "Database backup successfully completed"
else
  echo "Error found during backup"
  exit 1
fi