-- Retourne les videos ordonnes par notes
SELECT noVideo, AVG(notes) AS note_moyenne FROM Article GROUP BY noVideo ORDER BY note_moyenne;
