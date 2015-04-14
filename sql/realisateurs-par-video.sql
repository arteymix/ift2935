-- affiche les réalisateurs pour un vidéo donné
select * from realise
	join personne on realise.id = personne.id
	where realise.noVideo = :video_id
