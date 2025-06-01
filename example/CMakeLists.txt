# Generated from example.pro.

cmake_minimum_required(VERSION 3.16)
project(example VERSION 1.0 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "${INSTALL_EXAMPLESDIR}")

find_package(QT NAMES Qt5 Qt6 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Gui Quick)

qt_add_executable(example WIN32 MACOSX_BUNDLE
    main.cpp
)
target_compile_definitions(example PUBLIC
    QT_DEPRECATED_WARNINGS
)

target_link_libraries(example PUBLIC
    Qt::Core
    Qt::Gui
    Qt::Quick
)


# Resources:
set(qml_resource_files
    "Page1Form.qml"
    "Page2Form.ui.qml"
    "live.qml"
    "main.qml"
    "qtquickcontrols2.conf"
)

qt6_add_resources(example "qml"
    PREFIX
        "/"
    FILES
        ${qml_resource_files}
)

install(TARGETS example
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
