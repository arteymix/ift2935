---article dont la note est superieur a la moyenne
Select distinct noArticle from AProposDe
	where note > (Select AVG(note) from AProposDe)

