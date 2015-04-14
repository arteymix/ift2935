-- affiche les vidéos ordonné par leur note moyenne
select titre, description, avg(note) as note_moyenne from Video
	join AProposDe on Video.id = AProposDe.noVideo
	group by video.id, video.titre, description
	order by avg(note) desc

