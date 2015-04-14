-- Retourne les videos ordonnes par notes
SELECT noVideo, Video.nom, Video.description, AVG(AProposDe.notes) AS note_moyenne FROM AProposDe
    JOIN Video on Video.id = AProposDe.noVideo
    GROUP BY noVideo 
    ORDER BY note_moyenne
