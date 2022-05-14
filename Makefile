.PHONY: test check

build:
	dune build


play:
	OCAMLRUNPARAM=b dune exec bin/main.exe
	
utop:
	OCAMLRUNPARAM=b dune utop data

test:
	OCAMLRUNPARAM=b dune exec test/main.exe

doc:
	dune build @doc
