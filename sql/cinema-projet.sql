-- affiche toutes les projections d'un film avec George Clooney comme acteur,
-- y compris les projections ayant déjà eu lieu
select *
from (Cinema join
        (select noCinema as nc, noVideo as nv from Projette where Projette.noVideo IN
            (select noVideo from APourRole where APourRole.id IN
                (select id from Acteur where Acteur.id IN
                    (select id as i from Personne where prenom='George' AND nom='Clooney'))))
            on Cinema.id = nc)
