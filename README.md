``` 
 __  ___      ___      .______       __      
|  |/  /     /   \     |   _  \     |  |     
|  '  /     /  ^  \    |  |_)  |    |  |     
|    <     /  /_\  \   |      /     |  |     
|  .  \   /  _____  \  |  |\  \----.|  `----.
|__|\__\ /__/     \__\ | _| `._____||_______|
                                             
====================================================================
 karl: kazen rigging language                              
 Version Alpha 0.0.1a                                            
 Copyright (C) 2022 ZhongLingXiao && Joey Chen. All rights reserved.                          
====================================================================
```

<div align="center">

# Karl

**Experimental domain specific language for rigging**
</div>

[![License](https://img.shields.io/badge/license-BSD%203--Clause-blue.svg?style=flat-square)](https://github.com/ZhongLingXiao/karl/blob/main/LICENSE)
[![ci](https://github.com/ZhongLingXiao/karl/actions/workflows/ci.yml/badge.svg)](https://github.com/ZhongLingXiao/karl/actions/workflows/ci.yml)

Introduction
------------

karl (kazen rigging language) is an experimental project for learning `flex & bison` and `llvm`.

Build
------------
Configure
```bash
cmake -B build
```

Build
```bash
cmake --build build --parallel --config Release
```

Test
------------
```bash
build/bin/karl_test
```
Current result looks like this :
```
Running main() from /home/kazenzhong/dev/karl/ext/googletest/googletest/src/gtest_main.cc
[==========] Running 2 tests from 1 test suite.
[----------] Global test environment set-up.
[----------] 2 tests from simple
[ RUN      ] simple.empty_func

[flex] func def keyword   |     def
[flex] identifier         |     func
[flex] (                  |     (
[flex] )                  |     )
[flex] {                  |     {
[flex] }                  |     }
[bison] function declaration.

[       OK ] simple.empty_func (0 ms)
[ RUN      ] simple.basic_func_def

[flex] comment            |     // TODO here.

[flex] func def keyword   |     def
[flex] identifier         |     func
[flex] (                  |     (
[flex] )                  |     )
[flex] {                  |     {

[flex] type int           |     int
[flex] identifier         |     a
[flex] =                  |     =
[flex] integer            |     10
[flex] ;                  |     ;
[bison] variable declaration with init value.

[flex] }                  |     }
[bison] function declaration.

[       OK ] simple.basic_func_def (0 ms)
[----------] 2 tests from simple (0 ms total)

[----------] Global test environment tear-down
[==========] 2 tests from 1 test suite ran. (0 ms total)
[  PASSED  ] 2 tests.
```