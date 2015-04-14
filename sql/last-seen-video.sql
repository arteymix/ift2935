-- retourne le dernier video regarder par l'utilisateur 'e.trottier'
select noVideo FROM Loue where
	nomUtilisateur='e.trottier' ORDER BY dateLocation LIMIT 1;
