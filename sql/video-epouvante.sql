---Trouver tous les mots cles de video d'epouvante ou d'horreur
Select distinct mot from MotCle where videoId in
(Select id from Video where genre='Épouvante' or genre='Horreur');