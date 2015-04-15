rapport-comlpet.pdf: rapport.pdf
	pdfunite $< README.pdf modele-entite-association.pdf $@

rapport.pdf: rapport.md
	pandoc $< -o $@
