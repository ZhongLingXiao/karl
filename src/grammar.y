/* Copyright Contributors to the Kazen Rigging Language project.
 * SPDX-License-Identifier: BSD-3-Clause
 * https://github.com/ZhongLingXiao/karl
 */

/* 
 * Parser for Kazen Rigging Language
 */

%{
    #include <ctype.h>      // isdigit
    #include <stdio.h>      // printf
    #include <libintl.h>    // gettext
%}

%code provides {
    // extern int yylineno;
    int yylex();
    void yyerror(const YYLTYPE *loc, const char* s);    
}

// Emitted in the implementation file.
%code {
    static void location_print (FILE* file, YYLTYPE const* loc);
    #define YYLOCATION_PRINT location_print
}

// Customized syntax error messages (see yyreport_syntax_error)...
%define parse.error custom

// Don't share global variables between the scanner and the parser.
%define api.pure full

%locations

%token IDENTIFIER
%token KERNEL
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
    : KERNEL function { printf("[bison] kernel function declaration.\n"); }

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

#define NONE "\033[m"
#define RED "\033[1;32;31m"
#define GREEN "\033[1;32;32m"
#define YELLOW "\033[1;33m"

// You still must provide a yyerror function, used for instance to report memory exhaustion.
void yyerror(const YYLTYPE *loc, const char* s) {
    // printf(RED"[Error] %s at line (%d) \n"NONE, s, yylineno);
    // TODO.
}

static void location_print(FILE *file, YYLTYPE const * const loc) {
    // init error position : line.column
    fprintf (file, "%d.%d", loc->first_line, loc->first_column);

    // error: 1.5-10: syntax error: expected end of file or + or - or * or / or ^ before number
    // error:     1 | 123 123456
    // error:       |     ^~~~~~
    // 
    // this will create error range in lines or columns.
    int end_col = 0 != loc->last_column ? loc->last_column - 1 : 0;
    if (loc->first_line < loc->last_line)
        fprintf (file, "-%d.%d", loc->last_line, end_col);
    else if (loc->first_column < end_col)
        fprintf (file, "-%d", end_col);
}

static const char* error_format_string (int argc) {
    switch (argc) {
        default: // Avoid compiler warnings.
        case 0: return gettext("%@ => syntax error");
        case 1: return gettext("%@ => syntax error: unexpected %u");
        // TRANSLATORS: '%@' is a location in a file, '%u' is an
        // "unexpected token", and '%0e', '%1e'... are expected tokens
        // at this point.
        //
        // For instance on the expression "1 + * 2", you'd get
        //
        // 1.5: syntax error: expected - or ( or number or function or variable before *
        case 2: return gettext("%@ => syntax error: expected %0e before %u");
        case 3: return gettext("%@ => syntax error: expected %0e or %1e before %u");
        case 4: return gettext("%@ => syntax error: expected %0e or %1e or %2e before %u");
        case 5: return gettext("%@ => syntax error: expected %0e or %1e or %2e or %3e before %u");
        case 6: return gettext("%@ => syntax error: expected %0e or %1e or %2e or %3e or %4e before %u");
        case 7: return gettext("%@ => syntax error: expected %0e or %1e or %2e or %3e or %4e or %5e before %u");
        case 8: return gettext("%@ => syntax error: expected %0e or %1e or %2e or %3e or %4e or %5e etc., before %u");
    }
}

static int yyreport_syntax_error(const yypcontext_t *ctx) {
    enum { ARGS_MAX = 6 };
    yysymbol_kind_t arg[ARGS_MAX];
    int argsize = yypcontext_expected_tokens(ctx, arg, ARGS_MAX);
    if (argsize < 0)
        return argsize;
  
    const int too_many_expected_tokens = argsize == 0 && arg[0] != YYSYMBOL_YYEMPTY;
    if (too_many_expected_tokens)
        argsize = ARGS_MAX;
    const char *format = error_format_string(1 + argsize + too_many_expected_tokens);
    const YYLTYPE *loc = yypcontext_location (ctx);

    // [error]
    fprintf(stderr, RED"[error] "NONE);
    while (*format) {
        // %@: location.
        if (format[0] == '%' && format[1] == '@') {
            YYLOCATION_PRINT (stderr, loc);
            format += 2;
        }
        // %u: unexpected token.
        else if (format[0] == '%' && format[1] == 'u') {
            fputs (yysymbol_name (yypcontext_token (ctx)), stderr);
            format += 2;
        }
        // %0e, %1e...: expected token.
        else if (format[0] == '%'
                && isdigit ((unsigned char) format[1])
                && format[2] == 'e'
                && (format[1] - '0') < argsize) {
            int i = format[1] - '0';
            fputs (yysymbol_name (arg[i]), stderr);
            format += 3;
        }
        else {
            fputc (*format, stderr);
            ++format;
        }
    }
    fputc ('\n', stderr);

    // Quote the source line.
    {
        fprintf(stderr, "%5d | %s\n", loc->first_line, "this will be source code.");
        fprintf(stderr, "%5s | ", "");
        fprintf(stderr, RED"%*s", loc->first_column, "^");
        for (int i = loc->last_column - loc->first_column - 1; 0 < i; --i)
            putc('~', stderr);
        fprintf(stderr, "\n"NONE);
        fprintf(stderr, "%5s | %*s", "", loc->first_column-1, "");
        fprintf(stderr, GREEN"%s\n"NONE, "add expected fix here.");
    }

    return 0;
}
