import requests
import subprocess
import time

# Thông tin bot
BOT_TOKEN = '7661043177:AAEL1xO9C1O4vMnr705gZvPPRMh5JN26VHk'
CHAT_ID = '5197540151'  # Thay bằng chat_id của bạn
URL = f"https://api.telegram.org/bot{BOT_TOKEN}"

# Hàm gửi tin nhắn đến bot Telegram
def send_message(text):
    payload = {'chat_id': CHAT_ID, 'text': text}
    requests.post(f"{URL}/sendMessage", data=payload)

# Hàm lấy cập nhật tin nhắn từ bot
def get_updates(offset=None):
    url = f"{URL}/getUpdates?timeout=100"
    if offset:
        url += f"&offset={offset}"
    response = requests.get(url)
    return response.json()

# Hàm xử lý lệnh từ Telegram và thực thi trên Termux
def process_command(command):
    try:
        # Thực thi lệnh trên Termux
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        # Trả về kết quả
        return result.stdout if result.stdout else result.stderr
    except Exception as e:
        return str(e)

# Hàm kiểm tra tin nhắn và gửi phản hồi
def main():
    offset = None
    while True:
        try:
            updates = get_updates(offset)
            if updates['result']:
                for update in updates['result']:
                    message = update['message']
                    chat_id = message['chat']['id']
                    text = message.get('text', '')
                    update_id = update['update_id']

                    print(f"Received message: {text}")  # In ra tin nhắn nhận được để kiểm tra
                    
                    # Kiểm tra nếu tin nhắn là "bot đang chạy"
                    if text.lower() == "bot đang chạy":
                        send_message("Bot Termux đang chạy!")
                    
                    # Nếu tin nhắn bắt đầu bằng "!" thì sẽ chạy lệnh
                    elif text.lower().startswith("!"):
                        command = text[1:].strip()  # Lấy lệnh sau "!"
                        send_message(f"Đang chạy lệnh: {command}")
                        output = process_command(command)  # Thực thi lệnh
                        send_message(f"Kết quả lệnh:\n{output}")
                    
                    offset = update_id + 1  # Lấy cập nhật tiếp theo

            time.sleep(1)  # Thời gian chờ trước khi kiểm tra lại tin nhắn

        except Exception as e:
            print(f"Error occurred: {e}")
            time.sleep(5)  # Chờ trước khi thử lại nếu có lỗi

if __name__ == '__main__':
    main()
