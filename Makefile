GFX_OUT_DIR := gfx-out

THESIS_CHAPTERS := \
	01_introduction/introduction.tex \
	02_analysis/analysis.tex \
	03_design/design.tex \
	04_implementation/implementation.tex \
	05_testing/testing.tex \
	06_discussion/discussion.tex \
	07_conclusion/conclusion.tex
THESIS_META := meta/title.tex meta/committee.tex
THESIS_DEP := 00_front-matter/abstract.tex 00_front-matter/acknowledgements.tex 00_front-matter/notation.tex \
	helper.tex thesis.bib \
	$(THESIS_META) $(THESIS_CHAPTERS)

GFX_DEP := $(GFX_OUT_DIR)/matlab-call-graph/high-level.tex \
	$(GFX_OUT_DIR)/matlab-call-graph/segmentation.tex \
	$(GFX_OUT_DIR)/matlab-call-graph/registration.tex \
	$(GFX_OUT_DIR)/matlab-call-graph/tracing.tex

# notation.tex
#./thesis_template_01.tex
#analysis.tex
all: thesis.pdf

thesis.pdf: thesis.tex $(THESIS_DEP) $(GFX_DEP)

%.pdf: %.tex
	latexmk -f -pdf -silent -diagnostics $<

%.tex: %.md
	pandoc -t latex $< -o $@

$(GFX_OUT_DIR):
	mkdir -p $(GFX_OUT_DIR)

$(GFX_OUT_DIR)/%.tex : gfx/%.dot
	mkdir -p `dirname $@`
	dot2tex --figonly < $< > $@

include ~/sw_projects/zmughal/scraps/scraps/build/latex/clean.mk

clean::
	rm -Rf $(GFX_OUT_DIR)
