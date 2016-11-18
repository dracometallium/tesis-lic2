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
CODIGO=img/itemSwitch.cpp
CACHE_PDF=$(CACHE:.pdat=_fallos.pdf)
PRIMOS_PDF=$(PRIMOS:.pdat=_fps.pdf) $(PRIMOS:.pdat=_area.pdf)
DATOS_PDF=$(DATOS:.dat=_fps.pdf)
DATOS_PDF_P2=$(DATOS:.dat=_turnArround.pdf) $(DATOS:.dat=_tFPS.pdf)
BEST_PDF=$(DATOS:.dat=_bestfps.pdf)
FIGURAS_PDF=$(FIGURAS:.svg=.pdf)
CODIGO_PDF=$(CODIGO:.cpp=.pdf)
PDF=$(FIGURAS_PDF) $(DATOS_PDF) $(DATOS_PDF_P2) $(PRIMOS_PDF) $(CACHE_PDF)\
    $(CODIGO_PDF) $(BEST_PDF)
GARBAGE=*.aux *.bbl *.blg *.log *.pdf *.toc *.lof img/*.tdat

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

$(FIGURAS_PDF): %.pdf : %.svg
	inkscape $^ -z -A $@

$(DATOS_PDF_P2): $(DATOS_PDF)

$(DATOS_PDF): scripts/plot.sh scripts/plot.gnuplot

$(DATOS_PDF): %_fps.pdf : %.dat
	scripts/plot.sh $^

$(BEST_PDF): scripts/plotbest.sh scripts/plotbest.gnuplot

$(BEST_PDF): %_bestfps.pdf : %.dat
	scripts/plotbest.sh $^

$(DATOS): scripts/mdat.sh

$(DATOS): %.dat : %.res %.bres
	scripts/mdat.sh $<

$(PRIMOS_PDF): $(PRIMOS) $(AREAS)
	gnuplot ./scripts/primos.gnuplot

$(CACHE_PDF): $(CACHE)
	gnuplot ./scripts/cache.gnuplot


$(CODIGO_PDF): $(CODIGO)
	echo ":set syntax \n\
	:set number \n\
	:set printfont=currier:8 \n\
	:set printoptions=number:y,header:0 \n\
	:colorscheme default \n\
	:hardcopy > "$(<:.cpp=.ps) "\n:q\n" | vim $<
	inkscape $(<:.cpp=.ps) -z --export-area-drawing -A $@
	rm $(<:.cpp=.ps)

clean:
	rm -f $(GARBAGE)
	rm -f $(PDF) $(DATOS)
