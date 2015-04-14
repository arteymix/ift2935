-- Select the top 10 most located movie and print their title.

select titre, count(*) from Loue
    natural join Video -- jointure sur le chemin
    where rownum <= 10
    group by chemin, titre
