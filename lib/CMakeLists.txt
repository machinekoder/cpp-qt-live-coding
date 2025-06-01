# Generated from lib.pro.

cmake_minimum_required(VERSION 3.16)
project(com_machinekoder_live_plugin VERSION 1.0 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOMOC ON)

if(NOT DEFINED INSTALL_EXAMPLESDIR)
    set(INSTALL_EXAMPLESDIR "examples")
endif()

set(INSTALL_EXAMPLEDIR "$$[QT_INSTALL_QML]/,\\.,/")

find_package(QT NAMES Qt5 Qt6 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Gui Qml Quick)

qt_add_qml_module(com_machinekoder_live_plugin
    URI com_machinekoder_live_plugin
    VERSION ${PROJECT_VERSION}
    QML_FILES
        FileSelectionDialog.qml
        LiveCodingPanel.qml
    RESOURCE_PREFIX /com/machinekoder/live
    PLUGIN_TARGET com_machinekoder_live_plugin
)

target_sources(com_machinekoder_live_plugin PRIVATE
    filewatcher.cpp filewatcher.h
    livecoding.cpp livecoding.h
    projectbrowser.cpp projectbrowser.h
)
target_link_libraries(com_machinekoder_live_plugin PUBLIC
    Qt::Core
    Qt::Gui
    Qt::Qml
    Qt::Quick
)

install(TARGETS com_machinekoder_live_plugin
    RUNTIME DESTINATION "${INSTALL_EXAMPLEDIR}"
    BUNDLE DESTINATION "${INSTALL_EXAMPLEDIR}"
    LIBRARY DESTINATION "${INSTALL_EXAMPLEDIR}"
)
