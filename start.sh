#!/data/data/com.termux/files/usr/bin/bash

echo "🔐 Bật SSH..."
sshd
sleep 2

# Lấy IP
IP=$(curl -s ifconfig.me)
USER_ID=$(id -u)
MSG="IP hiện tại của bạn là:\n\nssh -p 8022 u0_a${USER_ID}@${IP}"

# Gửi IP qua Telegram bot
curl -s "https://api.telegram.org/bot7661043177:AAEL1xO9C1O4vMnr705gZvPPRMh5JN26VHk/sendMessage" \
  -d "chat_id=5197540151" -d "text=$MSG"
  
