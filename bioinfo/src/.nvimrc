
nnoremap <buffer> gs :10 split term://pandoc -s --pdf-engine=lualatex --to=beamer --include-in-header=$HOME/.local/share/pandoc/beamer.tex % -o %:r.pdf<cr>:startinsert<cr>
