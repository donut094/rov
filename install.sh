#!/bin/bash
set -e

# ====== สี ======
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

# ====== ตั้งค่า ======
RAR_URL="https://www.dinoth.shop/rov/dino.rar"
DEST_DIR="$HOME/storage/downloads/dino"
RAR_FILE="$DEST_DIR/dino.rar"

echo -e "${YELLOW}📦 เริ่มติดตั้ง Termux environment...${RESET}"

# ====== ขอ permission ======
termux-setup-storage || true

# ====== ลด warning pip ======
export PIP_DISABLE_PIP_VERSION_CHECK=1

# ====== อัปเดตระบบ ======
echo -e "${YELLOW}🔄 อัปเดตแพ็กเกจ...${RESET}"
yes | pkg update
yes | pkg upgrade

# ====== ติดตั้งพื้นฐาน ======
yes | pkg install python unrar wget

# ====== เช็ค Python ======
if ! command -v python >/dev/null 2>&1; then
    echo -e "${RED}❌ ติดตั้ง Python ไม่สำเร็จ${RESET}"
    exit 1
fi

# ====== (สำคัญ) ไม่ต้อง upgrade pip ใน Termux ======
echo -e "${YELLOW}⏭️ ข้ามการอัปเกรด pip (Termux ไม่อนุญาต)...${RESET}"

# ====== ติดตั้งไลบรารี ======
echo -e "${YELLOW}📚 ติดตั้ง Python packages...${RESET}"
python -m pip install --no-input requests cloudscraper colorama pycryptodome rich

# ====== สร้างโฟลเดอร์ ======
echo -e "${YELLOW}📁 เตรียมโฟลเดอร์...${RESET}"
mkdir -p "$DEST_DIR"

# ====== ดาวน์โหลดไฟล์ ======
echo -e "${YELLOW}⬇️ กำลังดาวน์โหลดไฟล์...${RESET}"
wget -q --show-progress -O "$RAR_FILE" "$RAR_URL"

# ====== เช็คไฟล์โหลดสำเร็จ ======
if [ ! -f "$RAR_FILE" ]; then
    echo -e "${RED}❌ ดาวน์โหลดไฟล์ไม่สำเร็จ${RESET}"
    exit 1
fi

# ====== แตกไฟล์ ======
echo -e "${YELLOW}📦 กำลังแตกไฟล์...${RESET}"
cd "$DEST_DIR"
yes | unrar x -o+ dino.rar

# ====== เช็คไฟล์ก่อนรัน ======
if [ ! -f "dino.py" ]; then
    echo -e "${RED}❌ ไม่พบ dino.py${RESET}"
    exit 1
fi

# ====== รันโปรแกรม ======
echo -e "${GREEN}🚀 กำลังรัน dino.py...${RESET}"
python dino.py

echo -e "${GREEN}🎉 เสร็จสิ้นทั้งหมด!${RESET}"
