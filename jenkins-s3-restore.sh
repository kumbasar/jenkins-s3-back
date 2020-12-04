#!/bin/bash

JENKINS_HOME="/mnt/jenkins_data"
BUCKETURL="s3://kumbasar-jenkins-backup"

if [ -z ${1+x} ] 
then 
    echo "List all backup files"
    aws s3 ls $BUCKETURL
else
    FILE="$1"
    echo "Copying ${FILE} from bucket"
    aws s3 cp $BUCKETURL/$FILE .
fi

echo "Done. Have a nice day!"