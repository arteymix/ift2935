-- Affiche le noms des 10 videos les plus visionnés
select * from
	(select titre, nbVisionnement, nbTelechargement from Video
		join Fichier on Video.id = Fichier.noVideo
		order by nbVisionnement desc, nbTelechargement desc)
	where rownum <= 10
