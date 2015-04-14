-- retourne le dernier video regarder par l'utilisateur 'e.trottier'
Select titre FROM Video where NoVideo in  
    (select noVideo FROM Loue where
	    nomUtilisateur='e.trottier' 
	    ORDER BY dateLocation LIMIT 1);
