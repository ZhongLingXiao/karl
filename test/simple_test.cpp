// Copyright Contributors to the Kazen Rigging Language project.
// SPDX-License-Identifier: BSD-3-Clause
// https://github.com/ZhongLingXiao/karl
#include "util.h"

TEST(simple, empty_func) {
    const char* source_code = 
        R"(def func() {
            }
        )";

    compile(source_code);
}

TEST(simple, basic_func_def) {
    const char* source_code = 
    R"(def func() {
            int a = 10;
            // This will generate error and show message : 
            // `[Error] syntax error, unexpected =, expecting ; at line (5)`
            // 1=x;
        }
    )";

    compile(source_code);
}
