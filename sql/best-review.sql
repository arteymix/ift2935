-- Retourne les videos ordonnes par notes
-- Ca a pas rapport ce requete la.
--SELECT noVideo, Video.nom, Video.description, AVG(AProposDe.notes) AS note_moyenne FROM AProposDe
--    JOIN Video on Video.id = AProposDe.noVideo
--    GROUP BY noVideo 
--    ORDER BY note_moyenne


Select video.id, titre, avg(note) from Video join AProposDe on Video.id = AProposDe.noVideo group by (video.id, video.titre) order by avg(note) desc;

