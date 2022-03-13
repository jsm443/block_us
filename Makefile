.PHONY: test check

build:
	dune build

utop:
	OCAMLRUNPARAM=b dune utop data

test:
	OCAMLRUNPARAM=b dune exec test/main.exe

