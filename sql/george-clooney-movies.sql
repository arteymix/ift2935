--George Clooney est realisateur, affiche les film realiser par george clooney

-- todo: union avec les films ou il est acteur

select titre, description, DECODE(Realise.id, null, '--', 'Réalisateur') as realisateur,
		DECODE(APourRole.id, null, '--', nomPersonnage) as nom_personnage
	from Video
	left join Realise on Realise.noVideo = Video.id   --
	left join APourRole on APourRole.noVideo = Video.id --
	where Realise.id in (select id as i from Personne where prenom='George' and nom='Clooney')
	or    APourRole.id in (select id as i from Personne where prenom='George' and nom='Clooney')
