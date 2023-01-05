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
build/bin/karl < testsuite/simple/code.karl
```
Current result looks like this :
```
[flex] comment            |     // This is simple code for test.


[flex] func def keyword   |     def
[flex] identifier         |     function_name
[flex] (                  |     (
[flex] )                  |     )
[flex] {                  |     {

[flex] comment            |     // basic variable declarations

[flex] type int           |     int
[flex] identifier         |     intVal
[flex] =                  |     =
[flex] integer            |     10
[flex] ;                  |     ;
[bison] variable declaration with init value.

[flex] type float         |     float
[flex] identifier         |     floatVal
[flex] =                  |     =
[flex] float              |     10.0
[flex] ;                  |     ;
[bison] variable declaration with init value.


[flex] type float         |     float
[flex] identifier         |     funcVal
[flex] =                  |     =
[flex] identifier         |     func
[flex] (                  |     (
[flex] )                  |     )
[flex] ;                  |     ;
[bison] variable declaration with init value.


[flex] type int           |     int
[flex] identifier         |     uninitVal
[flex] ;                  |     ;
[bison] variable declaration.

[flex] identifier         |     uninitVal
[flex] =                  |     =
[flex] identifier         |     zhong
[bison] value assignment.
[flex] ;                  |     ;

[flex] }                  |     }
[bison] function declaration.
```