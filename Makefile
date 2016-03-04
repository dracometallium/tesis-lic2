NAME=tesis
TEX=$(NAME).tex
PROPUESTA=propuesta.tex
BIB=biblio.bib
AUX=$(TEX:.tex=.aux)
INCTEX=$(shell ls tex/*.tex)
FIGURAS=$(shell ls img/*.svg)
FIGURAS_PDF=$(FIGURAS:.svg=.pdf) 
GARBAGE=*.aux *.bbl *.blg *.log *.pdf *.toc

all: $(NAME).pdf

$(NAME).pdf: $(FIGURAS_PDF) $(TEX) $(BIB) $(INCTEX)
	pdflatex $(TEX)
	bibtex $(AUX)
	pdflatex $(TEX)
	pdflatex $(TEX)

propuesta:
	pdflatex $(PROPUESTA)
	bibtex $(PROPUESTA:.tex=.aux)
	pdflatex $(PROPUESTA)
	pdflatex $(PROPUESTA)

%.pdf: %.svg
	inkscape $< -z -A $@	

clean: 
	rm -f $(GARBAGE)
	rm -f $(FIGURAS_PDF)
