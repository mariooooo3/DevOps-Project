#!/bin/bash
# ============================================================
# setup-easyrsa.sh
# Rulat pe gitlab2 ca root
# Creeaza Root CA si certificat wildcard pentru *.fiipractic.lan
# ============================================================

set -e

echo "====== [1] Instalare easy-rsa ======"
dnf install -y easy-rsa

echo "====== [2] Initializare PKI ======"
mkdir -p /root/easy-rsa
cd /root/easy-rsa

# Copiem easy-rsa
cp -r /usr/share/easy-rsa/3/* /root/easy-rsa/

./easyrsa init-pki

echo "====== [3] Creare Root CA (numele tau) ======"
# Schimba "ClaudeCA" cu numele tau
./easyrsa --batch --req-cn="FiiPractic-CA" build-ca nopass

echo "====== [4] Creare certificat wildcard pentru *.fiipractic.lan ======"
./easyrsa --batch --req-cn="*.fiipractic.lan" \
  --subject-alt-name="DNS:*.fiipractic.lan,DNS:gitlab.fiipractic.lan,DNS:app.fiipractic.lan,DNS:netdata.fiipractic.lan" \
  gen-req fiipractic.lan nopass

./easyrsa --batch sign-req server fiipractic.lan

echo "====== [5] Copiere certificate in locatia GitLab ======"
mkdir -p /etc/gitlab/ssl

cp /root/easy-rsa/pki/issued/fiipractic.lan.crt /etc/gitlab/ssl/gitlab.fiipractic.lan.crt
cp /root/easy-rsa/pki/private/fiipractic.lan.key /etc/gitlab/ssl/gitlab.fiipractic.lan.key
cp /root/easy-rsa/pki/ca.crt /etc/gitlab/ssl/ca.crt

chmod 600 /etc/gitlab/ssl/*.key
chmod 644 /etc/gitlab/ssl/*.crt

echo "====== [6] Instalare Root CA pe gitlab2 ======"
cp /root/easy-rsa/pki/ca.crt /etc/pki/ca-trust/source/anchors/fiipractic-ca.crt
update-ca-trust

echo ""
echo "====== GATA! ======"
echo "Certificatele se afla in: /etc/gitlab/ssl/"
echo "  - CA:   /etc/gitlab/ssl/ca.crt"
echo "  - CERT: /etc/gitlab/ssl/gitlab.fiipractic.lan.crt"
echo "  - KEY:  /etc/gitlab/ssl/gitlab.fiipractic.lan.key"
echo ""
echo "Urmator: ruleaza configure-gitlab.sh"
