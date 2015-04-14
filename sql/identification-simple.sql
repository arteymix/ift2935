-- trouve l'usager selon son nom d'utilisateur et son mot de passe

select nomUtilisateur from Compte
	where nomUtilisateur=:username
	and motDePasse=:password
	--'emile222' and motDePasse='tyran0s0re';
