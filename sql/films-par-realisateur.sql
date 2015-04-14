-- sélectionne le nom des films réalisés par un réalisateur donné
select id, titre, description from Video
	join (select noVideo as n from Realise where Realise.id = :realisateur_id)
	on Video.id = n

