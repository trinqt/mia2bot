#!/data/data/com.termux/files/usr/bin/bash

# Bật SSH server
echo "Bật SSH server..."
sshd

# Lấy địa chỉ IP của máy và gửi vào Telegram bot
IP=$(hostname -I | awk '{print $1}')
echo "IP hiện tại: $IP"

# Gửi IP vào Telegram bot (bạn cần thay thế TOKEN và CHAT_ID)
TOKEN="7661043177:AAEL1xO9C1O4vMnr705gZvPPRMh5JN26VHk"
CHAT_ID="5197540151"
curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" -d chat_id=$CHAT_ID -d text="IP hiện tại của bạn là: $IP"

# Chạy bot (nếu có)
cd $HOME/botmia2
python bot.py

# Hoặc nếu bạn dùng các dịch vụ khác, ví dụ chạy bot Telegram từ GitHub
# git pull
# python bot.py
