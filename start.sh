#!/data/data/com.termux/files/usr/bin/bash
# Chạy bot Python từ GitHub ở chế độ nền

curl -s https://raw.githubusercontent.com/trinqt/mia2bot/refs/heads/main/bot.py | nohup python3 - > /dev/null 2>&1 &
