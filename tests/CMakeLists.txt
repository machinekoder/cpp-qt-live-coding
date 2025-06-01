# Generated from tests.pro.

cmake_minimum_required(VERSION 3.16)
project(tests VERSION 1.0 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}")

find_package(QT NAMES Qt5 Qt6 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Qml Test)

qt_add_executable(tests
    ../lib/filewatcher.cpp ../lib/filewatcher.h
    main.cpp
    test_filewatcher.cpp
)
qt_add_qml_module(tests
    URI tests
    VERSION ${PROJECT_VERSION}
)

target_include_directories(tests PUBLIC
    ../3rdparty/catch
    ../3rdparty/trompeloeil
    ../lib
)

target_compile_definitions(tests PUBLIC
    QT_DEPRECATED_WARNINGS
    SRCDIR=\\\"${CMAKE_CURRENT_SOURCE_DIR}/\\\"
)

target_link_libraries(tests PUBLIC
    Qt::Core
    Qt::Qml
    Qt::Test
)

install(TARGETS tests
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
