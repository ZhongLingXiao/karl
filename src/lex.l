/* Copyright Contributors to the Kazen Rigging Language project.
 * SPDX-License-Identifier: BSD-3-Clause
 * https://github.com/ZhongLingXiao/karl
 */

/* 
 * Lexical scanner for Kazen Rigging Language
 */

/* Section 1 : c stuff (headers files, declarations, variables, etc.) */

%{
    #include "grammar.h"
%}

%option noyywrap
%option yylineno

/* Section 2 : regular expressions */

/* white space */
whitespace              [ \t\v\f\r]+
/* alpha character */
alpha                   [A-Za-z]
/* numerals */
digit                   [0-9]
/* integer literal */
integer                 {digit}+
/* floating point literal.*/
float                   [+-]?({digit}+\.{digit}*|{digit}*\.{digit}+)
/* Identifier: alphanumeric, may contain digits after the first character */
identifier              ({alpha}|[_])({alpha}|{digit}|[_])*
/* comment */
comment                 (\/\/)(.*\n)


/* Section 3 : token specification */
%%
"int"           { printf("[flex] type int           | \t%s\n", yytext);     return TYPE_INT; }
"float"         { printf("[flex] type float         | \t%s\n", yytext);     return TYPE_FLOAT; }
"kernel"        { printf("[flex] kernel keyword     | \t%s\n", yytext);     return KERNEL; }
"+"             { printf("[flex] +                  | \t%s\n", yytext);     return OP_ADD; }
"-"             { printf("[flex] -                  | \t%s\n", yytext);     return OP_MINUS; }
"*"             { printf("[flex] *                  | \t%s\n", yytext);     return OP_MULT; }
"/"             { printf("[flex] /                  | \t%s\n", yytext);     return OP_DIV; }
"="             { printf("[flex] =                  | \t%s\n", yytext);     return EQUAL; }
":"             { printf("[flex] :                  | \t%s\n", yytext);     return COLON; }
","             { printf("[flex] ,                  | \t%s\n", yytext);     return COMMA; }
";"             { printf("[flex] ;                  | \t%s\n", yytext);     return SEMICOLON; }
"("             { printf("[flex] (                  | \t%s\n", yytext);     return L_PAREN; }
")"             { printf("[flex] )                  | \t%s\n", yytext);     return R_PAREN; }
"{"             { printf("[flex] {                  | \t%s\n", yytext);     return L_BRACE; }
"}"             { printf("[flex] }                  | \t%s\n", yytext);     return R_BRACE; }
"[["            { printf("[flex] [[                 | \t%s\n", yytext);     return META_BEGIN; }
"]]"            { printf("[flex] ]]                 | \t%s\n", yytext);     return META_END; }
{identifier}    { printf("[flex] identifier         | \t%s\n", yytext);     return IDENTIFIER; }
{integer}       { printf("[flex] integer            | \t%s\n", yytext);     return VALUE_INT; }
{float}         { printf("[flex] float              | \t%s\n", yytext);     return VALUE_FLOAT; }
{comment}       { printf("[flex] comment            | \t%s\n", yytext); }
{whitespace}    { }
.               { }
[\n]+           { }
%%
