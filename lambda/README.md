This is the source code for the programming part of CS 6110's Assignment 1.


The Files
---------

This archive contains these source files:

- `ast.ml`:
  The datatypes for the abstract syntax trees (ASTs) for both the "source
  language" (i.e., the λ-calculus with syntactic sugar for `let` and curried
  functions) and the "target language" (i.e., the plain λ-calculus). This file
  also contains pretty-printing routines for the languages.

- `lambda.ml`:
  The interpreter for the ASTs. **This is the file you need to modify.**

- `lexer.mll` and `parser.mly`:
  A lexer and parser specification for the source and target languages.

- `repl.ml`:
  The top-level code that reads in a λ-term and evaluates it.

- `util.ml`:
  Some utility functions.


Compiling
---------

You'll need to [install OCaml][] if you don't have it already. For example, use
`brew install ocaml` on macOS, the [official OCaml installer][ocaml-win] on
Windows, and your package manager on most Linuxes.

If you have Make (i.e., on any Unix), you can simply type `make` at the command
line. Compilation will produce an executable called `lambda`. Run this program
to get a REPL to try out your code.

[install OCaml]: https://ocaml.org/docs/install.html
[ocaml-win]: http://protz.github.io/ocaml-installer/


Examples
--------

Here are some example terms:

- id: `fun x -> x`
- tt: `fun x y -> x`
- ff: `fun x y -> y`
- cond: `fun x y z -> x y z`
- zero: `ff`
- succ: `fun n f x -> f (n f x)`
- one: `succ zero`
- two: `succ one`
- plus: `fun n1 n2 -> n1 succ n2`
- four: `(plus two) two`

You can use the let-bindings in the source language to assign
convenient names for these terms. For example, to evaluate one, you
could type the following lines at the top-level prompt:

    let ff = fun x y -> y in
    let zero = ff in
    let succ = fun n f x -> f (n f x) in
    succ zero
