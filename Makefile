
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
	@dot -Tsvg outfilexport > graph_original.svg
	@dot -Tsvg outfilexport2 > graph_de_flot_final.svg
	@dot -Tsvg outfilexport3 > graph_residuel_final.svg
	@cat outfile

clean:
	-rm -rf _build/
	-rm ftest.native
