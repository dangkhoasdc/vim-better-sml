" Vim filtype plugin
" Language: SML
" Maintainer: Jake Zimmerman <jake@zimmerman.io>
" Created: 08 Mar 2016
" License: MIT License

" Use apostrophes in variable names (useful for things like ^P (completion),
" ^W (back delete word), etc.)
setlocal iskeyword+='

" Set comment string so things like vim-commentary and foldmethod can use them
" appropriately.
setlocal commentstring=(*%s*)

" The default lprolog filetype plugin that ships with Vim interferes with SML.
" To fight back, we explicitly turn off the formatprg here.
setlocal formatprg=

" ----- Raimondi/delimitMate -----
" Single quotes are part of identifiers, and shouldn't always come in pairs.
let b:delimitMate_quotes = '"'

" ----- scrooloose/syntastic -----
" Attempt to detect CM files in SML/NJ checker
let s:cm = syntastic#util#findGlobInParent('*.cm', expand('%:p:h', 1))
if s:cm !=# ''
  let s:buf = bufnr('')
  call setbufvar(s:buf, 'syntastic_sml_smlnj_args', '-m ' . syntastic#util#shescape(s:cm))
  call setbufvar(s:buf, 'syntastic_sml_smlnj_fname', '')
endif

" ----- a.vim -----
" Sets up *.sig and *.sml files as "alternates", similar to how *.h and *.c
" files are alternates
let g:alternateExtensions_sml = 'sig'
let g:alternateExtensions_sig = 'sml'

