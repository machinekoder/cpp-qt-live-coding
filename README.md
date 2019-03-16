# C++ Qt Live Coding

This project aims to be the C++ version for Qt/QML live coding.

In constrast to other live coding environments, this project is a live coding QML module meant to be integrated into your application.

Integrating QML live coding into your application significantly boosts your HMI developers productivity. Compared to stand-alone solutions, this approach enables integration of C++ QML components without deploying them first.

Additionally, it enabled customization of the live coding environemnt, including pre-loading of resource intensive QML components.

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

