---Trouver le contenu de chaque article ecrit par un homme portant sur une serie dont la note est superieure a la moyenne des videos
Select id, contenu from Article where id in
(Select noArticle from AProposDe
where noVideo in (Select id from Serie)
and note > (Select AVG(note) from AProposDe)
and (Select sexe from Personne where id in
      (Select idJournaliste from
	(Select noArticle as na from AProposDe) join (Select id as ida, idJournaliste from Article) on na=ida))='homme'
)
