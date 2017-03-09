This is the source code for the programming part of CS 6110's Assignment 3.


The Files
---------

This archive contains these source files:

- `ast.ml`:
  Defines the datatypes for the abstract syntax trees (ASTs) for FL
  as well as a pretty printer and some useful utilities. For example, to get a
  variable that does not appear anywhere in an expression `e`, you can use
  `Fresh.make (Ast.allv e)`.

- `eval.ml`:
  The interpreter for the AST.

- `state.ml`:
  A representation for environments and functions on environments.

- `lifting.ml`:
  The functions that translate from source to target language. **This is the
  only file you need to modify.**

- `lexer.mll` and `parser.mly`:
  A lexer and parser specification for FL programs.

- `repl.ml`:
  The top-level code that reads in an FL program, translates it, and evaluates
  it.

- `util.ml`:
  Some data structures used in the implementation.

There are also some example FL programs in the `examples` directory.


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
line. Compilation will produce an executable called `fl`.

If you ever get a message like "(some file).cmo and (some other file).cmo make inconsistent assumptions over interface (something)", you probably changed the top-level declarations in some file. Just type `make clean` and then `make` again to rebuild from scratch.

[install OCaml]: https://ocaml.org/docs/install.html
[ocaml-win]: http://protz.github.io/ocaml-installer/


Using the REPL
--------------

Run `./fl` to get the main prompt. You can type:

* `load <filename>` to load in some source code from a file.
* `list` to print out the current program.
* `convert` to run your `convert` function on the empty state and execute the result.
* `lift` to run your `lift` function and set the result as the current program.
* `run` to execute the current program.
* `help` to see a reminder of these options.
* `quit` to exit.
