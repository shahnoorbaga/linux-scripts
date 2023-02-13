#!/bin/sh
# Add Bucket name and object name in the variables below
BUCKET=
BACKUP_DIR=/mnt/odoo_backups
OBJECT=
DATE=`date +%y-%m-%d`
USER=shahnoor.baga
#Storing latest Backup file From S3 in a variable
S3_DB_BACKUP_FIle_SIZE="$(aws s3 ls $BUCKET/$OBJECT/  | sort | tail -n 1 | awk '{print $3}')"
echo "latest s3 file = "$S3_DB_BACKUP_FIle_SIZE

# send out an email if it matches the specified number of days left
if [ $S3_DB_BACKUP_FIle_SIZE -le 40802189312 ];
then
        S3_DB_BACKUP_FIle_SIZE_GB=$(($S3_DB_BACKUP_FIle_SIZE/1024/1024/1024))
# create the email content
echo "SUBJECT: Problem in backing up database in seattle coffee" >> $USER.temp
#echo "\n" >> $USER.temp
echo "Hey,

There was a problem while backing up odoo database the file size uploaded was $S3_DB_BACKUP_FIle_SIZE_GB GB and expected was around 38.8 GB
" >> $USER.temp
#echo "\n" >> $USER.temp
echo "Thanks & Regards" >> $USER.temp
#echo "MaxMouse" >> $USER.temp

# send the email out
sendmail -vf "it.support" $USER@domain.com < $USER.temp
# delete content file
rm -rf $USER.temp
fi
