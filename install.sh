#!/bin/bash
set -e

# ====== สี ======
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# ====== ตั้งค่า ======
RAR_URL="YOUR_RAR_URL"
DEST_DIR="$HOME/storage/downloads/dino"
RAR_FILE="$DEST_DIR/dino.rar"

echo -e "${YELLOW}📦 เริ่มติดตั้ง Termux environment...${RESET}"

# ====== ขอ permission ======
termux-setup-storage || true

# ====== อัปเดตระบบ ======
echo -e "${YELLOW}🔄 อัปเดตแพ็กเกจ...${RESET}"
pkg update -y && pkg upgrade -y

# ====== ติดตั้งพื้นฐาน ======
pkg install -y python unrar wget

# ====== เช็ค Python ======
if ! command -v python >/dev/null 2>&1; then
    echo -e "${RED}❌ ติดตั้ง Python ไม่สำเร็จ${RESET}"
    exit 1
fi

# ====== อัปเกรด pip ======
echo -e "${YELLOW}⬆️ อัปเกรด pip...${RESET}"
python -m pip install --upgrade pip

# ====== ติดตั้งไลบรารี ======
echo -e "${YELLOW}📚 ติดตั้ง Python packages...${RESET}"
pip install requests cloudscraper colorama pycryptodome rich

# ====== สร้างโฟลเดอร์ ======
echo -e "${YELLOW}📁 เตรียมโฟลเดอร์...${RESET}"
mkdir -p "$DEST_DIR"

# ====== ดาวน์โหลดไฟล์ ======
echo -e "${YELLOW}⬇️ กำลังดาวน์โหลดไฟล์...${RESET}"
wget -O "$RAR_FILE" "$RAR_URL"

# ====== แตกไฟล์ ======
echo -e "${YELLOW}📦 กำลังแตกไฟล์...${RESET}"
cd "$DEST_DIR"
unrar x -o+ dino.rar

# ====== รันโปรแกรม ======
echo -e "${GREEN}🚀 กำลังรัน dino.py...${RESET}"
python dino.py

echo -e "${GREEN}🎉 เสร็จสิ้นทั้งหมด!${RESET}"
