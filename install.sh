#!/bin/bash
set -e

GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

RAR_URL="https://www.dinoth.shop/rov/dino.rar"
DEST_DIR="$HOME/storage/downloads/dino"
RAR_FILE="$DEST_DIR/dino.rar"

echo -e "${YELLOW}📦 เริ่มติดตั้ง...${RESET}"

termux-setup-storage || true
export PIP_DISABLE_PIP_VERSION_CHECK=1

yes | pkg update
yes | pkg upgrade

yes | pkg install python unrar wget

mkdir -p "$DEST_DIR"
cd "$DEST_DIR"

# ====== สร้าง venv ======
echo -e "${YELLOW}🧠 สร้าง virtual environment...${RESET}"
python -m venv venv

# activate venv
source venv/bin/activate

# ====== อัป pip ใน venv (อันนี้ทำได้) ======
pip install --upgrade pip

# ====== ติดตั้ง lib ======
echo -e "${YELLOW}📚 ติดตั้ง packages...${RESET}"
pip install requests cloudscraper colorama pycryptodome rich

# ====== โหลดไฟล์ ======
echo -e "${YELLOW}⬇️ ดาวน์โหลด...${RESET}"
wget -q --show-progress -O "$RAR_FILE" "$RAR_URL"

# ====== แตก ======
echo -e "${YELLOW}📦 แตกไฟล์...${RESET}"
yes | unrar x -o+ dino.rar

# ====== รัน ======
if [ ! -f "dino.py" ]; then
    echo -e "${RED}❌ ไม่พบ dino.py${RESET}"
    exit 1
fi

echo -e "${GREEN}🚀 รันโปรแกรม...${RESET}"
python dino.py
