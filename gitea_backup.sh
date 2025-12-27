#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="/media/backup/gitea_backup"
CONTAINER="gitea"
RUN_AS="1000:1000"

if ! mountpoint -q /media/backup; then
  echo "ERROR: /media/backup is not mounted." >&2
  exit 1
fi

TS="$(date -u +'%Y-%m-%dT%H-%M-%SZ')"
IN="/tmp/gitea-dump-${TS}.zip"
OUT="${BACKUP_DIR}/gitea-dump-${TS}.zip"

sudo mkdir -p "${BACKUP_DIR}"
sudo docker exec -u "${RUN_AS}" "${CONTAINER}" sh -lc "gitea dump --file '${IN}'"
# Copy to drive
sudo docker cp "${CONTAINER}:${IN}" "${OUT}"
sudo docker exec -u "${RUN_AS}" "${CONTAINER}" sh -lc "rm -f '${IN}'"
sudo ls -lh "${OUT}"
