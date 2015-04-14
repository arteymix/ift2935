---article ecrit par un homme
Select distinct noArticle from AProposDe
where (Select sexe from Personne where id in
      (Select idJournaliste from
	(Select noArticle as na from AProposDe) join (Select id as ida, idJournaliste from Article) on na=ida))='homme'
