
# Projet d'Administration Linux

## Contexte
Ce projet a été réalisé dans le cadre du module **Programmation Linux** à l'Université Cheikh Anta Diop.  
L'objectif est de développer un système d'administration Linux automatisé combinant un **script Bash** et un **programme en C**.

## Fonctionnalités

### Partie 1 : Administration avec Bash
Le script `menu_admin.sh` propose un menu interactif permettant d'effectuer les opérations suivantes :

1. **Gestion des répertoires** : créer, supprimer, renommer, lister
2. **Gestion des fichiers** : créer, copier, déplacer, supprimer, rechercher
3. **Gestion des permissions** : afficher, modifier (chmod, chown)
4. **Recherche** : fichiers, texte dans fichiers, utilisateurs, processus
5. **Surveillance du système** : mémoire, espace disque, utilisateurs, charge CPU
6. **Gestion des processus** : afficher, rechercher, arrêter, envoyer un signal
7. **Sauvegarde automatique** : compression (tar.gz/zip), datation, restauration
8. **Planification** : sauvegarde quotidienne avec cron, restauration avec at
9. **Gestion inventaire** : interface avec la partie C

### Partie 2 : Programmation C
Le programme `inventaire.c` gère un inventaire informatique avec les fonctionnalités suivantes :
- Ajouter un équipement (ID, nom, IP, MAC, localisation, date automatique)
- Modifier un équipement
- Supprimer un équipement
- Rechercher un équipement (par ID ou nom)
- Afficher tous les équipements
- Sauvegarder les données dans un fichier CSV (`inventaire.txt`)
- Chargement automatique des données au démarrage
