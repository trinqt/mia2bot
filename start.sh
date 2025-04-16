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

# Tạo thư mục tạm nếu chưa có
mkdir -p ~/mia2tmp

# Tải bot.py mới nhất từ GitHub
curl -sL https://raw.githubusercontent.com/trinqt/mia2bot/main/bot.py -o ~/mia2tmp/bot.py

# Chạy bot
echo "🤖 Đang chạy bot telegram từ GitHub..."
nohup python ~/mia2tmp/bot.py &

# Tải và chạy Cloudflare Tunnel (nếu cần)
cloudflared tunnel run mia2bot
