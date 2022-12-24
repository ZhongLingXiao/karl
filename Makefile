all:
	$(MAKE) lex
    
	# echo    "2. Compiling generated c code : lex.yy.c"
	gcc lex.yy.c -ll

	# echo    "3. Tokenize rig code"
	./a.out < code.karl

	$(MAKE) clean

lex:
	# echo    "1. Begin Lexing"
	flex    lex.l

clean:
	rm a.out lex.yy.c