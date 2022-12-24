/* 
 * Lexical scanner for Kazen Rigging Language
 */


/* Section 1 : c stuff (headers files, declarations, variables, etc.) */

%{
    /* TODO */
%}


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
{comment}               printf("comment     | \t%s\n", yytext);
{identifier}            printf("identifier  | \t%s\n", yytext);
{integer}               printf("integer     | \t%s\n", yytext);
{float}                 printf("float       | \t%s\n", yytext);
{whitespace}            ;
"+"                     printf("%s\n", yytext);
"-"                     printf("%s\n", yytext);
"*"                     printf("%s\n", yytext);
"/"                     printf("%s\n", yytext);
"="                     printf("%s\n", yytext);
","                     printf("%s\n", yytext);
";"                     printf("%s\n", yytext);
"("                     printf("%s\n", yytext);
")"                     printf("%s\n", yytext);
"{"                     printf("%s\n", yytext);
"}"                     printf("%s\n", yytext);
"[["                    printf("%s\n", yytext);
"]]"                    printf("%s\n", yytext);
%%

/* Section 4 : Add c functions here. */
int main() {
    yylex();
}