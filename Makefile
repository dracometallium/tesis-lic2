NAME=tesis
TEX=$(NAME).tex
PROPUESTA=propuesta.tex
BIB=biblio.bib
AUX=$(TEX:.tex=.aux)
INCTEX:=$(wildcard tex/*.tex)
FIGURAS:=$(wildcard img/*.svg)
RES:=$(wildcard img/*.res)
BRES=$(RES:.res=.bres)
DATOS=$(RES:.res=.dat)
PRIMOS=img/primos.pdat
AREAS=img/areas.pdat
CACHE=img/cache.pdat
CODIGO=img/itemSwitch.cpp img/codigoDirectivasOMP.cpp
CACHE_PDF=$(CACHE:.pdat=_fallos.pdf)
PRIMOS_PDF=$(PRIMOS:.pdat=_fps.pdf) $(PRIMOS:.pdat=_area.pdf)
DATOS_PDF=$(DATOS:.dat=_fps.pdf)
turnArround_PDF=$(DATOS:.dat=_turnArround.pdf)
tFPS_PDF=$(DATOS:.dat=_tFPS.pdf)
DATOS_PDF_P2=$(turnArround_PDF) $(tFPS_PDF)
BEST_PDF=$(DATOS:.dat=_bestfps.pdf)
SPEEDUP_PDF=$(DATOS:.dat=_speedup.pdf)
FIGURAS_PDF=$(FIGURAS:.svg=.pdf)
CODIGO_PDF=$(CODIGO:.cpp=.pdf)
PDF=$(FIGURAS_PDF) $(DATOS_PDF) $(DATOS_PDF_P2) $(PRIMOS_PDF) $(CACHE_PDF)\
    $(CODIGO_PDF) $(BEST_PDF) $(SPEEDUP_PDF)
GARBAGE=*.aux *.bbl *.blg *.log *.pdf *.toc *.lof img/*.tdat

all: $(NAME).pdf

$(NAME).pdf: $(PDF) $(TEX) $(BIB) $(INCTEX)
	rm *.lof
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

$(turnArround_PDF): %_turnArround.pdf : %_fps.pdf

$(tFPS_PDF): %_tFPS.pdf : %_fps.pdf

$(DATOS_PDF): scripts/plot.sh scripts/plot.gnuplot

$(DATOS_PDF): %_fps.pdf : %.dat
	scripts/plot.sh $^

$(SPEEDUP_PDF): %_speedup.pdf : %_bestfps.pdf

$(BEST_PDF): scripts/plotbest.sh scripts/plotbest.gnuplot

$(BEST_PDF): %_bestfps.pdf : %.dat
	scripts/plotbest.sh $^

$(DATOS): scripts/mdat.sh

$(DATOS): %.dat : %.res %.bres
	scripts/mdat.sh $<

$(PRIMOS_PDF): $(PRIMOS) $(AREAS) scripts/primos.gnuplot
	gnuplot ./scripts/primos.gnuplot

$(CACHE_PDF): $(CACHE) ./scripts/cache.gnuplot
	gnuplot ./scripts/cache.gnuplot


$(CODIGO_PDF): %.pdf :%.cpp
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
