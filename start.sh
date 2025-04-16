#!/data/data/com.termux/files/usr/bin/bash

# Telegram Bot credentials
BOT_TOKEN="7661043177:AAEL1xO9C1O4vMnr705gZvPPRMh5JN26VHk"
CHAT_ID="5197540151"

# SSH parameters
SSH_PORT=8022
USERNAME=$(whoami)

# Start SSH server if not running
if ! pgrep -x sshd >/dev/null; then
  sshd
  sleep 2
fi

# Determine current IP address
IP_ADDRESS=$(hostname -I | awk '{print $1}')
if [ -z "$IP_ADDRESS" ]; then
  IP_ADDRESS=$(ip route get 8.8.8.8 | awk '{for(i=1;i<=NF;i++) if($i=="src") print $(i+1)}')
fi

# Build SSH command
SSH_CMD="ssh -p $SSH_PORT $USERNAME@$IP_ADDRESS"

# Send the plain SSH command to Telegram
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
  -d chat_id="$CHAT_ID" \
  -d text="$SSH_CMD"

# Optional: print to stdout for debugging
echo "Sent to Telegram: $SSH_CMD"
