# Copyright Contributors to the Kazen Rigging Language project.
# SPDX-License-Identifier: BSD-3-Clause
# https://github.com/ZhongLingXiao/karl

# Build googletest 
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
set(BUILD_GMOCK OFF CACHE BOOL "" FORCE)
add_subdirectory(googletest)

# TODO: Add submodules here.