#!/bin/bash

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

# ============================================
# 1. Gestion des répertoires
# ============================================
gerer_repertoires() {
    clear
    echo -e "${BLUE}--- GESTION DES RÉPERTOIRES ---${NC}"
    echo "1. Créer un dossier"
    echo "2. Supprimer un dossier"
    echo "3. Renommer un dossier"
    echo "4. Afficher le contenu"
    echo "0. Retour"
    read -p "Choix : " choix
    case $choix in
        1) read -p "Nom : " nom; mkdir -v "$nom";;
        2) read -p "Nom : " nom; rmdir -v "$nom" 2>/dev/null || rm -rf -v "$nom";;
        3) read -p "Ancien : " old; read -p "Nouveau : " new; mv -v "$old" "$new";;
        4) read -p "Dossier : " nom; ls -la "$nom";;
        0) return;;
        *) echo "Choix invalide";;
    esac
    read -p "Appuyez sur Entrée..."
}

# ============================================
# 2. Gestion des fichiers
# ============================================
gerer_fichiers() {
    clear
    echo -e "${BLUE}--- GESTION DES FICHIERS ---${NC}"
    echo "1. Créer un fichier"
    echo "2. Copier"
    echo "3. Déplacer"
    echo "4. Supprimer"
    echo "5. Rechercher"
    echo "0. Retour"
    read -p "Choix : " choix
    case $choix in
        1) read -p "Nom : " nom; touch "$nom";;
        2) read -p "Source : " src; read -p "Destination : " dst; cp -v "$src" "$dst";;
        3) read -p "Source : " src; read -p "Destination : " dst; mv -v "$src" "$dst";;
        4) read -p "Fichier : " nom; rm -v "$nom";;
        5) read -p "Nom : " nom; find . -name "$nom" 2>/dev/null;;
        0) return;;
        *) echo "Choix invalide";;
    esac
    read -p "Appuyez sur Entrée..."
}

# ============================================
# 3. Gestion des permissions
# ============================================
gerer_permissions() {
    clear
    echo -e "${BLUE}--- GESTION DES PERMISSIONS ---${NC}"
    echo "1. Afficher les permissions"
    echo "2. chmod"
    echo "3. chown"
    echo "0. Retour"
    read -p "Choix : " choix
    case $choix in
        1) read -p "Fichier : " f; ls -la "$f";;
        2) read -p "Fichier : " f; read -p "Permissions : " p; chmod -v "$p" "$f";;
        3) read -p "Fichier : " f; read -p "Propriétaire:groupe : " o; chown -v "$o" "$f";;
        0) return;;
        *) echo "Choix invalide";;
    esac
    read -p "Appuyez sur Entrée..."
}

# ============================================
# 4. Recherche
# ============================================
rechercher() {
    clear
    echo -e "${BLUE}--- RECHERCHE ---${NC}"
    echo "1. Fichier"
    echo "2. Texte dans fichier"
    echo "3. Utilisateur"
    echo "4. Processus"
    echo "0. Retour"
    read -p "Choix : " choix
    case $choix in
        1) read -p "Nom : " nom; find . -name "$nom" 2>/dev/null;;
        2) read -p "Texte : " t; read -p "Cible : " c; grep -r "$t" "$c" 2>/dev/null;;
        3) read -p "Utilisateur : " u; getent passwd | grep "$u";;
        4) read -p "Processus : " p; ps aux | grep "$p" | grep -v grep;;
        0) return;;
        *) echo "Choix invalide";;
    esac
    read -p "Appuyez sur Entrée..."
}

# ============================================
# 5. Surveillance
# ============================================
surveiller_systeme() {
    clear
    echo -e "${BLUE}--- SURVEILLANCE ---${NC}"
    echo "1. Mémoire"
    echo "2. Espace disque"
    echo "3. Utilisateurs"
    echo "4. Charge CPU"
    echo "0. Retour"
    read -p "Choix : " choix
    case $choix in
        1) free -h;;
        2) df -h;;
        3) who;;
        4) top -bn1 | head -10;;
        0) return;;
        *) echo "Choix invalide";;
    esac
    read -p "Appuyez sur Entrée..."
}

# ============================================
# 6. Gestion des processus
# ============================================
gerer_processus() {
    clear
    echo -e "${BLUE}--- PROCESSUS ---${NC}"
    echo "1. Afficher tous"
    echo "2. Rechercher"
    echo "3. Arrêter (kill -15)"
    echo "4. Envoyer un signal"
    echo "0. Retour"
    read -p "Choix : " choix
    case $choix in
        1) ps aux;;
        2) read -p "Nom : " n; ps aux | grep "$n" | grep -v grep;;
        3) read -p "PID : " p; kill -15 "$p";;
        4) read -p "PID : " p; read -p "Signal : " s; kill -"$s" "$p";;
        0) return;;
        *) echo "Choix invalide";;
    esac
    read -p "Appuyez sur Entrée..."
}

# ============================================
# 7. Sauvegarde
# ============================================
gerer_sauvegarde() {
    ./sauvegarde.sh
}

# ============================================
# 8. Planification
# ============================================
planifier() {
    clear
    echo -e "${BLUE}--- PLANIFICATION ---${NC}"
    echo "1. Cron (sauvegarde quotidienne)"
    echo "2. At (restauration)"
    echo "0. Retour"
    read -p "Choix : " choix
    case $choix in
        1)
            read -p "Commande : " cmd
            (crontab -l 2>/dev/null; echo "0 2 * * * $cmd") | crontab -
            echo -e "${GREEN}Ajouté à cron (2h)${NC}"
            ;;
        2)
            read -p "Commande : " cmd
            read -p "Heure : " h
            echo "$cmd" | at "$h"
            echo -e "${GREEN}Planifié avec at${NC}"
            ;;
        0) return;;
        *) echo "Choix invalide";;
    esac
    read -p "Appuyez sur Entrée..."
}

# ============================================
# 9. Gestion inventaire (C)
# ============================================
gerer_inventaire() {
    clear
    echo -e "${BLUE}--- INVENTAIRE (C) ---${NC}"
    make clean >/dev/null 2>&1
    make
    if [ $? -eq 0 ]; then
        ./src/main
    else
        echo -e "${RED}Erreur de compilation${NC}"
    fi
    read -p "Appuyez sur Entrée..."
}

# ============================================
# MENU PRINCIPAL
# ============================================
afficher_menu() {
    clear
    echo -e "${BLUE}========================================${NC}"
    echo -e "${GREEN}   SYSTÈME D'ADMINISTRATION LINUX${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo "1.  Gestion des répertoires"
    echo "2.  Gestion des fichiers"
    echo "3.  Gestion des permissions"
    echo "4.  Recherche"
    echo "5.  Surveillance du système"
    echo "6.  Gestion des processus"
    echo "7.  Sauvegarde automatique"
    echo "8.  Planification"
    echo "9.  Gestion inventaire (C)"
    echo "0.  Quitter"
    echo -e "${BLUE}========================================${NC}"
    echo -n "Votre choix : "
}

# Boucle principale
while true; do
    afficher_menu
    read choix
    case $choix in
        1) gerer_repertoires;;
        2) gerer_fichiers;;
        3) gerer_permissions;;
        4) rechercher;;
        5) surveiller_systeme;;
        6) gerer_processus;;
        7) gerer_sauvegarde;;
        8) planifier;;
        9) gerer_inventaire;;
        0) echo -e "${GREEN}Au revoir !${NC}"; exit 0;;
        *) echo -e "${RED}Choix invalide${NC}"; read -p "Appuyez sur Entrée...";;
    esac
done
