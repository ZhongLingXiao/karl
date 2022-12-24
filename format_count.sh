#!/bin/bash

# format
clang-format -i `find include/ -type f -name *.hpp`
clang-format -i `find src/ example/ test/ -type f -name *.cpp`

# count lines of codes
cloc --git `git branch --show-current`