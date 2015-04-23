LATEX = uplatex
TEXPDF = ptex2pdf -u -l
DVIPDFM = dvipdfmx
PANDOC = pandoc

#source
TEM = template
TEM_TEX = $(TEM).tex

#files made by make
TEM_PDF = $(TEM).pdf
TEM_OUT = $(TEM).out
TEM_LOG = $(TEM).log
TEM_AUX = $(TEM).aux

# REP = report
REP_ROOT = ./md/
# REP_MD = $(REP_ROOT)$(REP).md
REP_MD = $(wildcard $(REP_ROOT)*.md)

#files made by make
REP_TEX = $(REP_MD:.md=.tex)

#other
GRAPH = $(wildcard ./graph/*.tex)
FIG = $(wildcard ./figure/*.tex)
IMG = $(wildcard ./image/*)

.DEFAULT_GOAL = pdf

pdf:$(TEM_PDF)
$(TEM_PDF):$(REP_TEX) $(GRAPH) $(FIG) $(IMG)
	$(TEXPDF) $(TEM_TEX)


pandoc:$(REP_TEX)
$(REP_TEX):$(REP_MD)
	for md in $(REP_MD);do\
		tex=`echo $$md | sed -e "s/\.md/.tex/"`;\
		$(PANDOC) $$md -o $$tex;\
	done

clean:
	rm -rf $(TEM_PDF) $(TEM_AUX) $(TEM_LOG) $(TEM_OUT) $(REP_TEX)

test:

