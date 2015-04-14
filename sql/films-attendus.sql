-- bandes annonces des nouveautés
-- nouveauté avec un bon rating de bande-annonce

select Video.titre, Video.dateSortie from BandeAnnonce
    join Video on oeuvreId = Video.id
    where Video.id in (select noVideo from AProposDe  -- les mieux notés
                           group by noVideo
                           having AVG(note) >= 80)
    and dateSortie >= CURRENT_DATE - INTERVAL '3' MONTH -- les trois derniers mois
