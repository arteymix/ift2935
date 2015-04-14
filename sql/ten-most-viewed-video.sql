--Affiche le noms des 10 videos les plus telecharges
Select titre From Video join (Select noVideo as i from Fichier ORDER BY nbTelechargement LIMIT 10) on Video.noVideo = i;

