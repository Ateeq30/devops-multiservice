#!/bin/bash

echo "🔥 Starting safe cleanup..."

# 1️⃣ Docker cleanup
echo "Cleaning Docker..."
docker system prune -a -f
docker volume prune -f

# 2️⃣ Snap old revisions
echo "Cleaning old Snap revisions..."
for snap_rev in $(snap list --all | grep disabled | awk '{print $1":"$3}'); do
    snap_name=$(echo $snap_rev | cut -d':' -f1)
    snap_version=$(echo $snap_rev | cut -d':' -f2)
    echo "Removing $snap_name revision $snap_version"
    sudo snap remove "$snap_name" --revision "$snap_version"
done

# 3️⃣ Clean logs
echo "Cleaning logs..."
sudo journalctl --vacuum-time=1d
sudo rm -rf /var/log/*.gz
sudo rm -rf /var/log/*.[0-9]

# 4️⃣ Clean temp files
echo "Cleaning /tmp..."
sudo rm -rf /tmp/*

# 5️⃣ Clean apt cache
echo "Cleaning APT cache..."
sudo apt clean

echo "✅ Cleanup completed!"
df -h
