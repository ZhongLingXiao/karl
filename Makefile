MAKEFLAGS += --silent

all:
	$(MAKE) grammer
	$(MAKE) lex
	
	echo    "Compiling generated c code : lex.yy.c | grammer.tab.c"
	gcc -c lex.yy.c grammer.tab.c
	g++ -std=c++17 src/main.cpp grammer.tab.o lex.yy.o

	rm -rf generated
	mkdir generated
	mv lex.yy.* ./generated/
	mv grammer.tab.* ./generated/
	
	echo    "Executing binary"
	rm -rf bin
	mkdir bin
	mv a.out ./bin
	./bin/a.out < testsuite/simple/code.karl

grammer:
	echo "bison begin"	
	bison -d src/grammer.y

lex:
	echo "flex begin"
	flex src/lex.l

clean:
	rm -rf bin generated
