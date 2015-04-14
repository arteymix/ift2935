-- Selectionne les films réalisé par le ou les réalisateurs du dernier film loué par l'utilisateur 'e.trottier'
select titre From (Video join (select noVideo as n from Realise where Realise.id in 
(select id from Realise where Realise.noVideo in (select noVideo From Fichier where Fichier.chemin in 
    (select chemin FROM Loue where
    	nomUtilisateur='e.trottier' ORDER BY dateLocation LIMIT 1)))) on Video.noVideo = n);	
	


