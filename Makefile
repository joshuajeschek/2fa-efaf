TMPFILES	= *.{log,aux,toc,out,lof,lot,snm,nav,vrb,pdf,bak,bbl,blg}
LATEX		= pdflatex -interaction=nonstopmode
BIB			= bibtex
SHELL		= /bin/bash # fix for not running clean

default:	beamer

all:		beamer handout notes dualmon

beamer:		beamer.pdf
handout:	handout.pdf
notes:		notes.pdf
dualmon:	dualmon.pdf
article:	article.pdf

%-watch:
	make $*
	while inotifywait -e close_write *.tex content/* images/* *.bib; do make $*; done

%.pdf: %.tex main.tex $(wildcard content/*) $(wildcard images/*) $(wildcard *.bib)
	$(LATEX) $<
	$(BIB)   $*
	$(LATEX) $<
	$(LATEX) $<

clean:
	rm -f $(TMPFILES)

open:
	open beamer.pdf
