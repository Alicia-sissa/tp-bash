# REPONSES – TP Bash

## Exercice 2.1 – Permissions des fichiers

**Question : Que signifie la permission 644 ?**

La permission `644` signifie :
- Propriétaire : lecture et écriture (`rw-`).
- Groupe : lecture uniquement (`r--`).
- Autres utilisateurs : lecture uniquement (`r--`).

Le propriétaire peut donc modifier le fichier, tandis que les autres peuvent uniquement le lire.

## Exercice 2.2 – Utilisation des variables

**Question : Pourquoi utiliser `"$UTILISATION"` entre guillemets ?**

Les guillemets permettent de protéger le contenu de la variable contre le découpage en plusieurs arguments et l'expansion des caractères spéciaux comme `*`.

Ainsi, même si la variable contient des espaces, elle est considérée comme un seul argument.

## Exercice 2.3 – Script de sauvegarde

**Question : Quel est l'intérêt de `set -Eeuo pipefail` ?**

Cette instruction permet de renforcer la gestion des erreurs dans un script Bash.

- `-e` : arrête le script lorsqu'une commande échoue dans les conditions où cette option s'applique.
- `-E` : propage le comportement de `ERR` dans certaines fonctions et sous-contextes.
- `-u` : signale l'utilisation de variables non définies.
- `pipefail` : permet de détecter l'échec d'une commande dans un pipeline.

Sans cette instruction, le script pourrait continuer après une erreur et afficher un message de réussite alors que la sauvegarde a échoué.

## Exercice 2.4 – Planification avec cron

**Question : Pourquoi cron nécessite-t-il des chemins absolus alors qu'un script fonctionne très bien depuis votre terminal avec des chemins relatifs ?**

Cron exécute les tâches dans un environnement différent du terminal interactif. Le répertoire courant et les variables d'environnement, notamment PATH, peuvent être différents.

Les chemins relatifs risquent donc de ne pas désigner les bons fichiers. Les chemins absolus permettent d'identifier précisément les fichiers et les répertoires et rendent l'exécution plus fiable.

## Exercice 2.5 – Mini-projet d'intégration (CI)

**Question 1 : Quelles étapes ajouteriez-vous pour transformer ce script en un vrai pipeline CI ?**

Pour transformer ce script en un véritable pipeline d'intégration continue, on pourrait ajouter :

- La compilation du projet.
- L'exécution des tests unitaires.
- Les tests d'intégration.
- L'analyse statique du code.
- L'analyse de sécurité des dépendances.
- La génération de rapports.
- Le déploiement automatique si toutes les étapes réussissent.

**Question 2 : Quels seraient les points de défaillance à gérer avec des codes de retour ?**

Plusieurs erreurs peuvent survenir pendant l'exécution du pipeline :

- Échec du clonage du dépôt Git.
- Échec de la mise à jour avec `git pull`.
- Échec de la compilation.
- Échec d'un ou plusieurs tests.
- Erreur lors de l'analyse de sécurité.
- Problème de connexion réseau ou d'accès au dépôt.

Dans ces situations, le script doit retourner un code différent de zéro (`exit 1`) pour signaler un échec. Si toutes les étapes réussissent, il retourne `exit 0`.

Cela permet d'identifier rapidement les erreurs et d'empêcher la suite du pipeline de s'exécuter lorsqu'une étape importante échoue.
