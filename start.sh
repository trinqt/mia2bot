#!/data/data/com.termux/files/usr/bin/bash

# Thông tin
SSH_PORT=8022
USERNAME="u0_a10161"
IP_ADDRESS="192.168.x.x"  # Thay thế bằng địa chỉ IP của Termux
TELEGRAM_BOT_TOKEN="7661043177:AAEL1xO9C1O4vMnr705gZvPPRMh5JN26VHk"
CHAT_ID="5197540151"

# Lắng nghe lệnh Telegram để điều khiển Termux (run command)
while true; do
  # Kiểm tra các lệnh gửi qua Telegram
  curl -s "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/getUpdates" | jq -r ".result[].message.text" | while read COMMAND; do
    # Thực thi lệnh
    RESULT=$(eval $COMMAND 2>&1)  # Thực thi và bắt lỗi nếu có
    # Gửi kết quả lệnh về Telegram
    curl -s -X POST https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage \
      -d chat_id=$CHAT_ID \
      -d text="Kết quả lệnh:\n$RESULT" \
      -d parse_mode=Markdown
  done
  # Gửi IP SSH về Telegram
  SSH_CMD="ssh -p $SSH_PORT $USERNAME@$IP_ADDRESS"
  curl -s -X POST https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage \
    -d chat_id=$CHAT_ID \
    -d text="SSH Command:\n$SSH_CMD" \
    -d parse_mode=Markdown
  # Chờ một khoảng thời gian để không gây quá tải API
  sleep 1
done
