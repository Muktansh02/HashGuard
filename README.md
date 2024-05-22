HashGuard

Overview

HashGuard is a robust, real-time file integrity monitoring tool designed for Linux systems and optimized for deployment on a Raspberry Pi. It continuously monitors a specified directory for new or modified files, calculates their SHA-256 hashes, and verifies these hashes against expected values. This ensures that any unauthorized changes to your files are detected immediately and that users are promptly notified.

Features

- Real-Time Monitoring: Continuously monitors a specified directory for file changes.
- SHA-256 Hash Verification: Computes and verifies file hashes to ensure integrity.
- Detailed Logging: Logs all file activities, including verifications and alerts, with timestamps, file sizes, and user 
    information.
- Email Notifications: Sends email alerts for successful verifications and detected discrepancies, keeping you informed of 
    potential issues instantly.
- Exclusions: Skips temporary and irrelevant files, such as those with .crdownload extensions or containing "Chromium" in their 
    names.

Why Use a Raspberry Pi?

- Cost-Effective: Raspberry Pi is an affordable option compared to traditional computers, making it accessible for many users.
- Energy Efficient: It consumes less power, which is ideal for a project that runs continuously.
- Compact and Portable: Its small size allows it to be easily integrated into various environments without taking up much space.
- Versatile: Capable of running a full Linux operating system, it supports the necessary tools and software required for this 
    project.
- Community Support: The Raspberry Pi has a large and active community, providing ample resources and support for 
    troubleshooting and enhancements.


Requirements

- Raspberry Pi with a Linux-based OS (e.g., Raspbian)
- inotify-tools for real-time monitoring
- msmtp for sending email notifications
- Access to an email account for notifications (configured for Outlook in this example)

How It Works

- The script uses inotifywait to monitor the specified directory for close_write events.
- For each new or modified file, it calculates the SHA-256 hash.
- It checks the calculated hash against the expected hash stored in expected_hashes.txt.
- If the file is new, it adds the hash to expected_hashes.txt.
- It logs each action with detailed information, including timestamps, file sizes, and user information.
- It sends email notifications for successful verifications and discrepancies.

Events log file (example:
![Screenshot 2024-05-22 163500](https://github.com/Muktansh02/HashGuard/assets/124135961/ddc675e1-f1d6-4ed8-8d95-6ad655afd893)

File detection mail (example):
![Screenshot 2024-05-22 174211](https://github.com/Muktansh02/HashGuard/assets/124135961/c36ab77a-7d05-44db-999e-4c211b365914)

File verification mail (example):
![Screenshot 2024-05-22 174228](https://github.com/Muktansh02/HashGuard/assets/124135961/a3686fc7-28a0-4f54-8d99-35a88d5dce46)


Future Plans

- Implement a web interface for real-time monitoring.
- Add support for additional hash algorithms.
- Integrate with cloud storage solutions for remote monitoring.

Contributions

Contributions are welcome! Please fork this repository and submit a pull request for any improvements or bug fixes.

License

This project is licensed under the MIT License.
