echo "1. Begin Lexing"
flex lex.l
echo "2. Compiling lex.yy.c"
gcc lex.yy.c -ll
echo "3. Tokenize rig code"
echo "--------------------"
./a.out < code.karl