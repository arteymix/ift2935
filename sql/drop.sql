---Le sexe est un varchar2(10) et est accompagne dans chaque table par une contrainte de domaine
---Creer un type sexe pourrait eviter toutes les redondances, mais je nai pas ete capable de le faire
---Meme strugle pour les genre des vidéos et cie et les contraintes genreDomaineXXX
---Les attributs heure et adresse et sont aussi "problematiques". Presentement, ce sont que des varchar2(4) et varchar2(200). Au pire, on se dit qu'on est capable de rentrer des bonnes données
---Le telephone est simplement un nombre de 10 chiffres, ce qui est legit
---
---CREATION DES tableS
---liste des genres selon http://moviecovers.com/genres.html

drop procedure insertSerie;
drop procedure insertEmission;
drop procedure insertFilm;
drop procedure insertBandeAnnonce;

drop sequence video_seq;
drop trigger video_pk_gen;


---DESTRUCTION DES tableS
alter table OeuvreCinematographique drop constraint fkoeuvrecin_ID;
alter table OeuvreCinematographique drop constraint fkoeuvrecin_Serie;
--alter table Professionnel drop constraint fkProfessionnel;

DROP table MotCle;

DROP table Loue;

DROP table APourRole;
DROP table Realise;

DROP table Projette;
DROP table Cinema;

alter table Serie drop constraint fkSerieNoVideo_id; 

DROP table AProposDe;
DROP table Article;
DROP table Fichier;
DROP table Emission;
DROP table Film;
DROP table Serie;
DROP table BandeAnnonce;
DROP table OeuvreCinematographique;

DROP table Video;


DROP table Acteur;
DROP table Realisateur;
DROP table Professionnel;
DROP table Journaliste;
DROP table Compte;
DROP table Personne;

