# Copyright Contributors to the Kazen Rigging Language project.
# SPDX-License-Identifier: BSD-3-Clause
# https://github.com/ZhongLingXiao/karl

file(GLOB KARL_TEST_SOURCE ${CMAKE_CURRENT_SOURCE_DIR}/*.cpp)
add_executable(karl_test ${KARL_TEST_SOURCE})

target_link_libraries(karl_test PRIVATE
    karl
    GTest::gtest
    GTest::gtest_main
)

target_include_directories(karl_test PRIVATE ${gtest_SOURCE_DIR}/include)

include(GoogleTest)
gtest_discover_tests( karl_test
    PROPERTIES
    LABELS "unit"
    DISCOVERY_TIMEOUT  # how long to wait (in seconds) before crashing
    240
)