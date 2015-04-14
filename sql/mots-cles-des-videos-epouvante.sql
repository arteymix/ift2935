-- mots clés des vidéos d'épouvante
select mot, count(videoId) as nombre_videos, AVG(importance) as importance_moyenne from MotCle where videoId in
	(select id from Video where genre='Épouvante' or genre='Horreur')
	group by mot
