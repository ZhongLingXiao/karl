// Copyright Contributors to the Kazen Rigging Language project.
// SPDX-License-Identifier: BSD-3-Clause
// https://github.com/ZhongLingXiao/karl
#pragma once

#include <gtest/gtest.h>

struct yy_buffer_state;
typedef yy_buffer_state* YY_BUFFER_STATE;

extern "C" {
int yyparse();
void yyerror(const char* p);
int yylex();
int yylex_destroy(void);
YY_BUFFER_STATE yy_scan_string(const char* base);
FILE *yyin;
}

void compile(const char* source_code) {
    yy_scan_string(source_code);
    EXPECT_EQ(yyparse(), 0);

    // Notice: this destory function will help get correct Error lineno.
    // otherwise, lineno will accumulate from last google test case.
    // 
    // For example :
    // test case 1 ==> has 1 line
    //      def func() { }
    //
    // test case 2 ==> has 3 line (error happens in 2rd line)
    //      def func1() { 
    //          1=10;
    //      }
    //
    // If without `yylex_destroy`, the error messgae will show error in line (3) which is (2+1).
    // The correct lineno should be 2.
    yylex_destroy();
}
