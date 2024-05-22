# HashGuard

## Overview

**HashGuard** is a robust, real-time file integrity monitoring tool designed for Linux systems and optimized for deployment on a Raspberry Pi. It continuously monitors a specified directory for new or modified files, calculates their SHA-256 hashes, and verifies these hashes against expected values. This ensures that any unauthorized changes to your files are detected immediately and that users are promptly notified.

## Features

- **Real-Time Monitoring:** Continuously monitors a specified directory for file changes.
- **SHA-256 Hash Verification:** Computes and verifies file hashes to ensure integrity.
- **Detailed Logging:** Logs all file activities, including verifications and alerts, with timestamps, file sizes, and user information.
- **Email Notifications:** Sends email alerts for successful verifications and detected discrepancies, keeping you informed of potential issues instantly.
- **Exclusions:** Skips temporary and irrelevant files, such as those with `.crdownload` extensions or containing "Chromium" in their names.

## Why Use a Raspberry Pi?

The Raspberry Pi is chosen for this project due to its numerous advantages:

- **Cost-Effective:** Raspberry Pi is an affordable option compared to traditional computers, making it accessible for many users.
- **Energy Efficient:** It consumes less power, which is ideal for a project that runs continuously.
- **Compact and Portable:** Its small size allows it to be easily integrated into various environments without taking up much space.
- **Versatile:** Capable of running a full Linux operating system, it supports the necessary tools and software required for this project.
- **Community Support:** The Raspberry Pi has a large and active community, providing ample resources and support for troubleshooting and enhancements.

These features make the Raspberry Pi an excellent choice for a dedicated file integrity monitoring system.

## Requirements

- Raspberry Pi with a Linux-based OS (e.g., Raspbian)
- `inotify-tools` for real-time monitoring
- `msmtp` for sending email notifications
- Access to an email account for notifications (configured for Outlook in this example)

## Installation

1. **Set up your Raspberry Pi:**
   - Install a Linux-based OS (e.g., Raspbian).
   - Ensure your Raspberry Pi is connected to the internet.

2. **Install `inotify-tools` and `msmtp`:**
   ```bash
   sudo apt-get update
   sudo apt-get install inotify-tools msmtp
   ```

3. **Clone this repository:**
   ```bash
   git clone https://github.com/yourusername/HashGuard.git
   cd HashGuard
   ```

4. **Configure `msmtp` for email notifications:** Edit `~/.msmtprc` with your email settings.

## Configuration

Edit the script variables in `hashguard.sh` to suit your needs:
- `monitor_dir`: The directory to monitor (e.g., `/home/yourusername/Downloads`).
- `log_file`: The file where logs will be stored.
- `expected_hash_file`: The file storing expected hashes.
- `recipient_email`: Your email for receiving notifications.
- `subject`: The subject line for your email notifications.

## Usage

Make the script executable and run it:
```bash
chmod +x hashguard.sh
./hashguard.sh
```

## How It Works

1. The script uses `inotifywait` to monitor the specified directory for `close_write` events.
2. For each new or modified file, it calculates the SHA-256 hash.
3. It checks the calculated hash against the expected hash stored in `expected_hashes.txt`.
4. If the file is new, it adds the hash to `expected_hashes.txt`.
5. It logs each action with detailed information, including timestamps, file sizes, and user information.
6. It sends email notifications for successful verifications and discrepancies.


Events log file (example:
![Screenshot 2024-05-22 163500](https://github.com/Muktansh02/HashGuard/assets/124135961/ddc675e1-f1d6-4ed8-8d95-6ad655afd893)

File detection mail (example):
![Screenshot 2024-05-22 174211](https://github.com/Muktansh02/HashGuard/assets/124135961/c36ab77a-7d05-44db-999e-4c211b365914)

File verification mail (example):
![Screenshot 2024-05-22 174228](https://github.com/Muktansh02/HashGuard/assets/124135961/a3686fc7-28a0-4f54-8d99-35a88d5dce46)


## Future Plans

- Implement a web interface for real-time monitoring.
- Add support for additional hash algorithms.
- Integrate with cloud storage solutions for remote monitoring.

## Contributions

Contributions are welcome! Please fork this repository and submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License.

---

## Detailed Instructions to Set Up HashGuard on a Raspberry Pi

### Step-by-Step Guide

1. **Set Up Your Raspberry Pi:**
   - Install Raspbian OS on your Raspberry Pi.
   - Ensure the Raspberry Pi is connected to the internet.

2. **Install Required Packages:**
   ```bash
   sudo apt-get update
   sudo apt-get install inotify-tools msmtp
   ```

3. **Clone the HashGuard Repository:**
   ```bash
   git clone https://github.com/yourusername/HashGuard.git
   cd HashGuard
   ```

4. **Configure Email Notifications:**
   - Create and edit the `~/.msmtprc` file with your email settings.
   ```bash
   nano ~/.msmtprc
   ```
   - Example configuration for Outlook:
   ```
   account default
   host smtp.office365.com
   port 587
   auth on
   user your-email@outlook.com
   password your-password
   tls on
   tls_starttls on
   tls_trust_file /etc/ssl/certs/ca-certificates.crt
   logfile ~/.msmtp.log
   ```

5. **Make the `hashguard.sh` Script Executable:**
   ```bash
   chmod +x hashguard.sh
   ```

6. **Run the Script:**
   ```bash
   ./hashguard.sh
   ```


With these instructions, you can set up HashGuard on a Raspberry Pi to automatically monitor and verify the integrity of downloaded files, sending notifications and logging events as required. This setup leverages the Raspberry Pi's advantages to provide an efficient, cost-effective, and reliable file integrity monitoring solution.
