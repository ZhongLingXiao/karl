/* 
 * Lexical scanner for Kazen Rigging Language
 */


/* Section 1 : c stuff (headers files, declarations, variables, etc.) */

%{
    #include "grammer.tab.h"
%}

%option noyywrap


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
"def"           { printf("[flex] function id    | \t%s\n", yytext);     return FUNC_ID; }
"+"             { printf("[flex] +              | \t%s\n", yytext);     return OP_ADD; }
"-"             { printf("[flex] -              | \t%s\n", yytext);     return OP_MINUS; }
"*"             { printf("[flex] *              | \t%s\n", yytext);     return OP_MULT; }
"/"             { printf("[flex] /              | \t%s\n", yytext);     return OP_DIV; }
"="             { printf("[flex] =              | \t%s\n", yytext);     return EQUAL; }
":"             { printf("[flex] :              | \t%s\n", yytext);     return COLON; }
","             { printf("[flex] ,              | \t%s\n", yytext);     return COMMA; }
";"             { printf("[flex] ;              | \t%s\n", yytext);     return EOL; }
"("             { printf("[flex] (              | \t%s\n", yytext);     return L_RBRACKET; }
")"             { printf("[flex] )              | \t%s\n", yytext);     return R_RBRACKET; }
"{"             { printf("[flex] {              | \t%s\n", yytext);     return L_CBRACKET; }
"}"             { printf("[flex] }              | \t%s\n", yytext);     return R_CBRACKET; }
"[["            { printf("[flex] [[             | \t%s\n", yytext);     return META_BEGIN; }
"]]"            { printf("[flex] ]]             | \t%s\n", yytext);     return META_END; }
{identifier}    { printf("[flex] identifier     | \t%s\n", yytext);     return INDENTIFIER; }
{integer}       { printf("[flex] integer        | \t%s\n", yytext);     return VALUE_INT; }
{float}         { printf("[flex] float          | \t%s\n", yytext);     return VALUE_FLOAT; }
{comment}       { printf("[flex] comment        | \t%s\n", yytext); }
{whitespace}    { }
.               { }  
%%
