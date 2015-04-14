---Trouver si l'usager emile222 peut se connecter s'il tape tyran0s0re comme mot
--de passe.
 ---(Retourne 1 si identification acceptee, 0 sinon)
select nomUtilisateur from Compte
	where nomUtilisateur=:username
	and motDePasse=:password
	--'emile222' and motDePasse='tyran0s0re';
