# Jenkins S3 backup script

A fancy script to backup jenkins server to AWS S3.

# Backup

Update below variables in `jenkins-s3-backup.sh`:

- `JENKINS_HOME`: Your Jenkins home
- `BUCKETURL`: Your AWS S3 URL

Now, execute below script to backup Jenkins's config files and plugins:

```bash
./jenkins-s3-backup.sh
```

# Restore

Todo