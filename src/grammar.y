/* 
 * Parser for Kazen Rigging Language
 */

%{
#include <stdio.h>

int yylex();
int yyerror(const char* s);
%}


%token INDENTIFIER
%token FUNC_ID
%token TYPE_INT
%token TYPE_FLOAT
%token VALUE_INT
%token VALUE_FLOAT
%token L_BRACE          "{"
%token R_BRACE          "}"
%token L_BRACKET        "["
%token R_BRACKET        "]"
%token L_PAREN          "("
%token R_PAREN          ")"
%token OP_ADD           "+"
%token OP_MINUS         "-"
%token OP_MULT          "*"
%token OP_DIV           "/"
%token EQUAL            "="
%token COLON            ":"
%token COMMA            ","
%token SEMICOLON        ";"
%token META_BEGIN       "[["
%token META_END         "]]"


// Define the starting nonterminal
%start program

%%
program:
    FUNC_ID function_definition {
        printf("[bison] program.\n");
    };

function_definition:
    INDENTIFIER "(" ")" function_body {
        printf("[bison] function definition.\n");
    };

function_body:
    "{" "}" {
        printf("[bison] empty function body.\n");
    }
    |
    "{" stmts "}" {
        printf("[bison] function body.\n");
    };

stmts:
    stmt {
        printf("[bison] single statement.\n");
    }
    |
    stmts stmt {
        printf("[bison] multi statements.\n");
    };

stmt:
    INDENTIFIER ";" {
        printf("[bison] TODO: statement.\n");
    }
    ;

%%

int yyerror(const char* s) {
    printf("Syntax Error : %s\n", s);
    return 0;
}

