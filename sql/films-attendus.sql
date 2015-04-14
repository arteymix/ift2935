-- bandes annonces des nouveautés
-- nouveauté avec un bon rating de bande-annonce

select Video.titre, Video.dateSortie, AVG(note) as note_moyenne, COALESCE(SUM(nbVisionnement), 0) visionnements_bandes_annonces from Film
	join Video on Film.id = Video.id
	join AProposDe on Video.id = AProposDe.noVideo
	left join BandeAnnonce on BandeAnnonce.oeuvreId = video.id
	left join Fichier on Fichier.noVideo = BandeAnnonce.id
	-- and dateSortie > CURRENT_DATE - INTERVAL '1' MONTH -- le dernier mois
	group by video.id, video.titre, dateSortie
	having AVG(note) >= 80 -- commentaires sur la vidéo
	order by AVG(note) desc
