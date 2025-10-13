# -------- Config --------
MAIN      ?= main
PDF       := $(MAIN).pdf
LATEXMK   ?= latexmk
LMK_OPTS  ?= -pdf -interaction=nonstopmode -file-line-error

# Extra patterns latexmk -c might miss (add/remove as needed)
EXTRA_CLEAN = \
  *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.lof *.log *.lot *.nav \
  *.out *.run.xml *.synctex.gz *.toc *.snm *.vrb *.idx *.ilg *.ind *.xdv

# -------- Targets --------
.PHONY: all build pdf tidy clean distclean watch open

all: build

# One-shot: compile then remove intermediates
build: pdf tidy

# Compile to PDF (latexmk will resolve deps/bib automatically)
pdf:
	$(LATEXMK) $(LMK_OPTS) $(MAIN).tex

# Remove intermediates but keep the final PDF
tidy:
	-$(LATEXMK) -c
	-rm -f $(EXTRA_CLEAN)

# Like tidy, but a bit more aggressive (keeps PDF)
clean: tidy

# Nuke everything including the PDF
distclean: clean
	-rm -f $(PDF)

# Recompile on file changes (handy while editing)
watch:
	$(LATEXMK) -pvc $(LMK_OPTS) $(MAIN).tex

# Open the PDF (macOS). Comment this out on Linux/Windows or replace with xdg-open/start
open: $(PDF)
	open $(PDF)

