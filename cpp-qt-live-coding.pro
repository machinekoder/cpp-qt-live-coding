TEMPLATE = lib
TARGET = com_machinekoder_live_plugin
QT += qml quick
CONFIG += plugin c++11

TARGET = $$qtLibraryTarget($$TARGET)
uri = com.machinekoder.live

# Input
SOURCES += \
        filewatcher.cpp \
    applicationhelpers.cpp \
    projectbrowser.cpp \
    cpp_qt_live_coding_plugin.cpp \
    livewindow.cpp

HEADERS += \
        filewatcher.h \
    applicationhelpers.h \
    projectbrowser.h \
    cpp_qt_live_coding_plugin.h \
    livewindow.h

DISTFILES = qmldir

!equals(_PRO_FILE_PWD_, $$OUT_PWD) {
    copy_qmldir.target = $$OUT_PWD/qmldir
    copy_qmldir.depends = $$_PRO_FILE_PWD_/qmldir
    copy_qmldir.commands = $(COPY_FILE) \"$$replace(copy_qmldir.depends, /, $$QMAKE_DIR_SEP)\" \"$$replace(copy_qmldir.target, /, $$QMAKE_DIR_SEP)\"
    QMAKE_EXTRA_TARGETS += copy_qmldir
    PRE_TARGETDEPS += $$copy_qmldir.target
}

qmldir.files = qmldir
unix {
    installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)
    qmldir.path = $$installPath
    target.path = $$installPath
    INSTALLS += target qmldir
}

RESOURCES += \
    qml.qrc
