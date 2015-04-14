-- Affiche les series du genre donnes. sans repetition (Affiche The Walking Dead et pas The Walking Dead - Season 1)
-- affiche les bande-annonces des séries du genre donné

Select * From  serie
	join video on video.id = serie.id
	where video.genre = 'Épouvante' 
	order by video.dateSortie DESC;
 -- les plus récents en premier

Select * From  serie
	join video on video.id = serie.id
	join bandeannonce on bandeannonce.oeuvreId = serie.id
	where genre = 'Épouvante' 
	order by video.dateSortie DESC;
 -- les plus récents en premier

select serie.id, video.titre, video.description, fichier.chemin from serie
	join video on video.id = serie.id
	join bandeannonce on bandeannonce.oeuvreId = serie.id
	join fichier on fichier.noVideo = bandeannonce.id
	where genre = 'Épouvante' 
	order by video.dateSortie DESC;

 -- remplacer par :genre , les plus récents en premier
