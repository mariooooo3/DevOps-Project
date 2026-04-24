#!/bin/bash
# ============================================================
# server.sh - File Transfer using Netcat (Sesiunea 2 - Extra)
# Folosire: bash server.sh <PORT> <NUME_FISIER>
# Exemplu:  bash server.sh 9999 fisier_primit.txt
# ============================================================

PORT=${1:-9999}
FILE_NAME=${2:-"received_file"}
SAVE_DIR="received_files"

# Creare director daca nu exista
mkdir -p "$SAVE_DIR"

echo "======================================"
echo "  SERVER Netcat - FiiPractic"
echo "======================================"
echo "Ascult pe portul: $PORT"
echo "Fisierul va fi salvat in: $SAVE_DIR/$FILE_NAME"
echo "Asteapta conexiune..."
echo ""

nc -l "$PORT" > "$SAVE_DIR/$FILE_NAME"

echo "Fisier primit cu succes: $SAVE_DIR/$FILE_NAME"
ls -lh "$SAVE_DIR/$FILE_NAME"
