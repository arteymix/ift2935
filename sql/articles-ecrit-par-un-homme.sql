-- article écrit par un homme
Select noArticle from AProposDe
	join Article on Article.id = AProposDe.noArticle
	join Personne on id = Article.idJournaliste
	where sexe = 'homme'
