---CREATION DES tableS

create table Personne(
	id            number(8) primary key,
	prenom        varchar2(30) not null,
	nom           varchar2(30) not null,
	sexe          varchar2(10), -- queer :)
	dateNaissance date not null,
	dateDeces     date
);

create table Journaliste (
	id          number(8) primary key,
--
	constraint fkJournaliste foreign key (id) references Personne
);

create table Professionnel (
	id          number(8) primary key,
	biographie  varchar2(4000),
--
	constraint fkProfessionnel foreign key (id) references Personne
);

create table Acteur (
	id	number(8) primary key,
--
	constraint fkActeur foreign key (id) references Professionnel
);

create table Realisateur (
	id	number(8) primary key,
--
	constraint fkRealisateur foreign key (id) references Professionnel
);



--
-- VIDEO
--
create table Video(
	id			number(6) primary key,
	description	varchar2(4000),
	titre		varchar(100) not null,
	dateSortie	date,
	genre		varchar2(20),
--
	constraint genreDomaine
	check (genre in('Action', 'Animation', 'Aventure', 'Biographique',
			'Comédie', 'Court métrage', 'Documentaire', 'Drame',
			'Épouvante', 'Érotique', 'Espionnage', 'Essai',
			'Fantastique', 'Guerre', 'Historique', 'Horreur',
			'Manga', 'Muet', 'Musical', 'Policier', 'Romance',
			'Science fiction', 'Spectacle', 'Théâtre', 'Thriller',
			'Western'))
);


create sequence video_seq;

create or replace trigger video_pk_gen
before insert on video
for each row begin
	select video_seq.nextval
  into :new.id
	from dual;
end;
/


create table Fichier (
	chemin				varchar2(300),
	prix				decimal(5,2) not null,
	nbTelechargement	number(10) default 0 not null,
	nbVisionnement		number(10) default 0 not null,
	dateAcquisition		date,
	estArchive			number(1) not null, -- boolean
	noVideo				number(6),
--
	constraint pkFichier primary key (chemin),
	constraint fkFichier foreign key (noVideo) references Video(id),
	constraint prixFichierPositif check (prix >= 0),
	constraint estArchiveBool check (estArchive in (0,1)),
	constraint nbTelechargementPositif check (nbTelechargement >= 0),
	constraint nbVisionnementPositif check (nbVisionnement >= 0)
);


create table Serie (
	id	number(6) primary key
--
--	constraint fkSerieNoVideo_id foreign key (id) references OeuvreCinematographique(id)
);

create table OeuvreCinematographique(
	id		number(6) primary key,
	numero	number(6) default null,
	serie	number(6) default null,
--
	constraint fkOeuvreCin_id foreign key (id) references Video(id),
	constraint fkOeuvreCin_serie foreign key (serie) references Serie(id),
	constraint numeroDomaineOC check (numero >= 0)
);

alter table Serie add constraint fkSerieNoVideo_id foreign key (id) references OeuvreCinematographique(id);

create table Emission(
	id number(6) primary key,
--
	constraint fkEmission foreign key (id) references OeuvreCinematographique(id)
);

create table Film(
	id number(6) primary key,
--
	constraint fkFilm foreign key (id) references OeuvreCinematographique(id)
);

create table BandeAnnonce(
	id 			number(6) primary key,
	oeuvreId	number(6), -- oeuvre cinématographique associée
--
	constraint fkBandeAnnonce_id foreign key (id) references Video(id),
	constraint fkBandeAnnonce_oeuvreId foreign key (oeuvreId) references OeuvreCinematographique(id)
);


create procedure insertSerie(
  de in video.description%type,
  ti in video.titre%type,
  da in video.dateSortie%type,
  ge in video.genre%type,
  nu in OeuvreCinematographique.numero%type,
  se in OeuvreCinematographique.serie%type
) is
  id video.id%type;
begin
  insert into video(description, titre, dateSortie, genre) values(de, ti, da, ge);
  select video_seq.currval into id from dual;
  insert into oeuvreCinematographique values(id, nu, se);
  insert into Serie values(id);
  commit;
end;
/

create procedure insertFilm(
  de in video.description%type,
  ti in video.titre%type,
  da in video.dateSortie%type,
  ge in video.genre%type,
  nu in OeuvreCinematographique.numero%type,
  se in OeuvreCinematographique.serie%type
) is
  id video.id%type;
begin
  insert into video(description, titre, dateSortie, genre) values(de, ti, da, ge);
  select video_seq.currval into id from dual;
  insert into oeuvreCinematographique values(id, nu, se);
  insert into film values(id);
  commit;
end;
/

create procedure insertEmission(
  de in video.description%type,
  ti in video.titre%type,
  da in video.dateSortie%type,
  ge in video.genre%type,
  nu in OeuvreCinematographique.numero%type,
  se in OeuvreCinematographique.serie%type
) is
  id video.id%type;
begin
  insert into video(description, titre, dateSortie, genre) values(de, ti, da, ge);
  select video_seq.currval into id from dual;
  insert into oeuvreCinematographique values(id, nu, se);
  insert into Emission values(id);
  commit;
end;
/

create procedure insertBandeAnnonce(
  de in video.description%type,
  ti in video.titre%type,
  da in video.dateSortie%type,
  ge in video.genre%type,
  oi in OeuvreCinematographique.id%type
) is
  id video.id%type;
begin
  insert into video(description, titre, dateSortie, genre) values(de, ti, da, ge);
  select video_seq.currval into id from dual;
  insert into BandeAnnonce values(id, oi);
  commit;
end;
/


create table MotCle(
	mot        varchar2(26),
	videoId    number(6),
	importance number(3),
--
	constraint pkMotCle primary key (mot, videoId),
	constraint fkMotCle_video_id foreign key (videoId) references Video(id),
	constraint importanceDomaine check (importance >= 0 and importance <= 100)
);


--
-- CINEMA
--
create table Cinema(
	id			number(5) primary key,
	nom			varchar2(50) not null,
	adresse		varchar2(200) not null,
	telephone	varchar2(12),
	email		varchar2(50),
--
	constraint check_cinema_telephone check (REGEXP_LIKE(telephone,'^[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]$')),
	constraint check_cinema_email check (REGEXP_LIKE(email,'^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$'))
);

create table Projette(
	noCinema        number(5),
	noVideo         number(6),
	dateProjection  date,
--
	constraint pkProjette primary key (noCinema, noVideo, dateProjection),
	constraint fkProjette_noCinema foreign key (noCinema) references Cinema(id),
	constraint fkProjette_noVideo foreign key (noVideo) references OeuvreCinematographique(id)
);


--
-- A PROPOS
--
create table Article(
	id		number(7)      primary key,
	datePublication	date,
	contenu		varchar2(2000) not null,
	idAuteur        number(8),
--
	constraint fkAuteur_article foreign key (idAuteur) references Personne(id)
);

create table AProposDe(
	noArticle	number(7),
	noVideo		number(6),
	note		number(3),
--
	constraint pkAProposDe primary key (noArticle, noVideo),
	constraint fkArticleAProposDe foreign key (noArticle) references Article(id),
	constraint fkAProposDeVideo foreign key (noVideo) references Video(id),
	constraint noteDomaine check (note>=0 and note<=100)
);

create table Compte (
	nomUtilisateur	varchar2(55) primary key,
	motDePasse		varchar2(35) not null,
	adresse			varchar2(200),
	telephone		varchar2(12),
	dateInscription	date,
	idPerso			number(8) not null,
--
	constraint fkCompte_idPerso	foreign key (idPerso) references Personne(id),
	constraint check_compte_telephone check (REGEXP_LIKE(telephone,'^[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]$'))
);

create table Loue (
	nomUtilisateur	varchar2(15),
	chemin			varchar2(50),
	dateLocation	date,
	prix			decimal(5,2) not null,
--
	constraint pkLoue primary key (nomUtilisateur, chemin, dateLocation),
	constraint fk1Loue foreign key (nomUtilisateur) references Compte(nomUtilisateur),
	constraint fk2Loue foreign key (chemin) references Fichier(chemin),
	constraint prixLocationPositif check (prix >= 0)
);

create table APourRole (
	id            number(8),
	noVideo       number(6),
	nomPersonnage varchar2(20),
--
	constraint pkAPourRole primary key (id, noVideo),
	constraint fkAPourRole_id foreign key (id) references Acteur(id),
	constraint fk2APourRole_video foreign key (noVideo) references Video(id)
);

create table Realise(
	id      number(8),
	noVideo number(6),
--
	constraint pkRealise primary key (id, noVideo),
	constraint fkRealise_id foreign key (id) references Realisateur(id),
	constraint fkRealise_video foreign key (noVideo) references Video(id)
);
