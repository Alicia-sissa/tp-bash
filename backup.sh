#!/bin/bash
set -Eeuo pipefail

DOSSIER="data"
DESTINATION="backups"

if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : dossier $DOSSIER introuvable" >&2
    exit 1
fi

mkdir -p "$DESTINATION"

DATE=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIVE="$DESTINATION/backup_$DATE.tar.gz"

tar -czf "$ARCHIVE" "$DOSSIER"

echo "Sauvegarde réussie : $ARCHIVE"

for fichier in "$DESTINATION"/backup_*.tar.gz; do
    [ -e "$fichier" ] || continue

    if [ "$(find "$fichier" -mtime +7 -print)" ]; then
        rm "$fichier"
        echo "Ancienne sauvegarde supprimée : $fichier"
    fi
done

echo "Nettoyage terminé"
exit 0
