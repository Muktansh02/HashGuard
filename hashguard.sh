#!/bin/bash

# Directory to monitor
monitor_dir="/home/mishu/Downloads"

# Log file
log_file="event_log.txt"

# Expected hash file
expected_hash_file="expected_hashes.txt"

# Email settings
recipient_email="e22bcau0005@bennett.edu.in"
subject="HashGuard Notification"

while true; do
  inotifywait -e close_write -r "$monitor_dir" 2>/dev/null
  # New file detected or file modified, calculate hash
  while IFS= read -r -d '' file; do
    # Skip files with .crdownload extension or containing "Chromium" in the name
    if [[ "$file" == *.crdownload ]] || [[ "$file" == *Chromium* ]]; then
      continue
    fi

    hash_value=$(sha256sum "$file" | awk '{print $1}')
    date_time=$(date "+%Y-%m-%d %H:%M:%S")

    # Additional details - file size
    file_size=$(du -h "$file" | awk '{print $1}')

    # Additional details - user information (example, assuming the script is run by a user)
    user_info=$(whoami)

    # Check if the file has an entry in the expected hash file
    if grep -q "$file" "$expected_hash_file"; then
      expected_hash=$(grep "$file" "$expected_hash_file" | awk '{print $2}')
      if [ "$hash_value" == "$expected_hash" ]; then
        echo "$date_time: File $file verified successfully. Size: $file_size. User: $user_info." >> "$log_file"
        # Send email notification
        echo -e "Subject: $subject\n\nFile $file verified successfully. Size: $file_size. User: $user_info." | msmtp -a outlook -t "$recipient_email"
      else
        echo "$date_time: ALERT! File $file verification failed. Size: $file_size. User: $user_info." >> "$log_file"
        # Send email notification
        echo -e "Subject: $subject\n\nALERT! File $file verification failed. Size: $file_size. User: $user_info." | msmtp -a outlook -t "$recipient_email"
      fi
    else
      # File not found in expected hash file
      echo "$date_time: New file detected - $file. Size: $file_size. User: $user_info. Calculating hash and adding to expected hashes." >> "$log_file"
      full_path=$(realpath "$file")  # Get the full path
      echo "$full_path $hash_value" >> "$expected_hash_file"
      # Send email notification
      echo -e "Subject: $subject\n\nNew file detected: $file. Size: $file_size. User: $user_info." | msmtp -a outlook -t "$recipient_email"
    fi

  done < <(find "$monitor_dir" -type f \( ! -iname ".*" \) -not -name "*.crdownload" -print0)
done
 
