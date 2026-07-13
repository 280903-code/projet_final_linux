#!/bin/bash

echo "=== INSTALLATION DU PROJET ==="

# Vérifier les dépendances
command -v gcc >/dev/null 2>&1 || { echo "❌ GCC non trouvé"; exit 1; }
command -v make >/dev/null 2>&1 || { echo "❌ Make non trouvé"; exit 1; }
command -v gdb >/dev/null 2>&1 || { echo "❌ GDB non trouvé"; exit 1; }

echo "✅ Toutes les dépendances sont installées."

# Compilation
echo "Compilation du projet..."
make

if [ $? -eq 0 ]; then
    echo "✅ Installation réussie !"
    echo "Pour lancer le projet : ./menu.sh"
else
    echo "❌ Erreur de compilation"
    exit 1
fi
