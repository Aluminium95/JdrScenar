# Projet

Le but est la création d'un outil de manipulation d'arbre 
binaire simple et intuitif.
Dans l'idéal, une sauvegarde en texte et en JSON serait possible
pour un traitement ultérieur avec d'autres programmes.

# Actuellement

Globalement tout fonctionne, mais le code utilise des 
API de clutter dépréciés (comme `Actor.animate`)

De plus il manque une vision d'un MJ pour savoir quelles 
informations importantes mettre dans les Nodes, voir même 
utiliser une représentation JSON variable (avec création de champs
à la volée ...)

# TODO

* Amélioration des graphismes de la scène Clutter
* Finition de l'interface GTK
* Création des fonctions sauvegarde/chargement
* Création de réponses sonores aux actions 
* Passages de `Clutter.Actor.animate` vers les `Clutter.State`


