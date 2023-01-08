# Copyright Contributors to the Kazen Rigging Language project.
# SPDX-License-Identifier: BSD-3-Clause
# https://github.com/ZhongLingXiao/karl

set(KARL_LEXER_FILE "${KARL_GENERATED_SOURCE}/lex.c")
set(KARL_PARSER_FILE "${KARL_GENERATED_SOURCE}/grammar.c")

flex_target(KARL_LEXER lex.l "${KARL_LEXER_FILE}" DEFINES_FILE "${KARL_GENERATED_SOURCE}/lex.h")
bison_target(KARL_PARSER grammar.y "${KARL_PARSER_FILE}" DEFINES_FILE "${KARL_GENERATED_SOURCE}/grammar.h")
add_flex_bison_dependency(KARL_LEXER KARL_PARSER)

add_library(karl SHARED
    "${KARL_LEXER_FILE}" 
    "${KARL_PARSER_FILE}"
)

target_include_directories(karl PUBLIC "${KARL_GENERATED_SOURCE}")
target_compile_definitions(karl PUBLIC -DYYERROR_VERBOSE)