-- Select the top 10 most located movie
Select titre FROM Video where noVideo in (SELECT noVideo from ((SELECT Count(*) as c, chemin as d FROM Loue GROUP BY chemin ORDER BY c LIMIT 10) join Fichier on Fichier.chemin = d));
