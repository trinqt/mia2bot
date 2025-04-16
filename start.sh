#!/data/data/com.termux/files/usr/bin/bash

echo "🔐 Bật SSH server..."
sshd

sleep 2

# Lấy địa chỉ IP
IP=$(curl -s ifconfig.me)
USER_ID=$(id -u)
MSG="IP hiện tại của bạn là:\n\nssh -p 8022 u0_a${USER_ID}@${IP}"

# Gửi IP qua Telegram bot
curl -s "https://api.telegram.org/bot7661043177:AAEL1xO9C1O4vMnr705gZvPPRMh5JN26VHk/sendMessage" \
  -d "chat_id=5197540151" -d "text=$MSG"

# Di chuyển vào thư mục bot
cd ~/mia2bot || exit

# Chạy bot telegram
echo "🤖 Đang chạy bot telegram..."
nohup python bot.py &

# Chạy Cloudflare Tunnel
echo "🌐 Đang khởi chạy Cloudflare Tunnel..."
cloudflared tunnel run mia2bot
