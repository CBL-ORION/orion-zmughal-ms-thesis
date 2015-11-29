GFX_OUT_DIR := gfx-out
GFX_DIR := gfx

THESIS_CHAPTERS := \
	01_introduction/introduction.tex \
	02_analysis/analysis.tex \
	03_design/design.tex \
	04_implementation/implementation.tex \
	05_testing/testing.tex \
	06_discussion/discussion.tex \
	07_conclusion/conclusion.tex \
	appendix/appendix.tex
THESIS_META := meta/title.tex meta/committee.tex
THESIS_DEP := 00_front-matter/abstract.tex 00_front-matter/acknowledgements.tex 00_front-matter/notation.tex \
	preamble/helper.tex thesis.bib \
	$(THESIS_META) $(THESIS_CHAPTERS)
PRESENT_DEP := preamble/present-helper.tex meta/defense.tex

GFX_DEP := \
	$(GFX_OUT_DIR)/matlab-call-graph/segmentation.tex \
	$(GFX_OUT_DIR)/matlab-call-graph/registration.tex \
	$(GFX_OUT_DIR)/matlab-call-graph/tracing.tex \
	$(GFX_DIR)/sdlc.tex \
	$(GFX_DIR)/algorithm/*.tex

# notation.tex
#./thesis_template_01.tex
#analysis.tex
all: thesis.pdf present.pdf present-handout-2x3.pdf tags

thesis.pdf: thesis.tex $(THESIS_DEP) $(GFX_DEP)

XELATEX_OPT := -e '$$pdflatex=q/xelatex -synctex=1 %O %S/'
present.pdf: LATEXMKRC_FLAGS +=  $(XELATEX_OPT)
present.pdf: present.tex $(PRESENT_DEP)

present-handout-2x3.pdf: present.pdf
	pdfjam-slides6up --suffix 'handout-2x3' --batch $<

%.pdf: %.tex
	-latexmk $(LATEXMKRC_FLAGS) -f -pdf -silent -diagnostics $<

%.tex: %.md
	pandoc -t latex $< -o $@

$(GFX_OUT_DIR):
	mkdir -p $(GFX_OUT_DIR)

$(GFX_OUT_DIR)/%.tex : gfx/%.dot
	mkdir -p `dirname $@`
	dot2tex -ftikz --figonly < $< > $@

tags:
	ctags -R .

include ~/sw_projects/zmughal/scraps/scraps/build/latex/clean.mk

wc-pdf: thesis.pdf
	pdftotext thesis.pdf - | wc -w
wc-tex:
	find -name '*.tex' | xargs wc -w

cleanall::
	rm -Rf $(GFX_OUT_DIR)
	rm -Rf tags

check:
	@echo "Check for references that are not resolved"
	@echo "==="
	-@pdftotext thesis.pdf  - | grep --colour=auto -C1 '??'
	@echo "==="

latexdiff-thesis:
	if [ -z "$(LAST_VERSION)" ]; then \
		LTX_COMP=`git tag | tail -1`; \
		echo "Using last tag: $$LTX_COMP"; \
	else \
		LTX_COMP=$(LAST_VERSION); \
	fi; \
	git latexdiff -v --output diff.pdf --ignore-latex-errors --main thesis.tex $$LTX_COMP master
