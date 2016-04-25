NAME=tesis
TEX=$(NAME).tex
PROPUESTA=propuesta.tex
BIB=biblio.bib
AUX=$(TEX:.tex=.aux)
INCTEX=$(shell ls tex/*.tex)
FIGURAS=$(shell ls img/*.svg)
RES=$(shell ls img/*.res)
BRES=$(RES:.res=.bres)
DATOS=$(RES:.res=.dat)
PRIMOS=img/primos.pdat
AREAS=img/areas.pdat
CACHE=img/cache.pdat
CACHE_PDF=$(CACHE:.pdat=_fallos.pdf) $(CACHE:.pdat=_accesos.pdf) $(CACHE:.pdat=_accesosfallos.pdf)
PRIMOS_PDF=$(PRIMOS:.pdat=_fps.pdf) $(PRIMOS:.pdat=_area.pdf)
DATOS_PDF=$(DATOS:.dat=_fps.pdf) $(DATOS:.dat=_turnArround.pdf) $(DATOS:.dat=_bestfps.pdf)
FIGURAS_PDF=$(FIGURAS:.svg=.pdf)
PDF=$(FIGURAS_PDF) $(DATOS_PDF) $(PRIMOS_PDF) $(CACHE_PDF)
GARBAGE=*.aux *.bbl *.blg *.log *.pdf *.toc

all: $(NAME).pdf

$(NAME).pdf: $(PDF) $(TEX) $(BIB) $(INCTEX)
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

$(DATOS_PDF): $(DATOS)
	cd img && ../scripts/plot.sh
	cd img && ../scripts/plotbest.sh

$(DATOS): $(RES) $(BRES)
	cd img && ../scripts/mdat.sh

$(PRIMOS_PDF): $(PRIMOS) $(AREAS)
	gnuplot ./scripts/primos.gnuplot

$(CACHE_PDF): $(CACHE)
	gnuplot ./scripts/cache.gnuplot

clean:
	rm -f $(GARBAGE)
	rm -f $(PDF) $(DATOS)
