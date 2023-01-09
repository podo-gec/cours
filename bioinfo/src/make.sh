#!/usr/bin/env bash

find . -name \*-s.org -print0 | xargs -0 org-beamer
find . -name \*-s.org | xargs -I '{}' latexmk -c '{}'

find . -type f -name \*-h.org | xargs -I '{}' org-babel -pdf '{}'
find . -type f -name \*-h.org | xargs -I '{}' latexmk -c '{}'

rm *.synctex.gz
rm *.tex
rm *.bib

mv *.pdf ../dist
