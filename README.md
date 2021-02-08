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
* Laser 
  * Spawn: Mur
  * Info: Après un court délai, tire un laser sur toute la ligne
* Feuille
  * Spawn: En haut, au centre
  * Info: Feuille qui tombe avec une trajectoire imprévisible
 

### User Experience

* Invincibility Frame
* Point de vie
* Score
* Apparition d'un icône pour annoncer l'Abilité du niveau
* Son dégats
* Terrain modulable (changement de taille) 
* Menu de pause (options)

### Interaction avec le joueur 

* Obstacles déplaçable
* (Dis)Abilités
  * Glisser
  * Deplacement plus rapide/lent
  * Inversion des touches
  * Changement de perspective
  
### Controles

* Mode side scroller:
  * D/Fléche Droite: Déplacement vers la droite
  * Q/Fléche Gauche: Déplacement vers la gauche
  * Z/Espace/Fléche du haut: Déplacement vers le haut

* Mode top down:
  * D/Fléche Droite: Déplacement vers la droite
  * Q/Fléche Gauche: Déplacement vers la gauche
  * Z/Fléche du haut: Déplacement vers le haut
  * S/Fléche du bas: Déplacement vers le bas

## Installation

* Run
```bash
dune-build install
```
* Run index.html
* Have fun!
