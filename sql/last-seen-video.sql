-- derniers vidéos regardés avec le dernier commentaire et la dernière note
select titre, description, nomUtilisateur, dateLocation, contenu, coalesce(note, 0) as note from Loue
	natural join Fichier
	join Video on Video.id = Fichier.noVideo -- jointure sur le chemin
	left join AProposDe on AProposDe.noVideo = Video.id
	left join Article on Article.id = AProposDe.noArticle
	join Personne on Article.idAuteur = Personne.id
	GROUP BY video.id, titre, description, nomUtilisateur, article.id, dateLocation, datePublication, contenu, note
	ORDER BY dateLocation DESC, datePublication DESC
