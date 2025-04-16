
#!/data/data/com.termux/files/usr/bin/bash

# Thông số Telegram Bot
BOT_TOKEN="7661043177:AAEL1xO9C1O4vMnr705gZvPPRMh5JN26VHk"
CHAT_ID="5197540151"

# Cổng SSH mặc định Termux
SSH_PORT=8022

# Tên user hiện tại
USERNAME=$(whoami)

# Khởi động SSH nếu chưa chạy
if ! pgrep -x sshd >/dev/null; then
  sshd
  sleep 2
fi

# Lấy IP (thay wlan0 nếu bạn dùng khác)
IP_ADDRESS=$(ip addr show wlan0 | grep 'inet ' | awk '{print $2}' | cut -d/ -f1)

# Tạo lệnh SSH
SSH_CMD="ssh -p $SSH_PORT $USERNAME@$IP_ADDRESS"

# Gửi nguyên lệnh SSH qua Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
  -d chat_id="$CHAT_ID" \
  -d text="$SSH_CMD"

# Thông báo đã gửi
echo "SSH command sent: $SSH_CMD"
