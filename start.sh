#!/bin/bash

# Khởi động Flask Server
cd $HOME/botmia2
nohup python web.py > /dev/null 2>&1 &

# Khởi động Telegram Bot
cd $HOME/botmia2
nohup python bot.py > /dev/null 2>&1 &

# Khởi động Cloudflare Tunnel
nohup cloudflared tunnel run mia2bot > /dev/null 2>&1 &
