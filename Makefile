
build:
	@echo "\n==== COMPILING ====\n"
	ocamlbuild ftest.native

format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n==== EXECUTING ====\n"
	./ftest.native graphs/graph1 1 2 outfile
	@echo "\n==== RESULT ==== (content of outfile) \n"
	@dot -Tsvg outfilexport > some-output-file.svg
	@dot -Tsvg outfilexport2 > some2-output-file.svg
	@dot -Tsvg outfilexport3 > some3-output-file.svg
	@cat outfile

clean:
	-rm -rf _build/
	-rm ftest.native
