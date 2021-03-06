# vim-better-sml

> Some improvements to the default SML filetype plugins for Vim.

## Install

Install using your favorite plugin manager. For example, to install using
Vundle, add this line to your ~/.vimrc:

```
Plugin 'jez/vim-better-sml'
```

If you're unfamiliar using Vim plugins, check out [Vim as an IDE][vim-ide] which
will get you up to speed.

## Summary

### Syntax

- [x] Highlight `=>` correctly as a single operator
- [x] Highlight type variables
- [x] Set up conceal characters for common type variables (i.e., `'a -> α`, or
  `'a -> 'α` if you prefer; see "Configuration" below)
    - Note: concealing disabled by Vim by default. See "Configuration" below.
- [x] Highlight `fun` and `fn` with `Function` instead of `Keyword`
- [x] Set up conceal characters for `fn -> λ.`

![Syntax highlighting preview](https://cloud.githubusercontent.com/assets/5544532/16899173/b5e00668-4bae-11e6-9e56-2cf5befbec57.png)

### Indentation

- [x] `let` statements are indented under `fun` statements
- [x] Using handing `of` inside a parenthesized case statement is properly
  re-indented. For example, this:

      (case x
      of|)

  becomes

      (case x
         of|)

  This should already be handled when the expression is not parenthesized; we
  fix it when it is.
- [ ] Indent level is properly adjusted when using nested case statements.
  Consider the following snippet of SML:

      datatype ord = Z | S of ord | Sup of (int -> ord)

      fun toString n =
        case n
          of Z => "0"
           | S n' =>
               (case n'
                  of Z => "1"
                   | S _ => "1 < n < aleph"
                   | _ => "malformed")
           | Sup f => ">= aleph"

  Try transcribing this into Vim right now; the last line isn't indented
  properly. Right now, the indent file indents lines like the last line under
  the most recent `case` keyword, ignoring any nesting structure. See [this
  issue][issue-1] for some of my thoughts on the matter.

### Filetype

- [x] Detects signature files (`*.sig`) properly
- [x] Treats apostrophes (`'`) as keyword characters (i.e., we can use "primes"
  in variable names)
- [x] Sets up the comment string properly. This is useful...
  - in conjunction with [tpope/vim-commentary], a plugin that sets up bindings
    for commenting/uncommenting regions in a file
  - when using `foldmethod=marker`, which inserts fold markers into the text
    wrapped in comments

### External Plugins

- __delimitMate__
  - [x] Sets up the appropriate quote characters
- __Syntastic__
  - [x] For the SML/NJ syntax checker, tries to check if you're using a CM file
    to build the project, and loads it appropriately.
- __a.vim__:
  - [x] Set up `*.sig` and `*.sml` as alternate extensions (similar to `*.h` and
    `*.cpp`)

## Configuration

The behavior of `vim-better-sml` can be configured.

### `conceallevel`

By default, Vim conceal characters are turned off (except for some filetypes,
like Vim help files). To turn conceal characters on for `sml`, use:

```
au FileType sml setlocal conceallevel=2
```

See `:help conceallevel` for the full range of options you can set.

### `g:sml_greek_tyvar_show_tick`

By default, we conceal `'a` to `α`. You can instead make `'a` become `'α` using:

```
let g:sml_greek_tyvar_show_tick = 1
```

## License

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](https://jez.io/MIT-LICENSE.txt)


<!-- References -->

[vim-ide]: https://github.com/jez/vim-as-an-ide
[issue-1]: https://github.com/jez/vim-better-sml/issues/1
[tpope/vim-commentary]: https://github.com/tpope/vim-commentary
