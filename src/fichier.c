#include <stdio.h>
#include <stdlib.h>
#include "fichier.h"
#include "equipement.h"

#define FICHIER "data/equipements.txt"

void charger_fichier() {
    FILE *f = fopen(FICHIER, "r");
    if (!f) return;
    nb_equip = 0;
    while (fscanf(f, "%d;%49[^;];%15[^;];%17[^;];%49[^;];%10[^\n]\n",
                  &inventaire[nb_equip].id,
                  inventaire[nb_equip].nom,
                  inventaire[nb_equip].ip,
                  inventaire[nb_equip].mac,
                  inventaire[nb_equip].localisation,
                  inventaire[nb_equip].date_ajout) == 6) {
        nb_equip++;
        if (nb_equip >= MAX_EQUIP) break;
    }
    fclose(f);
}

void sauvegarder_fichier() {
    FILE *f = fopen(FICHIER, "w");
    if (!f) { perror("Erreur sauvegarde"); return; }
    for (int i = 0; i < nb_equip; i++) {
        fprintf(f, "%d;%s;%s;%s;%s;%s\n",
                inventaire[i].id,
                inventaire[i].nom,
                inventaire[i].ip,
                inventaire[i].mac,
                inventaire[i].localisation,
                inventaire[i].date_ajout);
    }
    fclose(f);
    printf("✅ Sauvegarde effectuée (%d équipements)\n", nb_equip);
}
