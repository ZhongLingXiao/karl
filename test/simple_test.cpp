#include <gtest/gtest.h>

struct yy_buffer_state;
typedef yy_buffer_state *YY_BUFFER_STATE;

extern "C" {
int yyparse();
void yyerror(const char *p);
int yylex();
YY_BUFFER_STATE yy_scan_string(const char *base);
}

void validate_program(const char *shader_source) {
    yy_scan_string(shader_source);
    EXPECT_EQ(yyparse(), 0);
}

TEST(simple, empty_func) {
    const char *shader_source = R"(
            def func() { }
        )";

    validate_program(shader_source);
}

TEST(simple, basic_func_def) {
    const char *shader_source = R"(
            // TODO here.
            def func() {
                int a = 10;
            }
        )";

    validate_program(shader_source);
}
