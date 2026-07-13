#include <stdio.h>
#include <stdlib.h>
#include "equipement.h"
#include "fichier.h"

int main() {
    charger_fichier();
    int choix;
    do {
        printf("\n=== GESTION INVENTAIRE ===\n");
        printf("1. Ajouter un équipement\n");
        printf("2. Modifier un équipement\n");
        printf("3. Supprimer un équipement\n");
        printf("4. Rechercher un équipement\n");
        printf("5. Afficher tous les équipements\n");
        printf("6. Sauvegarder\n");
        printf("0. Quitter\n");
        printf("Votre choix : ");
        scanf("%d", &choix);
        switch(choix) {
            case 1: ajouter_equipement(); break;
            case 2: modifier_equipement(); break;
            case 3: supprimer_equipement(); break;
            case 4: rechercher_equipement(); break;
            case 5: afficher_tous(); break;
            case 6: sauvegarder_fichier(); break;
            case 0: printf("Au revoir !\n"); sauvegarder_fichier(); break;
            default: printf("Choix invalide\n");
        }
    } while(choix != 0);
    return 0;
}
