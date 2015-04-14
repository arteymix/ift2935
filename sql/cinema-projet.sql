-- Afficher toutes les projections d'un film avec George Clooney dans les acteurs, y compris les projections ayant deja eu lieu. 
Select * 
From (Cinema join 
        (Select noCinema as nc, noVideo as nv FROM Projette WHERE nv IN 
            (Select noVideo From APourRole where APourRole.id IN
                (Select id From Acteur where Acteur.id IN 
                    (Select id as i From Personne WHERE prenom='George' AND nom='Clooney')))) 
            on Cinema.noCinema = nc); 
