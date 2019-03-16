# Live Coding Environment for C++, Qt and QML
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/machinekoder/cpp-qt-live-coding/blob/master/LICENSE)

This project aims to be the C++ version for Qt/QML live coding.

In constrast to other live coding environments, this project is a live coding QML module meant to be integrated into your application.

Integrating QML live coding into your application significantly boosts your HMI developers productivity. Compared to stand-alone solutions, this approach enables integration of C++ QML components without deploying them first.

Additionally, it enables customization of the live coding environemnt, including pre-loading of resource intensive QML components.

**See also**

* [python-qt-live-coding](https://github.com/machinekoder/python-qt-live-coding): The Python version of this project.

## Install

### With Qt Creator

* git clone the project repository
* Open the projects `.pro` file in Qt Creator
* add a new make install step with Make argument `install`
* Build

### From the terminal

```bash
git cloneh https://github.com/machinekoder/cpp-qt-live-coding.git
cd cpp-qt-live-coding
mkdir build
cd build
qmake ..
make -j$(nproc)
make install
```

## How to Use

To use the live coding environment, you need to follow these steps:

1. Create [`live.qml`](./example/live.qml) which is the live coding version of your `main.qml`.
2. Modify your [`main.cpp`](./example/main.cpp) to add a `-l --live` command line argument.
3. Disable shadow build and run your application.

Take a look at [example](./example) for an example.
