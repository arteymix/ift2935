-- sélectionne le nom des films réalisés par un réalisateur donné
select titre From Video
	join (select noVideo as n from Realise where Realise.id = :realisateur_id)
	on Video.noVideo = n

