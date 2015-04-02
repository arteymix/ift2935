---Le sexe est un varChar2(10) et est accompagne dans chaque table par une contrainte de domaine
---Creer un type sexe pourrait eviter toutes les redondances, mais je nai pas ete capable de le faire
---Meme strugle pour les genre des vidéos et cie et les contraintes genreDomaineXXX
---Les attributs heure et adresse et sont aussi "problematiques". Presentement, ce sont que des varChar2(4) et varChar2(200). Au pire, on se dit qu'on est capable de rentrer des bonnes données
---Le telephone est simplement un nombre de 10 chiffres, ce qui est legit
---
---CREATION DES TABLES
---liste des genres selon http://moviecovers.com/genres.html
CREATE TABLE Video(
	noVideo     number(6),
	description varChar2(200),
	titre       varChar(25) NOT NULL,
	dateSortie  date,
	genre       varChar2(20),
	constraint pkVideo
	primary key (noVideo),
	constraint genreDomaineV
	check (genre in('Action','Animation','Aventure','Biographique','Comédie','Court métrage','Documentaire','Drame','Épouvante','Érotique',
	'Espionnage','Essai','Fantastique','Guerre','Historique','Horreur','Manga','Muet','Musical','Policier','Romance','Science fiction','Spectacle',
	'Théâtre','Thriller','Western'))
);


CREATE TABLE Cinema(
	noCinema  number(5),
	nom       varChar2(20) NOT NULL,
	adresse   varChar2(200) NOT NULL,
	telephone number(10),
	email     varChar2(30),
	CONSTRAINT pkCinema
	PRIMARY KEY (noCinema)
);

---Contrainte: date de l'article plus tard que la date de sortie de l'oeuvre critiquée. Je crois qu'on doit l'ajouter par la suite par contre, avec un trigger
CREATE TABLE Article(
	noArticle       number(7),
	datePublication date,
	contenu         varChar2(2000) NOT NULL,
	note            number(3),
	CONSTRAINT pkArticle
	PRIMARY KEY (noArticle),
	CONSTRAINT noteDomaine
	CHECK (note>=0 and note<=100)
);

CREATE TABLE Personne(
	id            number(8),
	prenom        varChar2(30) NOT NULL,
	nom           varChar2(30) NOT NULL,
	sexe          varChar2(10),
	dateNaissance date NOT NULL,
	dateDeces     date,
	CONSTRAINT pkPersonne
	PRIMARY KEY (id),
	CONSTRAINT sexeDomainePersonne
	check( sexe in('homme', 'femme', 'inconnu','cache'))
);

CREATE TABLE Profesionnel(
	id            number(8),
	prenom        varChar2(30) NOT NULL,
	nom           varChar2(30) NOT NULL,
	sexe          varChar2(10),
	dateNaissance date NOT NULL,
	dateDeces     date,
	biographie    varChar2(2000),
	CONSTRAINT pkProfessionnel
	PRIMARY KEY (id),
	CONSTRAINT sexeDomainePro
	check( sexe in('homme', 'femme', 'inconnu','cache'))
);

CREATE TABLE Journaliste(
	id            number(8),
	prenom        varChar2(30) NOT NULL,
	nom           varChar2(30) NOT NULL,
	sexe          varChar2(10),
	dateNaissance date NOT NULL,
	dateDeces     date,
	CONSTRAINT pkJournaliste
	PRIMARY KEY (id),
	CONSTRAINT sexeDomaineJo
	check( sexe in('homme', 'femme', 'inconnu','cache'))
);

CREATE TABLE Acteur(
	id number(8),
	prenom varChar2(30) NOT NULL,
	nom varChar2(30) NOT NULL,
	sexe varChar2(10),
	dateNaissance date NOT NULL,
	dateDeces date,
	biographie varChar2(2000),
	CONSTRAINT pkActeur
	PRIMARY KEY (id),
	CONSTRAINT sexeDomaineAc
	check( sexe in('homme', 'femme', 'inconnu','cache'))
);

CREATE TABLE Realisateur(
	id            number(8),
	prenom        varChar2(30) NOT NULL,
	nom           varChar2(30) NOT NULL,
	sexe          varChar2(10),
	dateNaissance date NOT NULL,
	dateDeces     date,
	biographie    varChar2(2000),
	CONSTRAINT pkRealisateur
	PRIMARY KEY (id),
	CONSTRAINT sexeDomaineRea
	check( sexe in('homme', 'femme', 'inconnu','cache'))
);

CREATE TABLE MotCle(
	mot        varChar2(26),
	noVideo    number(6),
	importance number(3),
	constraint pkMotCle
	primary key (mot),
	constraint fkMotCle
	foreign key (noVideo) references Video(noVideo),
	constraint importanceDomaine
	check (importance>=0 and importance<=100)
);

CREATE TABLE Serie(
	noVideo      number(6),
	description  varChar2(200),
	titre        varChar(25) NOT NULL,
	dateSortie   date,
	genre        varChar2(20),
	numero       number(2),
	noVideoSerie number(6),
	constraint pkSerie
	primary key (noVideo),
	constraint genreDomaineSe
	check (genre in('Action','Animation','Aventure','Biographique','Comédie','Court métrage','Documentaire','Drame','Épouvante','Érotique',
	'Espionnage','Essai','Fantastique','Guerre','Historique','Horreur','Manga','Muet','Musical','Policier','Romance','Science fiction','Spectacle',
	'Théâtre','Thriller','Western')),
	constraint fkSerie
	foreign key (noVideoSerie) references Serie(noVideo),
	constraint numeroDomaineSe
	check (numero>=0)
);

CREATE TABLE OeuvreCinematographique(
	noVideo      number(6),
	description  varChar2(200),
	titre        varChar(25) NOT NULL,
	dateSortie   date,
	genre        varChar2(20),
	numero       number(2),
	noVideoSerie number(6),
	CONSTRAINT pkOeuvreCin
	PRIMARY KEY (noVideo),
	CONSTRAINT genreDomaineOC
	CHECK (genre IN('Action','Animation','Aventure','Biographique','Comédie','Court métrage','Documentaire','Drame','Épouvante','Érotique',
	'Espionnage','Essai','Fantastique','Guerre','Historique','Horreur','Manga','Muet','Musical','Policier','Romance','Science fiction','Spectacle',
	'Théâtre','Thriller','Western')),
	CONSTRAINT fkOeuvreCin
	FOREIGN KEY (noVideoSerie) REFERENCES Serie(noVideo),
	CONSTRAINT numeroDomaineOC
	CHECK (numero>=0)
);

CREATE TABLE Emission(
	noVideo      number(6),
	description  varChar2(200),
	titre        varChar(25) NOT NULL,
	dateSortie   date,
	genre        varChar2(20),
	numero       number(2),
	noVideoSerie number(6),
	CONSTRAINT pkEmission
	PRIMARY KEY (noVideo),
	CONSTRAINT genreDomaineEm
	CHECK (genre IN('Action','Animation','Aventure','Biographique','Comédie','Court métrage','Documentaire','Drame','Épouvante','Érotique',
	'Espionnage','Essai','Fantastique','Guerre','Historique','Horreur','Manga','Muet','Musical','Policier','Romance','Science fiction','Spectacle',
	'Théâtre','Thriller','Western')),
	CONSTRAINT fkEmisssion
	FOREIGN KEY (noVideoSerie) REFERENCES Serie(noVideo),
	CONSTRAINT numeroDomaineEm
	CHECK (numero>=0)
);

CREATE TABLE Film(
	noVideo      number(6),
	description  varChar2(200),
	titre        varChar(25) NOT NULL,
	dateSortie   date,
	genre        varChar2(20),
	numero       number(2),
	noVideoSerie number(6),
	CONSTRAINT pkFilm
	PRIMARY KEY (noVideo),
	CONSTRAINT genreDomaineFi
	CHECK (genre IN('Action','Animation','Aventure','Biographique','Comédie','Court métrage','Documentaire','Drame','Épouvante','Érotique',
	'Espionnage','Essai','Fantastique','Guerre','Historique','Horreur','Manga','Muet','Musical','Policier','Romance','Science fiction','Spectacle',
	'Théâtre','Thriller','Western')),
	CONSTRAINT fkFilm
	FOREIGN KEY (noVideoSerie) REFERENCES Serie(noVideo),
	CONSTRAINT numeroDomaineFi
	CHECK (numero>=0)
);

---J'ai essayé de faire la contrainte "NoVideo ne doit pas être dans OeuvreCin" maisje n'ai pas été capable. Marche pas:
---CONSTRAINT BAPasUneOeuvreCin
---CHECK (not(noVideo = ALL(select noVideo from OeuvreCinematographique )))
CREATE TABLE BandeAnnonce(
	noVideo     number(6),
	description varChar2(200),
	titre       varChar(25) NOT NULL,
	dateSortie  date,
	genre       varChar2(20),
	noOeuvreCin number(6),
	CONSTRAINT pkBandeAnnonce
	PRIMARY KEY (noVideo),
	CONSTRAINT genreDomaineBA
	CHECK (genre IN('Action','Animation','Aventure','Biographique','Comédie','Court métrage','Documentaire','Drame','Épouvante','Érotique',
	'Espionnage','Essai','Fantastique','Guerre','Historique','Horreur','Manga','Muet','Musical','Policier','Romance','Science fiction','Spectacle',
	'Théâtre','Thriller','Western')),
	CONSTRAINT fkBandeAnnonce
	FOREIGN KEY (noOeuvreCin) REFERENCES OeuvreCinematographique(noVideo)
);

CREATE TABLE Projette(
	noCinema        number(5),
	noVideo         number(6),
	dateProjection  date,
	heureProjection varChar2(4),
	CONSTRAINT pkProjette
	PRIMARY KEY (noCinema, noVideo, dateProjection, heureProjection),
	CONSTRAINT fk1Projette
	FOREIGN KEY (noCinema) REFERENCES Cinema(noCinema),
	CONSTRAINT fk2Projette
	FOREIGN KEY (noVideo) REFERENCES OeuvreCinematographique(noVideo)
);

CREATE TABLE AProposDe(
	noArticle number(7),
	noVideo   number(6),
	CONSTRAINT pkAProposDe
	PRIMARY KEY (noArticle, noVideo),
	CONSTRAINT fkArticleAProposDe
	FOREIGN KEY (noArticle) REFERENCES Article(noArticle),
	CONSTRAINT fkAProposDeVideo
	FOREIGN KEY (noVideo) REFERENCES Video(noVideo)
);

---decimal(5,2) correspond à un nombre de la forme xxx.xx comme 123.45
---Il n y a pas de type boolean dans oracle, alors estArchive est un number de 1 chiffre, not null, avec contrainte de domaine
CREATE TABLE Fichier(
	chemin           varChar2(50),
	prix             decimal(5,2) NOT NULL,
	nbTelechargement number(10),
	nbVisionnement   number(10),
	dateAcquisition  date,
	estArchive       number(1) NOT NULL,
	noVideo          number(6),
	constraint pkFichier
	primary key (chemin),
	constraint fkFichier
	foreign key (noVideo) references Video(noVideo),
	constraint prixFichierPositif
	check (prix>=0),
	constraint estArchiveBool
	check (estArchive in (0,1)),
	constraint nbTelechargementPositif
	check (nbTelechargement>=0),
	constraint nbVisionnementPositif
	check (nbVisionnement>=0)
);

CREATE TABLE Compte(
	nomUtilisateur  varChar2(15),
	motDePasse      varChar2(15) NOT NULL,
	adresse         varChar2(200),
	telephone       number(10),
	dateInscription date,
	id              number(8),
	CONSTRAINT pkCompte
	PRIMARY KEY (nomUtilisateur),
	CONSTRAINT fkCompte
	FOREIGN KEY (id) REFERENCES Personne(id)
);

CREATE TABLE Loue(
	nomUtilisateur varChar2(15),
	chemin         varChar2(50),
	dateLocation   date,
	heureLocation  varChar2(4),
	prix           decimal(5,2) NOT NULL,
	CONSTRAINT pkLoue
	PRIMARY KEY (nomUtilisateur, chemin, dateLocation, heureLocation),
	CONSTRAINT fk1Loue
	FOREIGN KEY (nomUtilisateur) REFERENCES Compte(nomUtilisateur),
	CONSTRAINT fk2Loue
	FOREIGN KEY (chemin) REFERENCES Fichier(chemin),
	CONSTRAINT prixLocationPositif
	CHECK (prix>=0)
);

CREATE TABLE APourRole(
	id            number(8),
	noVideo       number(6),
	nomPersonnage varChar2(20),
	CONSTRAINT pkAPourRole
	PRIMARY KEY (id, noVideo),
	CONSTRAINT fk1APourRole
	FOREIGN KEY (id) REFERENCES Acteur(id),
	CONSTRAINT fk2APourRole
	FOREIGN KEY (noVideo) REFERENCES Video(noVideo)
);

CREATE TABLE Realise(
	id      number(8),
	noVideo number(6),
	CONSTRAINT pkRealise
	PRIMARY KEY (id, noVideo),
	CONSTRAINT fk1Realise
	FOREIGN KEY (id) REFERENCES Realisateur(id),
	CONSTRAINT fk2Realise
	FOREIGN KEY (noVideo) REFERENCES Video(noVideo)
);

---INSERTION DE DONNEES
---Est-ce qu'on crée des vidéos ou c'est comme une classe abstraite?


---Cinema(12345,'nom','adresse',5141234567,'email')
insert into Cinema values (00001, 'Banque Scotia Montréal', '977 rue Ste-Catherine O. H3B4W3', 5148420549, 'banquescotiamontreal@gmail.com');
insert into Cinema values (00002, 'Cinéma du Parc', '3575 avenue du Parc H2X3P9', 5142811900, 'cinemaduparc@gmail.com');
insert into Cinema values (00003, 'Cineplex Odeon Quartier Latin', '350 rue Émery H2X1J1', 5148492244, 'quartierlatin@gmail.com');
insert into Cinema values (00004, 'Beaubien', '2396 rue Beaubien Est H2G1N2', 5147216060, 'cinemabeaubien@gmail.com');
insert into Cinema values (00005, 'Capitol St-Jean', '286 rue Richelieu J3B6Y4', 4503583030, 'capitolstjean@gmail.com');
insert into Cinema values (00006, 'Carnaval', '240 boulevard St-Jean Baptiste J6K3L2', 4506912463, 'cinemacarnaval@gmail.com');
insert into Cinema values (00007, 'Carrefour Angrignon', '7077 boulevard Newman H8N1X1', 5143662444, 'carrefourangrignon@gmail.com');
insert into Cinema values (00008, 'Centre Phi', '407 rue St-Pierre H2Y2M3', 5142250525, 'centrephi@gmail.com');
insert into Cinema values (00009, 'Cinémathèque québécoise', '335 boulevard Maisonneuve Est H2X1K1', 5148429763, 'cinemathequequebecoise@gmail.com');
insert into Cinema values (00010, 'Ciné-Club de Laval', '475 boulevard de l\'Avenir H7N5H9', 4506672040, 'cineclublaval@gmail.com');
insert into Cinema values (00011, 'Ciné-Club du Quartier', '15615 boulevard Gouin Ouest H9H5K8', 5146261616, 'cineclubduquartier@gmail.com');
insert into Cinema values (00012, 'Cinéma 7 Valleyfield', '50 rue Dufferin J6S4W4', 4503711003, 'cinema7valleyfield@gmail.com');
insert into Cinema values (00013, 'Cinéma Beloeil', '450 rue Serge Pépin J3G0C3', 4504646666, 'cinemabeloeil@gmail.com');
insert into Cinema values (00014, '', '59 St-Denis', 1234567890, 'quartierlatin@gmail.com');


---genre in('Action','Animation','Aventure','Biographique','Comédie','Court métrage','Documentaire','Drame','Épouvante','Érotique',
---'Espionnage','Essai','Fantastique','Guerre','Historique','Horreur','Manga','Muet','Musical','Policier','Romance','Science fiction','Spectacle',
---'Théâtre','Thriller','Western')
---Video(id,'description','titre',dateSortie,'genre')
insert into Video values (123456, 'Blablabla', 'Le Hobbit', to_date('10/10/14', 'DD/MM/YY'), 'Aventure');

insert into Article values(0000001, to_date('19/02/08', 'DD/MM/YY'), 'Le Hobbit est un mauvais film', 13);




---DESTRUCTION DES TABLES
DROP TABLE MotCle;
DROP TABLE Emission;
DROP TABLE Film;
DROP TABLE APourRole;
DROP TABLE Realise;
DROP TABLE Loue;
DROP TABLE Profesionnel;
DROP TABLE Journaliste;
DROP TABLE BandeAnnonce;
DROP TABLE AProposDe;
DROP TABLE Compte;
DROP TABLE Personne;
DROP TABLE Acteur;
DROP TABLE Realisateur;
DROP TABLE Article;
DROP TABLE Fichier;
DROP TABLE Projette;
DROP TABLE Cinema;
DROP TABLE OeuvreCinematographique;
DROP TABLE Serie;
DROP TABLE Video;
