-- affiche les acteurs pour un vidéo donné
select * from APourRole
	join personne on apourrole.id = personne.id
	where apourrole.noVideo = :video_id
