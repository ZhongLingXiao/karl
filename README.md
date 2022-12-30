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
[flex] comment        |         // comments here.


[flex] function id    |         def
[flex] identifier     |         function_name
[flex] (              |         (
[flex] )              |         )
[flex] {              |         {

[flex] comment        |         // TODO

[flex] identifier     |         kazen_codes_here
[flex] ;              |         ;
[bison] TODO: statement.
[bison] single statement.

[flex] }              |         }
[bison] function body.
[bison] function definition.
[bison] program.
```