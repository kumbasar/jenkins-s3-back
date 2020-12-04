#!/bin/bash

# Jenkins home
JENKINS_HOME="/jenkins_data"

# S3 bucket url
BUCKETURL="s3://kumbasar-jenkins-backup""

TIMESTAMP=`date +%Y-%m-%d_%H-%M-%S`
FILE="jenkins-${TIMESTAMP}.tar"

if [ -z ${1+x} ] 
then 
    echo "Using default JENKINS_HOME=${JENKINS_HOME}"
else
    JENKINS_HOME="$1"
    echo "Set JENKINS_HOME=${JENKINS_HOME}"
fi

echo "Backup Jenkins config files to ${FILE}.gz"

cd $JENKINS_HOME 

sudo find -maxdepth 1 -name '*.xml' -exec tar -rvf $FILE {} \;
sudo find ./jobs -maxdepth 5 -name 'config.xml' -exec tar -rvf $FILE {} \;
sudo find ./plugins -name '*.jpi' -exec tar -rvf $FILE {} \;
sudo find ./users -name 'config.xml' -exec tar -rvf $FILE {} \;

sudo chmod 777 $FILE
sudo gzip $FILE

echo "Upload the backup to S3 bucket"
aws s3 cp "${FILE}.gz" $BUCKETURL --storage-class ONEZONE_IA

echo "Delete local ${FILE}.gz file"
sudo rm -rf "${FILE}.gz"

echo "Done. Have a nice day!"
