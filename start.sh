#!/data/data/com.termux/files/usr/bin/bash

# Thông số Telegram Bot
BOT_TOKEN="7661043177:AAEL1xO9C1O4vMnr705gZvPPRMh5JN26VHk"
CHAT_ID="5197540151"
SSH_PORT=8022
USERNAME=$(whoami)

# Khởi động SSH nếu chưa chạy
if ! pgrep -x sshd >/dev/null; then
  sshd
  sleep 2
fi

# Lấy IP (fallback qua hostname -I)
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Nếu vẫn trống, thử ip route
if [ -z "$IP_ADDRESS" ]; then
  IP_ADDRESS=$(ip route get 8.8.8.8 | awk '{for(i=1;i<=NF;i++) if($i=="src") print $(i+1)}')
fi

# Chuẩn bị câu lệnh SSH
SSH_CMD="ssh -p $SSH_PORT $USERNAME@$IP_ADDRESS"

# Gửi nguyên lệnh SSH qua Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
  -d chat_id="$CHAT_ID" \
  -d text="$SSH_CMD"

echo "Đã gửi: $SSH_CMD"
