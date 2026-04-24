#!/bin/bash
# ============================================================
# client.sh - File Transfer using Netcat (Sesiunea 2 - Extra)
# Folosire: bash client.sh <SERVER_IP> <PORT> <FISIER_DE_TRIMIS>
# Exemplu:  bash client.sh 192.168.56.30 9999 document.txt
# ============================================================

SERVER_IP=${1:-"localhost"}
PORT=${2:-9999}
FILE_TO_SEND=${3}

echo "======================================"
echo "  CLIENT Netcat - FiiPractic"
echo "======================================"

if [ -z "$FILE_TO_SEND" ]; then
    echo "Eroare: specificati fisierul de trimis!"
    echo "Folosire: bash client.sh <SERVER_IP> <PORT> <FISIER>"
    exit 1
fi

if [ ! -f "$FILE_TO_SEND" ]; then
    echo "Eroare: fisierul '$FILE_TO_SEND' nu exista!"
    exit 1
fi

echo "Trimit fisierul: $FILE_TO_SEND"
echo "Catre: $SERVER_IP:$PORT"
echo ""

nc "$SERVER_IP" "$PORT" < "$FILE_TO_SEND"

echo "Fisier trimis cu succes!"
