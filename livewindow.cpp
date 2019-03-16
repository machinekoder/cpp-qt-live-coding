#include "livewindow.h"

QString LiveWindow::loadLiveWindow()
{
    Q_INIT_RESOURCE(livewindow);
    return QStringLiteral("qrc:/com/machinekoder/live/LiveWindow.qml");
}
