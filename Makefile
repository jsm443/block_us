.PHONY: test check

build:
	dune build


play:
	OCAMLRUNPARAM=b dune exec bin/main.exe
	
utop:
	OCAMLRUNPARAM=b dune utop data

test:
	OCAMLRUNPARAM=b dune exec test/main.exe

docs:
	dune build @doc

doc:
	dune build @doc

clean:
	dune clean

zip:
	rm -f block_us.zip
	zip -r block_us.zip . -x@exclude.lst