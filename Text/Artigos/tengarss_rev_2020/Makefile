# 
# makefile para a compilação do documento
#
#

BASE_NAME = tengarss_rev_ander
#BASE_NAME = FusionEvidencesPolSAR-R1


LATEX     = latex
PDFLATEX  = pdflatex
BIBTEX    = bibtex

pdf: $(BASE_NAME).pdf
ps: $(BASE_NAME).ps

$(BASE_NAME).pdf: $(BASE_NAME).tex 


	$(PDFLATEX) $<
	$(BIBTEX) $(BASE_NAME) 
	$(PDFLATEX) $< 
	$(PDFLATEX) $<
	$(PDFLATEX) $<

$(BASE_NAME).ps: $(BASE_NAME).tex 
	$(LATEX) $<
	$(BIBTEX) $(BASE_NAME)  
	$(LATEX) $< 
	$(LATEX) $<
	$(LATEX) $<
	
clean:
	rm -f $(BASE_NAME)*.ps $(BASE_NAME)*.dvi *.log \
	      *.aux *.blg *.toc *.brf *.ilg *.ind *.idx \
	      missfont.log $(BASE_NAME)*.bbl $(BASE_NAME)*.pdf $(BASE_NAME)*.out \
		  $(BASE_NAME)*.lof $(BASE_NAME)*.lot $ $(BASE_NAME)*.synctex.gz
