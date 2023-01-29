![](https://github.com/ZhongLingXiao/karl-wiki/blob/master/img/cover.jpeg)

<div align="center">

**Experimental domain specific language for rigging**
</div>

[![License](https://img.shields.io/badge/license-BSD%203--Clause-blue.svg?style=flat-square)](https://github.com/ZhongLingXiao/karl/blob/main/LICENSE)
<br/>

[![Linux (gcc)](https://github.com/ZhongLingXiao/karl/actions/workflows/build-linux-gcc.yml/badge.svg)](https://github.com/ZhongLingXiao/karl/actions/workflows/build-linux-gcc.yml)
[![MacOS](https://github.com/ZhongLingXiao/karl/actions/workflows/build-macos.yml/badge.svg)](https://github.com/ZhongLingXiao/karl/actions/workflows/build-macos.yml)

Introduction
------------

karl (kazen rigging language) is an experimental project for learning `flex & bison` and `llvm`.

Building
------------
**Required dependencies**
```
 - flex: 2.6.4
 - bison: 3.8.2
 - cmake: 3.20.0
```

**Configure & Build**
```bash
> chmod +x build.sh
> ./build.sh
```


Test
------------
```bash
> build/bin/karl_test
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

The error message looks like this:
```
[error] 5.5 => syntax error: expected ; before =
    5 | this will be source code.
      |     ^
      |     add expected fix here.
```
