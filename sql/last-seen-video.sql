-- retourne le dernier video regarder par l'utilisateur 'e.trottier'
select titre, dateLocation from Loue
    natural join Fichier
    join Video on Video.id = Fichier.noVideo -- jointure sur le chemin
    where nomUtilisateur='e.trottier'
    and rownum <= 1
    ORDER BY dateLocation
