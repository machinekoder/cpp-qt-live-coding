#include <QCommandLineParser>
#include <QFile>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("machinekoder.com");
    app.setOrganizationDomain("machinekoder.com");
    app.setApplicationName("LiveCodingExample");
    app.setApplicationDisplayName("Live Coding Example");

    QCommandLineParser parser;
    parser.setApplicationDescription("Live Coding Example");
    parser.addHelpOption();
#ifdef QT_DEBUG
    QCommandLineOption forceOption(QStringList() << "l" << "live",
    QCoreApplication::translate("live", "Start live coding mode."));
    parser.addOption(forceOption);
#endif
    parser.process(app);

    QString fileName = QStringLiteral("main.qml");
#ifdef QT_DEBUG
    if (parser.isSet(forceOption)) {
        fileName = QStringLiteral("live.qml");
    }
#endif

    QQmlApplicationEngine engine;
    engine.addImportPath(QStringLiteral("."));
    engine.addImportPath(QStringLiteral("qrc:/"));
    QFile file(QStringLiteral("./") + fileName);
    if (file.exists()) {
        engine.load(QStringLiteral("./") + fileName);
    }
    else {
        engine.load(QUrl(QStringLiteral("qrc:/") + fileName));
    }
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
