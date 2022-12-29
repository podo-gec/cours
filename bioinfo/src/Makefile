.PHONY: clean

all: *.pdf

%.pdf : %.org
	 org-beamer $^

clean:
	rm -f *.tex *.tex~ *.html~ *.png *blx.bib *.bbl *.synctex.gz

