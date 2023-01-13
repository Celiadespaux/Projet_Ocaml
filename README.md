


Utilisation et test de notre algorithme de Ford Fulkerson


Pour tester notre algorythme, il est nécessaire d'utiliser le makefile. La commande "make build" compilera le code. Ensuite, "make demo" le lancera. Les résultats seront affichés dans différents fichier. "graph_original" sera une image du graph utilisé pour l'expérience, "graph_de_flot_final" sera le graph après avoir ajouté un maximum de flot. Le dernier, "graph_residuel_final", nous montre le dernier graph résiduel utilisé pour la mise en place du graph de flot, il est utilisé ici pour tester et vérifier que notre algorithme fonctionne complètement.
Pour changer l'expérience et ajouter du flot entre des points différents (par défaut nous avons mis entre 0 et 5), il faut aller dans ftest.ml, et modifier les numéro des noeuds à la ligne 34.

Fichier moneysharing :
Ce fichier n'est actuellement pas utilisé dans notre projet. Il résulte de notre début de réflexion et premières idées à propos du problème de money sharing proposé. Il n'est dans l'état pas encore testable et utilisable.