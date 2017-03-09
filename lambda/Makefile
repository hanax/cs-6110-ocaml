# Targets are:
#
# all -- rebuild the project (default)
# clean -- remove all objects and executables

SOURCES = util.ml ast.ml parser.mli parser.ml lexer.ml lambda.ml repl.ml

GENERATED = parser.mli parser.ml parser.output lexer.ml

.PHONY: all

all: lambda

clean:
	rm -f lambda *.out *.cmo *.cmx *.cmi $(GENERATED)

lambda: $(SOURCES)
	ocamlc -o lambda -g str.cma $(SOURCES)

parser.mli parser.ml: parser.mly
	ocamlyacc -v parser.mly

lexer.ml: lexer.mll parser.ml
	ocamllex lexer.mll
