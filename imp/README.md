This is the source code for the programming part of CS 6110's Assignment 2.


The Files
---------

This archive contains these source files:

- `ast.ml`:
  The datatypes for the abstract syntax trees (ASTs) for IMP.

- `state.ml`:
  A representation for stores (a.k.a. environments, heaps, valuations).

- `eval.ml`:
  The interpreter for the ASTs. **This is the file you need to modify.**

- `lexer.mll` and `parser.mly`:
  A lexer and parser specification for IMP programs.

- `main.ml`:
  A top-level read-evaluate-print loop.

There are also some example IMP programs in the `examples` directory.


Working with OCaml
------------------

OCaml modes exist for most editors:

* Vim: comes built in with recent versions, or
  <http://www.ocaml.info/vim/ftplugin/ocaml.vim>
* Emacs: <http://caml.inria.fr/pub/docs/u3-ocaml/emacs/index.html>
* Atom: <https://atom.io/packages/language-ocaml>
* VSCode: <https://marketplace.visualstudio.com/items?itemName=hackwaly.ocaml>
* Sublime Text: has a built in mode, or a better one at
  <https://github.com/whitequark/sublime-better-ocaml>


Compiling
---------

You'll need to [install OCaml][] if you don't have it already. For example, use
`brew install ocaml` on macOS, the [official OCaml installer][ocaml-win] on
Windows, and your package manager on most Linuxes.

If you have Make (i.e., on any Unix), you can simply type `make` at the command
line. Compilation will produce an executable called `imp`.

If you ever get a message like "(some file).cmo and (some other file).cmo make inconsistent assumptions over interface (something)", you probably changed the top-level declarations in some file. Just type `make clean` and then `make` again to rebuild from scratch.

[install OCaml]: https://ocaml.org/docs/install.html
[ocaml-win]: http://protz.github.io/ocaml-installer/


Using the REPL
--------------

Run `./imp` to get the main prompt. You can type:

* `load <filename>` to load in some source code from a file.
* `list` to print out the current program.
* `run` to execute the current program.
* `help` to see a reminder of these options.
* `quit` to exit.
