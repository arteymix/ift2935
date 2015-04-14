all:
	LD_LIBRARY_PATH=instantclient_10_2 python app.py

README.pdf: README.md
	pandoc $< -o $@

rapport.pdf: rapport.md
	pandoc $< -o $@
