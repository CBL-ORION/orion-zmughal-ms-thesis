all: thesis.pdf

thesis.pdf: thesis.tex

%.pdf: %.tex
	latexmk -pdf -silent -diagnostics $<

%.tex: %.md
	pandoc -t latex $< -o $@

include ~/sw_projects/zmughal/scraps/scraps/build/latex/clean.mk
