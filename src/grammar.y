/* Copyright Contributors to the Kazen Rigging Language project.
 * SPDX-License-Identifier: BSD-3-Clause
 * https://github.com/ZhongLingXiao/karl
 */

/* 
 * Parser for Kazen Rigging Language
 */

%{
#include <stdio.h>

int yylex();
int yyerror(const char* s);
%}


%token IDENTIFIER
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

// TEMP: This syntax grammar is based on crafting interpreters
// https://zihengcat.github.io/crafting-interpreters-zh-cn/appendix-i.html
%%
program 
    : declarations

// Declarations
declarations
    : declaration
    | declarations declaration

declaration
    : varDecl
    | funDecl
    | statement

varDecl
    : type IDENTIFIER ";" { printf("[bison] variable declaration.\n"); }
    | type IDENTIFIER "=" assignment ";" { printf("[bison] variable declaration with init value.\n"); }

funDecl
    : FUNC_ID function { printf("[bison] function declaration.\n"); }

// Statements
statement
    : exprStmt
    | block

exprStmt
    : expression ";"

block
    : "{" "}"
    | "{" declarations "}"

// Expressions
expression
    : assignment

assignment
    : IDENTIFIER "=" primary { printf("[bison] value assignment.\n"); }
    | call

call
    : primary
    | primary "(" ")"

primary
    : "true" | "false" | "null" | "this"
    | VALUE_INT | VALUE_FLOAT
    | "(" expression ")" 
    | IDENTIFIER

// Utility rules
type
    : TYPE_INT
    | TYPE_FLOAT

function
    : IDENTIFIER "(" ")" block

%%

int yyerror(const char* s) {
    printf("Syntax Error : %s\n", s);
    return 0;
}

