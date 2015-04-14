---Trouver le contenu de chaque article ecrit par un homme portant sur une serie dont la note est superieure a la moyenne des videos
select prenom, nom, video.titre, contenu, note, datePublication from Article
	join AProposDe on Article.id = AProposDe.noArticle
	join Personne on Article.idJournaliste = Personne.id
	join Serie on noVideo = Serie.id
	join Video on Serie.id = Video.id
	and Personne.sexe = 'homme'
	and note > (select AVG(note) from AProposDe)
