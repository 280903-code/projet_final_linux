#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

sauvegarder() {
    clear
    echo "=== SAUVEGARDE AUTOMATIQUE ==="
    read -p "Répertoire à sauvegarder : " src
    if [ ! -d "$src" ]; then
        echo -e "${RED}Erreur : le répertoire n'existe pas${NC}"
        return
    fi
    echo "Type de compression :"
    echo "1) tar.gz"
    echo "2) zip"
    read -p "Votre choix : " comp_type
    date_save=$(date +%Y%m%d_%H%M%S)
    base_name=$(basename "$src")
    if [ "$comp_type" = "1" ]; then
        archive="backup/backup_${base_name}_${date_save}.tar.gz"
        tar -czf "$archive" "$src"
        echo -e "${GREEN}Sauvegarde créée : $archive${NC}"
    elif [ "$comp_type" = "2" ]; then
        archive="backup/backup_${base_name}_${date_save}.zip"
        zip -r "$archive" "$src"
        echo -e "${GREEN}Sauvegarde créée : $archive${NC}"
    else
        echo -e "${RED}Type invalide${NC}"
    fi
}

restaurer() {
    clear
    echo "=== RESTAURATION ==="
    read -p "Nom de l'archive à restaurer : " archive
    if [ ! -f "$archive" ]; then
        echo -e "${RED}Erreur : archive introuvable${NC}"
        return
    fi
    read -p "Destination : " dst
    mkdir -p "$dst"
    if [[ "$archive" == *.tar.gz ]]; then
        tar -xzf "$archive" -C "$dst"
        echo -e "${GREEN}Restauré dans $dst${NC}"
    elif [[ "$archive" == *.zip ]]; then
        unzip -q "$archive" -d "$dst"
        echo -e "${GREEN}Restauré dans $dst${NC}"
    else
        echo -e "${RED}Format non reconnu${NC}"
        return
    fi
}

while true; do
    clear
    echo "=== SAUVEGARDE ==="
    echo "1. Sauvegarder"
    echo "2. Restaurer"
    echo "0. Quitter"
    read -p "Choix : " choix
    case $choix in
        1) sauvegarder; read -p "Appuyez sur Entrée...";;
        2) restaurer; read -p "Appuyez sur Entrée...";;
        0) exit 0;;
        *) echo "Choix invalide"; read -p "Appuyez sur Entrée...";;
    esac
done
