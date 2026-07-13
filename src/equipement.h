#ifndef EQUIPEMENT_H
#define EQUIPEMENT_H

#define MAX_EQUIP 100

typedef struct {
    int id;
    char nom[50];
    char ip[16];
    char mac[18];
    char localisation[50];
    char date_ajout[11];
} Equipement;

extern Equipement inventaire[MAX_EQUIP];
extern int nb_equip;

void ajouter_equipement();
void modifier_equipement();
void supprimer_equipement();
void rechercher_equipement();
void afficher_tous();
void afficher_un(Equipement e);
int trouver_par_id(int id);

#endif
