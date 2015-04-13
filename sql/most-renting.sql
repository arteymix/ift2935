SELECT noVideo ((SELECT Count(*) as c, chemin FROM Loue GROUP BY chemin) join Fichier on Fichier.chemin = chemin) ORDERED BY c
