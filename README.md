# ☁️ MongoDB Scheduled Backups to Cloudflare R2

## 📌 Project Overview

This project demonstrates how to automatically back up a MongoDB database every 12 hours and upload the backup to **Cloudflare R2**, an S3-compatible object storage service. The setup uses shell scripts and cron jobs (or optionally GitHub Actions) to automate the process and includes a restore script for disaster recovery.

---

## 🧱 Components

- **MongoDB**: The database to back up
- **Cloudflare R2**: Destination for backup storage
- **AWS CLI**: Used to interact with the R2 bucket
- **Shell Scripts**:
  - `backup.sh`: Dumps and uploads the backup
  - `restore.sh`: Downloads and restores the latest backup
  - `setup.sh`: Prepares the system for automated backups
  - `cleanup.sh`: Removes backup-related configurations
  - `test_backup.sh`: Simulates load and runs a test backup
- **Cron Job**: Schedules `backup.sh` to run every 12 hours

---

## ⚙️ Setup Steps

1. **Provision a Linux Server**  
   Use DigitalOcean, AWS, or any cloud provider to create a Linux VM.

2. **Install MongoDB**  
   Ensure `mongod` is running and seed it with sample data for testing.

3. **Create a Cloudflare R2 Bucket**  
   - Go to Cloudflare Dashboard → R2
   - Create a bucket (e.g., `mongo-backups`)
   - Generate an **Access Key** and **Secret Key**
   - Note the bucket endpoint (e.g., `https://<account>.r2.cloudflarestorage.com`)

4. **Install & Configure AWS CLI**
   - Install via `sudo apt install awscli -y`
   - Run `aws configure` and enter your R2 credentials
   - Edit `~/.aws/config` to include the R2 endpoint under a named profile

5. **Clone this Repository and Configure Scripts**
   - Modify `backup.sh` and `restore.sh` with your bucket name and profile
   - Make all scripts executable: `chmod +x *.sh`

6. **Test a Manual Backup**
   Run `./backup.sh` and verify the backup exists in your R2 bucket.

7. **Schedule Automatic Backups**
   Add this to your crontab (`crontab -e`):

   ```
   0 */12 * * * /path/to/backup.sh >> /var/log/mongo_backup.log 2>&1
   ```

---

## 🔁 Optional GitHub Actions Workflow

Instead of using `cron`, you can use GitHub Actions to run backups on a schedule. Store your R2 credentials in the repo’s GitHub Secrets and set up a `.github/workflows/backup.yml` file accordingly.

---

## 🧪 Restore Workflow (Stretch Goal)

You can use `restore.sh` to:
- Find the most recent backup in R2
- Download and extract it
- Restore the dump using `mongorestore`

This can be useful for simulating disaster recovery.

---

https://roadmap.sh/projects/automated-backups