#!/bin/bash
set -Eeuo pipefail

# Argument du script : URL du dépôt Git
REPO_URL="${1:-}"

# Dossier de travail
DOSSIER="ci-workspace"

# Fichier de journalisation
LOG="ci.log"

# Fonction pour enregistrer les messages avec date et heure
journaliser() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG"
}

# Vérification de l'argument
if [ -z "$REPO_URL" ]; then
    journaliser "Erreur : URL du dépôt manquante."
    exit 1
fi

# Clonage ou mise à jour du dépôt
if [ -d "$DOSSIER/.git" ]; then
    journaliser "Mise à jour du dépôt..."
    git -C "$DOSSIER" pull || {
        journaliser "Erreur lors de la mise à jour."
        exit 1
    }
else
    journaliser "Clonage du dépôt..."
    git clone "$REPO_URL" "$DOSSIER" || {
        journaliser "Erreur lors du clonage."
        exit 1
    }
fi

# Simulation des tests
journaliser "Début des tests..."

if [ -f "$DOSSIER/check_disk.sh" ] && [ -f "$DOSSIER/backup.sh" ]; then
    journaliser "Tests réussis : les scripts requis existent."
else
    journaliser "Erreur : un ou plusieurs scripts sont manquants."
    exit 1
fi

journaliser "Pipeline terminé avec succès."
exit 0
