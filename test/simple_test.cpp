// Copyright Contributors to the Kazen Rigging Language project.
// SPDX-License-Identifier: BSD-3-Clause
// https://github.com/ZhongLingXiao/karl

#include <gtest/gtest.h>

struct yy_buffer_state;
typedef yy_buffer_state* YY_BUFFER_STATE;

extern "C" {
int yyparse();
void yyerror(const char* p);
int yylex();
YY_BUFFER_STATE yy_scan_string(const char* base);
}

void compile(const char* source_code) {
    yy_scan_string(source_code);
    EXPECT_EQ(yyparse(), 0);
}

TEST(simple, empty_func) {
    const char* source_code = R"(
            def func() { }
        )";

    compile(source_code);
}

TEST(simple, basic_func_def) {
    const char* source_code = R"(
            // TODO here.
            def func() {
                int a = 10;
            }
        )";

    compile(source_code);
}
