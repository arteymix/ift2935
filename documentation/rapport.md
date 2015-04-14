% Rapport de projet final
% Vincent Antaki Alexandre St-Louis Fortier
% Guillaume Poirier-Morency Émile Trottier

Les fichiers de requêtes SQL sont structurés de la manière suivante dans le
dossier `sql/`:

Fichier       Utilité
-------       -------
schema.sql    crée la structure de la base
drop.sql      détruit la structure de la base
insertion.sql popule la base de données

Les autres fichiers servent à stocker les requêtes SQL individuelles.

Article inséré

Implémentation de l'application
-------------------------------

Le projet est basé sur [flask](flask.pocoo.org), un micro-framework web en
Python.

Une application peut être facilement décrite à l'aide d'un mécanisme de routage
par décorateur.

```python
@app.route('/')
def home():
    return "<html>Page web!</html>"
```

Des routes ont été déclarées pour

 - afficher les cinémas qui projettent des films
 - authentifier l'usager
	- effectuer une rechercheA
	- afficher les projections d'un cinéma
	- exécuter une requête et afficher les résultats
	- afficher les données d'un vidéo

Les routes utilisent diverse requêtes en plus de celle demandées. Elles
permettent, entre autre, de récupérer les réalisateurs d'un vidéo et de valider
l'identité d'un usager.

L'exécution des 10 requêtes demandées se fait au sein de la même route. Un
fichier contenant la requête est lu et exécuté sur la base de données. Un
template générique s'occupe de présenter les résultats dans un tableau.

![blabla](../screenshots/exemple-de-requete-sql.png)

Un usager peut s'authentifier à l'aide d'un nom d'utilisateur et d'un mot de
passe.

