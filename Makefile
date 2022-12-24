MAKEFLAGS += --silent

all:
	$(MAKE) grammer
	$(MAKE) lex
	
	# echo    "Compiling generated c code : lex.yy.c | grammer.tab.c"
	gcc -c lex.yy.c grammer.tab.c
	ar rvs grammer.tab.a grammer.tab.o
	ar rvs lex.yy.a lex.yy.o
	g++ -std=c++17 main.cpp grammer.tab.a lex.yy.a -ll

	rm -rf generated
	mkdir generated
	mv lex.yy.* ./generated/
	mv grammer.tab.* ./generated/
	
	# echo    "Executing binary"
	rm -rf bin
	mkdir bin
	mv a.out ./bin
	./bin/a.out < code.karl

grammer:
	# echo        "bison begin"	
	bison       -d grammer.y

lex:
	# echo        "flex begin"
	flex        lex.l

clean:
	rm -rf bin generated
