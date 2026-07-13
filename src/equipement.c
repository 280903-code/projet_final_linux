#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "equipement.h"
#include "fichier.h"

Equipement inventaire[MAX_EQUIP];
int nb_equip = 0;

void ajouter_equipement() {
    if (nb_equip >= MAX_EQUIP) {
        printf("❌ Inventaire plein\n");
        return;
    }
    Equipement e;
    printf("ID : "); scanf("%d", &e.id);
    if (trouver_par_id(e.id) != -1) {
        printf("❌ Cet ID existe déjà\n");
        return;
    }
    printf("Nom : "); scanf(" %[^\n]", e.nom);
    printf("Adresse IP : "); scanf(" %[^\n]", e.ip);
    printf("Adresse MAC : "); scanf(" %[^\n]", e.mac);
    printf("Localisation : "); scanf(" %[^\n]", e.localisation);
    
    time_t t = time(NULL);
    struct tm *tm = localtime(&t);
    strftime(e.date_ajout, 11, "%Y-%m-%d", tm);

    inventaire[nb_equip++] = e;
    printf("✅ Équipement ajouté\n");
    sauvegarder_fichier();
}

void modifier_equipement() {
    int id;
    printf("ID de l'équipement à modifier : ");
    scanf("%d", &id);
    int idx = trouver_par_id(id);
    if (idx == -1) {
        printf("❌ Non trouvé\n");
        return;
    }
    printf("Nouveau nom (actuel: %s) : ", inventaire[idx].nom);
    scanf(" %[^\n]", inventaire[idx].nom);
    printf("Nouvelle IP (actuelle: %s) : ", inventaire[idx].ip);
    scanf(" %[^\n]", inventaire[idx].ip);
    printf("Nouvelle MAC (actuelle: %s) : ", inventaire[idx].mac);
    scanf(" %[^\n]", inventaire[idx].mac);
    printf("Nouvelle localisation (actuelle: %s) : ", inventaire[idx].localisation);
    scanf(" %[^\n]", inventaire[idx].localisation);
    printf("✅ Modifié\n");
    sauvegarder_fichier();
}

void supprimer_equipement() {
    int id;
    printf("ID à supprimer : ");
    scanf("%d", &id);
    int idx = trouver_par_id(id);
    if (idx == -1) {
        printf("❌ Non trouvé\n");
        return;
    }
    for (int i = idx; i < nb_equip - 1; i++) {
        inventaire[i] = inventaire[i+1];
    }
    nb_equip--;
    printf("✅ Supprimé\n");
    sauvegarder_fichier();
}

void rechercher_equipement() {
    int choix;
    printf("Rechercher par (1) ID ou (2) Nom ? ");
    scanf("%d", &choix);
    if (choix == 1) {
        int id;
        printf("ID : "); scanf("%d", &id);
        int idx = trouver_par_id(id);
        if (idx == -1) printf("❌ Non trouvé\n");
        else afficher_un(inventaire[idx]);
    } else if (choix == 2) {
        char nom[50];
        printf("Nom : "); scanf(" %[^\n]", nom);
        int trouve = 0;
        for (int i = 0; i < nb_equip; i++) {
            if (strstr(inventaire[i].nom, nom) != NULL) {
                afficher_un(inventaire[i]);
                trouve = 1;
            }
        }
        if (!trouve) printf("❌ Aucun\n");
    }
}

void afficher_tous() {
    if (nb_equip == 0) {
        printf("📭 Inventaire vide\n");
        return;
    }
    printf("\n%-4s %-20s %-16s %-18s %-20s %-12s\n",
           "ID", "Nom", "IP", "MAC", "Localisation", "Date");
    printf("-----------------------------------------------------------------------------------------\n");
    for (int i = 0; i < nb_equip; i++) {
        afficher_un(inventaire[i]);
    }
}

void afficher_un(Equipement e) {
    printf("%-4d %-20s %-16s %-18s %-20s %-12s\n",
           e.id, e.nom, e.ip, e.mac, e.localisation, e.date_ajout);
}

int trouver_par_id(int id) {
    for (int i = 0; i < nb_equip; i++) {
        if (inventaire[i].id == id) return i;
    }
    return -1;
}
