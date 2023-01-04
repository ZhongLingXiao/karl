set(KARL_LEXER_FILE "${KARL_GENERATED_SOURCE}/lex.c")
set(KARL_PARSER_FILE "${KARL_GENERATED_SOURCE}/grammar.c")

flex_target(KARL_LEXER lex.l "${KARL_LEXER_FILE}" DEFINES_FILE "${KARL_GENERATED_SOURCE}/lex.h")
bison_target(KARL_PARSER grammar.y "${KARL_PARSER_FILE}" DEFINES_FILE "${KARL_GENERATED_SOURCE}/grammar.h")
add_flex_bison_dependency(KARL_LEXER KARL_PARSER)

add_executable(karl 
    main.cpp
    "${KARL_LEXER_FILE}" 
    "${KARL_PARSER_FILE}")

target_include_directories(karl PRIVATE "${KARL_GENERATED_SOURCE}")