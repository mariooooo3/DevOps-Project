#!/bin/bash
# ============================================================
# configure-gitlab.sh
# Rulat pe gitlab2 ca root, DUPA setup-easyrsa.sh
# Configureaza GitLab: HTTPS, SSL, Container Registry
# ============================================================

set -e

GITLAB_CONFIG="/etc/gitlab/gitlab.rb"

echo "====== [1] Backup gitlab.rb ======"
cp $GITLAB_CONFIG ${GITLAB_CONFIG}.bak

echo "====== [2] Setare EXTERNAL_URL la HTTPS ======"
sed -i "s|^external_url.*|external_url 'https://gitlab.fiipractic.lan'|" $GITLAB_CONFIG

echo "====== [3] Dezactivare Let's Encrypt (folosim certificat propriu) ======"
grep -q "letsencrypt\['enable'\]" $GITLAB_CONFIG || \
  echo "letsencrypt['enable'] = false" >> $GITLAB_CONFIG
sed -i "s|.*letsencrypt\['enable'\].*|letsencrypt['enable'] = false|" $GITLAB_CONFIG

echo "====== [4] Configurare certificat SSL ======"
grep -q "nginx\['ssl_certificate'\]" $GITLAB_CONFIG || \
  echo "nginx['ssl_certificate'] = \"/etc/gitlab/ssl/gitlab.fiipractic.lan.crt\"" >> $GITLAB_CONFIG
grep -q "nginx\['ssl_certificate_key'\]" $GITLAB_CONFIG || \
  echo "nginx['ssl_certificate_key'] = \"/etc/gitlab/ssl/gitlab.fiipractic.lan.key\"" >> $GITLAB_CONFIG

sed -i "s|.*nginx\['ssl_certificate'\].*|nginx['ssl_certificate'] = \"/etc/gitlab/ssl/gitlab.fiipractic.lan.crt\"|" $GITLAB_CONFIG
sed -i "s|.*nginx\['ssl_certificate_key'\].*|nginx['ssl_certificate_key'] = \"/etc/gitlab/ssl/gitlab.fiipractic.lan.key\"|" $GITLAB_CONFIG

echo "====== [5] Activare Container Registry ======"
grep -q "registry_external_url" $GITLAB_CONFIG || \
  echo "registry_external_url 'https://gitlab.fiipractic.lan:5050'" >> $GITLAB_CONFIG
sed -i "s|.*registry_external_url.*|registry_external_url 'https://gitlab.fiipractic.lan:5050'|" $GITLAB_CONFIG

grep -q "registry_nginx\['ssl_certificate'\]" $GITLAB_CONFIG || \
  echo "registry_nginx['ssl_certificate'] = \"/etc/gitlab/ssl/gitlab.fiipractic.lan.crt\"" >> $GITLAB_CONFIG
grep -q "registry_nginx\['ssl_certificate_key'\]" $GITLAB_CONFIG || \
  echo "registry_nginx['ssl_certificate_key'] = \"/etc/gitlab/ssl/gitlab.fiipractic.lan.key\"" >> $GITLAB_CONFIG

sed -i "s|.*registry_nginx\['ssl_certificate'\].*|registry_nginx['ssl_certificate'] = \"/etc/gitlab/ssl/gitlab.fiipractic.lan.crt\"|" $GITLAB_CONFIG
sed -i "s|.*registry_nginx\['ssl_certificate_key'\].*|registry_nginx['ssl_certificate_key'] = \"/etc/gitlab/ssl/gitlab.fiipractic.lan.key\"|" $GITLAB_CONFIG

echo "====== [6] Aplicare configuratie (gitlab-ctl reconfigure) ======"
echo "Aceasta poate dura 3-5 minute..."
gitlab-ctl reconfigure

echo "====== [7] Restart GitLab ======"
gitlab-ctl restart

echo ""
echo "====== GATA! ======"
echo "GitLab accesibil la: https://gitlab.fiipractic.lan"
echo "Container Registry:  https://gitlab.fiipractic.lan:5050"
