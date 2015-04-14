-- mots clés des vidéos d'épouvante
select distinct mot from MotCle where videoId in
	(select id from Video where genre='Épouvante' or genre='Horreur')
