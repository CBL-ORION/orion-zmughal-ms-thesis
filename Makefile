THESIS_CHAPTERS := ch1_Introduction.tex ch2_Background.tex ch3_Methods.tex ch4_Algorithms.tex ch5_Results.tex ch6_Conclusion.tex
THESIS_META := meta/title.tex meta/committee.tex
THESIS_DEP := 00_front-matter/abstract.tex 00_front-matter/acknowledgements.tex 00_front-matter/notation.tex $(THESIS_META) $(THESIS_CHAPTERS)

# notation.tex
#./thesis_template_01.tex
#analysis.tex
all: thesis.pdf

thesis.pdf: thesis.tex $(THESIS_DEP)

%.pdf: %.tex
	latexmk -pdf -silent -diagnostics $<

%.tex: %.md
	pandoc -t latex $< -o $@

include ~/sw_projects/zmughal/scraps/scraps/build/latex/clean.mk
