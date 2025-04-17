import subprocess
import re
import requests
import socket

# === CẤU HÌNH TELEGRAM ===
BOT_TOKEN = '7661043177:AAEL1xO9C1O4vMnr705gZvPPRMh5JN26VHk'
CHAT_ID = '5197540151'

# === HÀM KIỂM TRA CỔNG ĐÃ MỞ ===
def is_ssh_running(port=8022):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(1)
    try:
        s.connect(("127.0.0.1", port))
        s.close()
        return True
    except Exception:
        return False

# === KHỞI ĐỘNG SSH (NẾU CẦN) ===
if is_ssh_running():
    print("SSH server đã chạy.")
else:
    print("Đang khởi động SSH server...")
    subprocess.run(["sshd"])

# === CHẠY CLOUDFLARE TUNNEL ===
print("Đang khởi chạy Cloudflare Tunnel...")
process = subprocess.Popen(
    ["cloudflared", "tunnel", "--url", "ssh://localhost:8022"],
    stdout=subprocess.PIPE,
    stderr=subprocess.STDOUT,
    text=True
)

# === TÌM LINK PUBLIC ===
tunnel_link = None
for line in process.stdout:
    print(line.strip())
    match = re.search(r"https://.*?\.trycloudflare\.com", line)
    if match:
        tunnel_link = match.group(0)
        break

# === GỬI LINK QUA TELEGRAM ===
if tunnel_link:
    msg = f"ssh u0_a123@tunnel_link} -p 8022"
    url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
    data = {"chat_id": CHAT_ID, "text": msg}
    requests.post(url, data=data)
    print("Đã gửi link vào Telegram.")
else:
    print("Không tìm thấy link tunnel.")