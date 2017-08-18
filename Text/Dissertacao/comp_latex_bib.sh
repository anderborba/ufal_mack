echo "Inicio da compilacao"
latex estudo.tex
bibtex estudo
latex estudo.tex
latex estudo.tex
dvips estudo.dvi
ps2pdf estudo.ps
echo "Fim da compilacao"

