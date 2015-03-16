NAME=tesis
TEX=$(NAME).tex
PROPUESTA=propuesta.tex
BIB=biblio.bib
AUX=$(TEX:.tex=.aux)
GARBAGE=*.aux *.bbl *.blg *.log *.pdf *.toc

all:
	pdflatex $(TEX)
	bibtex $(AUX)
	pdflatex $(TEX)
	pdflatex $(TEX)

propuesta:
	pdflatex $(PROPUESTA)
	bibtex $(PROPUESTA:.tex=.aux)
	pdflatex $(PROPUESTA)
	pdflatex $(PROPUESTA)

clean:
	rm -f $(GARBAGE)
