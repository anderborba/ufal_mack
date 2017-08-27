echo "Inicio da compilacao"
pdflatex estudo.tex
bibtex estudo
pdflatex estudo.tex
pdflatex estudo.tex
echo "Fim da compilacao"

