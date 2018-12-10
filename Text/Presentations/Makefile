# 
# makefile para a compilação do documento
#

BASE_NAME = qualif

LATEX     = xelatex
BIBTEX    = bibtex

pdf: $(BASE_NAME).pdf

$(BASE_NAME).pdf: $(BASE_NAME).tex 
	$(LATEX) $<
	$(BIBTEX) $(BASE_NAME) 
	$(LATEX) $< 
	$(LATEX) $<

clean:
	rm -f $(BASE_NAME)*.ps $(BASE_NAME)*.dvi *.log \
	      *.aux *.blg *.toc *.brf *.ilg *.ind *.idx \
	      *.nav *.bbl *.vrb *.snm *.ilg *.ind *.idx \
	      missfont.log $(BASE_NAME)*.bbl $(BASE_NAME)*.pdf $(BASE_NAME)*.out \
		  $(BASE_NAME)*.lof $(BASE_NAME)*.lot 
