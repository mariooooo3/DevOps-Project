#!/bin/bash
# ============================================================
# bank.sh - Aplicatie bancara simpla (Sesiunea 2 - Extra)
# Date salvate in bank.csv: Client,Sold curent
# ============================================================

BANK_FILE="bank.csv"

# Initializare fisier daca nu exista
if [ ! -f "$BANK_FILE" ]; then
    echo "Client,Sold curent" > "$BANK_FILE"
fi

# ---- Functii ----

adauga_client() {
    read -p "Nume client: " nume
    if grep -q "^$nume," "$BANK_FILE"; then
        echo "Clientul '$nume' exista deja!"
    else
        echo "$nume,0" >> "$BANK_FILE"
        echo "Client '$nume' adaugat cu sold initial 0."
    fi
}

modifica_sold() {
    read -p "Nume client: " nume
    if ! grep -q "^$nume," "$BANK_FILE"; then
        echo "Clientul '$nume' nu exista!"
        return
    fi
    read -p "Suma (pozitiva=depunere, negativa=retragere): " suma
    sold_curent=$(grep "^$nume," "$BANK_FILE" | cut -d',' -f2)
    sold_nou=$((sold_curent + suma))
    if [ $sold_nou -lt 0 ]; then
        echo "Fonduri insuficiente! Sold curent: $sold_curent"
        return
    fi
    sed -i "s/^$nume,.*/$nume,$sold_nou/" "$BANK_FILE"
    echo "Sold actualizat: $sold_nou"
}

sterge_client() {
    read -p "Nume client de sters: " nume
    if ! grep -q "^$nume," "$BANK_FILE"; then
        echo "Clientul '$nume' nu exista!"
        return
    fi
    sed -i "/^$nume,/d" "$BANK_FILE"
    echo "Clientul '$nume' a fost sters."
}

afiseaza_clienti() {
    echo ""
    echo "==============================="
    echo "  LISTA CLIENTI"
    echo "==============================="
    printf "%-20s %s\n" "Nume" "Sold"
    echo "-------------------------------"
    tail -n +2 "$BANK_FILE" | while IFS=',' read -r nume sold; do
        printf "%-20s %s RON\n" "$nume" "$sold"
    done
    echo "==============================="
    echo ""
}

# ---- Meniu principal ----
while true; do
    echo ""
    echo "=== APLICATIE BANCARA FiiPractic ==="
    echo "1. Adauga client nou"
    echo "2. Modifica sold client"
    echo "3. Sterge client"
    echo "4. Afiseaza toti clientii"
    echo "0. Iesire"
    echo "======================================"
    read -p "Alege optiunea: " optiune

    case $optiune in
        1) adauga_client ;;
        2) modifica_sold ;;
        3) sterge_client ;;
        4) afiseaza_clienti ;;
        0) echo "La revedere!"; exit 0 ;;
        *) echo "Optiune invalida!" ;;
    esac
done
