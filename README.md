# JustDodge

## Concept du jeu
Le jeu s'inspire du concept des combats de [Undertale](https://fr.wikipedia.org/wiki/Undertale) 

![Exemple de combat de Undertale](/images/combat.gif)

### Obstacles
* Default Obstacle
  * Spawn: Mur
  * Info: Obstacle se dirigeant vers le mur opposé à son apparition
* Bomb
  * Spawn: Sur le terrain
  * Info: Se détruit après 1 seconde et 4 projectiles sont lancés dans le sens opposé
* Wall 
  * Spawn: Sur le terrain
  * Info: Bloque physiquement le joueur

 

### User Experience

* Invincibility Frame
* Point de vie
* Score

### Interaction avec le joueur 

* Obstacles déplaçable

### Controles

* En jeu:
  * D: Déplacement vers la droite
  * Q: Déplacement vers la gauche
  * Z: Déplacement vers le haut
  * S: Déplacement vers le bas
  * R: Revenir au menu principal
* Dans le menu:
  * Z/Q/S/D: Naviguer dans le menu
* Dans le menu de fin de partie:
  * Espace: Revenir au menu principal

## Rapport
Le rapport se trouve dans le dossier rapport/

## Installation

* Run
```bash
dune-build install
```
* Run index.html
* Have fun!
