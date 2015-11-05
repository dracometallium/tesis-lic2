NAME=tesis
TEX=$(NAME).tex
PROPUESTA=propuesta.tex
BIB=biblio.bib
AUX=$(TEX:.tex=.aux)
FIGURAS=$(shell ls img/*.svg)
FIGURAS_PDF=$(FIGURAS:.svg=.pdf) 
GARBAGE=*.aux *.bbl *.blg *.log *.pdf *.toc

all: $(NAME).pdf

$(NAME).pdf: $(FIGURAS_PDF) $(TEX) $(BIB:.bib=.bbl)
	pdflatex $(TEX)
	pdflatex $(TEX)
	
$(BIB:.bib=.bbl): $(AUX) $(BIB)
	bibtex $(AUX)

$(AUX):
	pdflatex $(TEX)

propuesta:
	pdflatex $(PROPUESTA)
	bibtex $(PROPUESTA:.tex=.aux)
	pdflatex $(PROPUESTA)
	pdflatex $(PROPUESTA)

$(FIGURAS_PDF): $(@:.pdf=.svg)
	inkscape $(@:.pdf=.svg) -z -A $@	

clean: 
	rm -f $(GARBAGE)
	rm -f $(FIGURAS_PDF)
