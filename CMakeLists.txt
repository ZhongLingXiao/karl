# Copyright Contributors to the Kazen Rigging Language project.
# SPDX-License-Identifier: BSD-3-Clause
# https://github.com/ZhongLingXiao/karl

cmake_minimum_required(VERSION 3.20)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake;${CMAKE_MODULE_PATH}")
if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

set (KARL_VERSION "0.0.1")
project (karl VERSION ${KARL_VERSION}
         LANGUAGES C CXX
         HOMEPAGE_URL "https://github.com/ZhongLingXiao/karl")

message (STATUS "Configuring ${PROJECT_NAME} ${PROJECT_VERSION}")
message (STATUS "CMake ${CMAKE_VERSION}")
message (STATUS "CMake system           = ${CMAKE_SYSTEM}")
message (STATUS "CMake system name      = ${CMAKE_SYSTEM_NAME}")
message (STATUS "Project source dir     = ${PROJECT_SOURCE_DIR}")
message (STATUS "Project build dir      = ${CMAKE_BINARY_DIR}")
message (STATUS "Project install prefix = ${CMAKE_INSTALL_PREFIX}")
message (STATUS "Configuration types    = ${CMAKE_CONFIGURATION_TYPES}")
message (STATUS "Build type             = ${CMAKE_BUILD_TYPE}")

# Make the build area layout look a bit more like the final dist layout
set (CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set (CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set (CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

if ("${PROJECT_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
    message (FATAL_ERROR "Not allowed to run in-source build!")
endif ()

find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

file(MAKE_DIRECTORY "generated")
set(KARL_GENERATED_SOURCE "${CMAKE_CURRENT_SOURCE_DIR}/generated")

# Add external libraries
add_subdirectory(ext)

add_subdirectory(src)

add_subdirectory(test)
