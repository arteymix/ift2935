README.pdf: README.md
	pandoc $< -o $@
