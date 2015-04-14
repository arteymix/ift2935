drop procedure insertSerie;
drop procedure insertEmission;
drop procedure insertFilm;
drop procedure insertBandeAnnonce;

drop sequence video_seq;
drop trigger video_pk_gen;


---DESTRUCTION DES tableS
alter table OeuvreCinematographique drop constraint fkoeuvrecin_ID;
alter table OeuvreCinematographique drop constraint fkoeuvrecin_Serie;

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

