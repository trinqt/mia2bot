#!/data/data/com.termux/files/usr/bin/bash

# Thông tin
TUNNEL_NAME="mia2bot"
SSH_PORT=8022
USERNAME="u0_a10161"
DOMAIN="ssh.trinqt.top"
TELEGRAM_BOT_TOKEN="7661043177:AAEL1xO9C1O4vMnr705gZvPPRMh5JN26VHk"
CHAT_ID="5197540151"

# Chạy Cloudflare Tunnel (nền)
nohup cloudflared tunnel run $TUNNEL_NAME > tunnel.log 2>&1 &

# Chờ vài giây để đảm bảo tunnel hoạt động
sleep 5

# Tạo link SSH
SSH_CMD="ssh -p $SSH_PORT $USERNAME@$DOMAIN"

# Gửi về Telegram
curl -s -X POST https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage \
  -d chat_id=$CHAT_ID \
  -d text="🔐 SSH Termux Ready:\n\`\`\`\n$SSH_CMD\n\`\`\`" \
  -d parse_mode=Markdown
