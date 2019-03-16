TEMPLATE = subdirs

SUBDIRS += 3rdparty lib example

lib.depends = 3rdparty
example.depends = lib

CONFIG(debug, debug|release) {
    SUBDIRS += tests
    tests.depends = lib
}
