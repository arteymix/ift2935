-- oeuvre cinématographique projetées par un cinéma donné
select id, video.titre, video.description, dateProjection, heureProjection from oeuvrecinematographique
	join projette on OeuvreCinematographique.id = Projette.noVideo
	natural join video
	join cinema on Cinema.id = Projette.noCinema
	where cinema.id = :cinema_id -- parametrer avec un id de cinema
	order by dateProjection, heureProjection
