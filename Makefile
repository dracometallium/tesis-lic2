NAME=tesis
TEX=$(NAME).tex
PROPUESTA=propuesta.tex
BIB=biblio.bib
AUX=$(TEX:.tex=.aux)
INCTEX=$(shell ls tex/*.tex)
FIGURAS=$(shell ls img/*.svg)
DATOS=$(shell ls img/*.dat)
DATOS_PDF=$(DATOS:.dat=_fps.pdf) $(DATOS:.dat=_maxTurnArround.pdf) $(DATOS:.dat=_turnArround.pdf) $(DATOS:.dat=_bestfps.pdf)
FIGURAS_PDF=$(FIGURAS:.svg=.pdf)
GARBAGE=*.aux *.bbl *.blg *.log *.pdf *.toc

all: $(NAME).pdf

$(NAME).pdf: $(FIGURAS_PDF) $(DATOS_PDF) $(TEX) $(BIB) $(INCTEX)
	pdflatex $(TEX)
	bibtex $(AUX)
	pdflatex $(TEX)
	pdflatex $(TEX)

propuesta:
	pdflatex $(PROPUESTA)
	bibtex $(PROPUESTA:.tex=.aux)
	pdflatex $(PROPUESTA)
	pdflatex $(PROPUESTA)

$(FIGURAS_PDF): $(FIGURAS)
	inkscape $(@:.pdf=.svg) -z -A $@

$(DATOS_PDF): $(DATOS) scripts/plot.gnuplot
	cd img && ../scripts/plot.sh
	cd img && ../scripts/plotbest.sh

clean:
	rm -f $(GARBAGE)
	rm -f $(FIGURAS_PDF) $(DATOS_PDF)
