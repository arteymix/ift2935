--George Clooney est realisateur

Select titre From Video where noVideo IN
(Select noVideo From Realise where Realise.id IN
    (Select id From Realisateur where Realisateur.id IN 
        (Select id as i From Personne WHERE prenom='George' AND nom='Clooney')));
