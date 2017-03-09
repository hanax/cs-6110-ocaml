# Targets are:
#
# all -- rebuild the project (default)
# clean -- remove all objects and executables

SOURCES = util.ml ast.ml parser.mli parser.ml lexer.ml state.mli state.ml lifting.ml eval.ml repl.ml

GENERATED = parser.mli parser.ml parser.output lexer.ml

.PHONY: all

all: fl

clean:
	rm -f fl *.out *.cmo *.cmx *.cmi $(GENERATED)

fl: $(SOURCES)
	ocamlc -o fl -g str.cma $(SOURCES)

parser.mli parser.ml: parser.mly
	ocamlyacc -v parser.mly

lexer.ml: lexer.mll parser.ml
	ocamllex lexer.mll
