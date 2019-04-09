# Live Coding Environment for C++, Qt and QML
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/machinekoder/cpp-qt-live-coding/blob/master/LICENSE)
[![Code style: WebKit](https://img.shields.io/badge/code%20style-WebKit-blue.svg)](https://webkit.org/code-style-guidelines/)

This project aims to be the C++ version for Qt/QML live coding.

In constrast to other live coding environments, this project is a live coding QML module meant to be integrated into your application.

Integrating QML live coding into your application significantly boosts your HMI developers productivity. Compared to stand-alone solutions, this approach enables integration of C++ QML components without deploying them first.

Additionally, it enables customization of the live coding environemnt, including pre-loading of resource intensive QML components.

**See also**
* [My blog post about Qt/QML live coding](http://machinekoder.com/qt-qml-live-coding-for-everyone/)
* [python-qt-live-coding](https://github.com/machinekoder/python-qt-live-coding): The Python version of this project.

**Qt/QML Live Coding with C++ Tutorial**

[![Qt/QML Live Coding with C++ Tutorial](http://img.youtube.com/vi/UABm__RZq8g/0.jpg)](http://www.youtube.com/watch?v=UABm__RZq8g)

## Install

### With Qt Creator

* git clone the project repository
* Open the projects `.pro` file in Qt Creator
* add a new make install step with Make argument `install`
* Build

### From the terminal

```bash
git clone https://github.com/machinekoder/cpp-qt-live-coding.git
cd cpp-qt-live-coding
mkdir build
cd build
qmake ..
make -j$(nproc)
make install
```

### Cookiecutter project template

The easiest way to create a new project with live-coding enable is to use the [Cookiecutter template](https://github.com/machinekoder/cookiecutter-qtquick-qmake-catch-trompeloeil-live).

```bash
pip install cookiecutter
cookiecutter gh:machinekoder/cookiecutter-qtquick-qmake-catch-trompeloeil-live
```

## How to Use

To use the live coding environment, you need to follow these steps:

1. Create [`live.qml`](./example/live.qml) which is the live coding version of your `main.qml`.
2. Modify your [`main.cpp`](./example/main.cpp) to add a `-l --live` command line argument.
3. Disable shadow build and run your application.

Take a look at [example](./example) for an example.
