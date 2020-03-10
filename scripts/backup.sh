#! /bin/sh

echo "Creating dump of ${REMOTE_POSTGRES_DB} database from ${REMOTE_POSTGRES_HOST} ..."
DATE=`date +%Y-%m-%d`
BACKUP_FILE=${REMOTE_POSTGRES_DB}-`date +%Y-%m-%d-%H%M%S`.sql
PGPASSWORD=${REMOTE_POSTGRES_PASSWORD} pg_dump -h ${REMOTE_POSTGRES_HOST} -U ${REMOTE_POSTGRES_USER} -d ${REMOTE_POSTGRES_DB} > ./${BACKUP_FILE}

echo "Copying dump ${BACKUP_FILE} to ${POSTGRES_BACKUP_BUCKET}-${DATE}"
aws s3 cp ${BACKUP_FILE} s3://${POSTGRES_BACKUP_BUCKET}/${DATE}/
rm -f ${BACKUP_FILE}