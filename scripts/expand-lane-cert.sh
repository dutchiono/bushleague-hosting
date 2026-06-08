#!/usr/bin/env bash
# Expand an existing product cert to include a new lane hostname.
# Usage: sudo ./expand-lane-cert.sh dotcache james
# Adds: james.dotcache.bushleague.xyz to cert dotcache.bushleague.xyz
set -euo pipefail
PRODUCT="${1:?product e.g. dotcache}"
SLUG="${2:?lane slug e.g. james}"
CERT_NAME="${PRODUCT}.bushleague.xyz"
NEW_HOST="${SLUG}.${PRODUCT}.bushleague.xyz"

mapfile -t EXISTING < <(sudo certbot certificates 2>/dev/null | awk -v c="$CERT_NAME" '$0 ~ "Certificate Name: "c {found=1} found && $1=="Domains:" {for(i=2;i<=NF;i++) print $i; exit}')
DOMAINS=("${EXISTING[@]}")
if [[ " ${DOMAINS[*]} " != *" ${NEW_HOST} "* ]]; then
  DOMAINS+=("$NEW_HOST")
fi

ARGS=()
for d in "${DOMAINS[@]}"; do ARGS+=(-d "$d"); done

echo "Expanding ${CERT_NAME} with: ${NEW_HOST}"
sudo certbot certonly --nginx --non-interactive --agree-tos --expand \
  --cert-name "$CERT_NAME" "${ARGS[@]}"
sudo nginx -t && sudo systemctl reload nginx
echo "OK: https://${NEW_HOST}"
