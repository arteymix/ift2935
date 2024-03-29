-- les titres 10 vidéos les plus loués avec le nombre de locations

select * from
    (select noVideo, titre, count(*) as locations from Loue
        natural join Fichier -- jointure sur le chemin
        join Video on Video.id = Fichier.noVideo
        group by noVideo, titre
        order by locations desc)
    where rownum <= 10
