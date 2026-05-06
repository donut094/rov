#!/bin/bash
set -e

GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

RAR_URL="https://www.dinoth.shop/rov/dino.rar"
DEST_DIR="$HOME/storage/downloads/dino"

echo -e "${YELLOW}📦 เริ่มติดตั้ง...${RESET}"

termux-setup-storage || true

yes | pkg update
yes | pkg upgrade

# 👉 บังคับใช้ python 3.11
yes | pkg install python=3.11 unrar wget

mkdir -p "$DEST_DIR"
cd "$DEST_DIR"

echo -e "${YELLOW}📚 ติดตั้ง lib...${RESET}"
pip install requests cloudscraper colorama pycryptodome rich

echo -e "${YELLOW}⬇️ โหลดไฟล์...${RESET}"
wget -O dino.rar "$RAR_URL"

echo -e "${YELLOW}📦 แตกไฟล์...${RESET}"
yes | unrar x -o+ dino.rar

echo -e "${GREEN}🚀 รัน...${RESET}"
python dino.py
