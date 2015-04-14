-- article dont la note est superieur a la moyenne
select distinct noArticle from AProposDe
	where note > (select AVG(note) from AProposDe)

