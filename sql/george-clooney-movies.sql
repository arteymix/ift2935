--George Clooney est realisateur

 (select id as i from Personne where prenom='George' and nom='Clooney');
  
        (select id from Realisateur where Realisateur.id in
           (select id as i from Personne where prenom='George' and nom='Clooney'));

    (select noVideo from Realise where Realise.id in
        (select id from Realisateur where Realisateur.id in
           (select id as i from Personne where prenom='George' and nom='Clooney')));
select titre from Video where id in
    (select noVideo from Realise where Realise.id in
        (select id from Realisateur where Realisateur.id in
           (select id as i from Personne where prenom='George' and nom='Clooney')));
