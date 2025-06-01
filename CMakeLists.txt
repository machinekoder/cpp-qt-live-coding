# Generated from cpp-qt-live-coding.pro.
cmake_minimum_required(VERSION 3.21)
project(cpp-qt-live-coding LANGUAGES CXX)

add_subdirectory(lib)
add_subdirectory(example)
if(CMAKE_BUILD_TYPE STREQUAL Debug)
    add_subdirectory(tests)
endif()
