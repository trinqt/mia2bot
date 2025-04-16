from flask import Flask, render_template, redirect, url_for
import os
import socket
import subprocess

app = Flask(__name__)

# Gửi thông tin SSH qua Telegram
def send_telegram(msg):
    token = "7661043177:AAEL1xO9C1O4vMnr705gZvPPRMh5JN26VHk"
    chat_id = "5197540151"
    os.system(f"curl -s 'https://api.telegram.org/bot{token}/sendMessage?chat_id={chat_id}&text={msg}'")

# Lấy IP nội bộ
def get_ip():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        s.connect(('8.8.8.8', 80))
        ip = s.getsockname()[0]
    except:
        ip = '127.0.0.1'
    s.close()
    return ip

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/start_ssh')
def start_ssh():
    os.system("sshd")
    ip = get_ip()
    cmd = f"ssh -p 8022 $(whoami)@{ip}"
    send_telegram(f"📡 SSH Started: `{cmd}`")
    return redirect(url_for('index'))

@app.route('/start_bot')
def start_bot():
    os.system("pkill -f bot.py; nohup python $HOME/myenv/bot.py &")
    return redirect(url_for('index'))

@app.route('/restart')
def restart():
    os.system("reboot")
    return "Đang khởi động lại..."

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
