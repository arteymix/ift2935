---Trouver le contenu de chaque article ecrit par un homme portant sur une serie dont la note est superieure a la moyenne des videos
Select id, contenu from Article where id in
(Select noArticle from AProposDe
where noVideo in (Select id from Serie)
and note > (Select AVG(note) from AProposDe)
and (Select sexe from Personne where id in
      (Select idJournaliste from
	(Select noArticle as na from AProposDe) join (Select id as ida, idJournaliste from Article) on na=ida))='homme'
);
---article sur des series
Select distinct noArticle from AProposDe
where noVideo in (Select id from Serie)
;

---article dont la note est superieur a la moyenne
Select distinct noArticle from AProposDe
where note > (Select AVG(note) from AProposDe)
;

---article ecrit par un homme
Select distinct noArticle from AProposDe
where (Select sexe from Personne where id in
      (Select idJournaliste from
	(Select noArticle as na from AProposDe) join (Select id as ida, idJournaliste from Article) on na=ida))='homme'
;

---moyenne des notes des articles
Select AVG(note) from AProposDe;
