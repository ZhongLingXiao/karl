#include <iostream>

extern "C" {
    int yyparse();
    int yylex();
    int yyerror(const char* s);
}


int main() {
    int result = yyparse();

    if (result != 0)
        std::cout << "invaild input" << std::endl;

    return 0;
}