-- retourne le dernier video regarder par l'utilisateur 'e.trottier'
select titre, description, nomUtilisateur, dateLocation, heureLocation from Loue
	natural join Fichier
	join Video on Video.id = Fichier.noVideo -- jointure sur le chemin
	ORDER BY dateLocation
