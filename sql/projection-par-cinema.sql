-- affiche les oeuvres projettes par cinéma
select * from OeuvreCinematographique
	join projette on OeuvreCinematographique.id = Projette.noVideo
	join cinema on Cinema.id = Projette.noCinema
	where cinema.id = :cinema_id -- parametrer avec un id de cinema
	order by dateProjection, heureProjection
