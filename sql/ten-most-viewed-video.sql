--Affiche le noms des 10 videos les plus telecharges
select titre, nbTelechargement from Video
    natural join Fichier
    where rownum <= 10
    order by nbTelechargement
