-- affiche toutes les bandes-annonces des séries d'un certain genre

select serie.id, video.titre, video.description, fichier.chemin from serie
	join video on video.id = serie.id
	join bandeannonce on bandeannonce.oeuvreId = serie.id
	join fichier on fichier.noVideo = bandeannonce.id
	where genre = 'Épouvante'
	order by video.dateSortie DESC

 -- remplacer par :genre , les plus récents en premier
