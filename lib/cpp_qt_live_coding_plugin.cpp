#include "cpp_qt_live_coding_plugin.h"
#include "applicationhelpers.h"
#include "filewatcher.h"
#include "projectbrowser.h"

#include <QFile>
#include <qqml.h>

static void initResources()
{
    Q_INIT_RESOURCE(qml);
}


static const struct {
    const char *type;
    int major, minor;
} qmldir [] = {
    { "LiveCodingPanel", 1, 0 },
    { "FileSelectionDialog", 1, 0 },
};

void CppQtLiveCodingPlugin::registerTypes(const char *uri)
{
    initResources();

    // @uri com.machinekoder.live
    qmlRegisterType<FileWatcher>(uri, 1, 0, "FileWatcher");
    qmlRegisterType<ProjectBrowser>(uri, 1, 0, "ProjectBrowser");
    qmlRegisterSingletonType<ApplicationHelpers>(uri, 1, 0, "ApplicationHelpers", ApplicationHelpers::qmlSingletonProvider);

    const QString filesLocation = fileLocation();
    for (int i = 0; i < int(sizeof(qmldir)/sizeof(qmldir[0])); i++) {
        qmlRegisterType(QUrl(filesLocation + "/" + qmldir[i].type + ".qml"), uri, qmldir[i].major, qmldir[i].minor, qmldir[i].type);
    }
}

void CppQtLiveCodingPlugin::initializeEngine(QQmlEngine *engine, const char *uri)
{
    Q_UNUSED(uri);

    if (isLoadedFromResource())
        engine->addImportPath(QStringLiteral("qrc:/"));
}

QString CppQtLiveCodingPlugin::fileLocation() const
{
    if (isLoadedFromResource())
        return QStringLiteral("qrc:/com/machinekoder/live");
    return baseUrl().toString();
}

bool CppQtLiveCodingPlugin::isLoadedFromResource() const
{
    // If one file is missing, it will load all the files from the resource
    QFile file(baseUrl().toLocalFile() + "/" + qmldir[0].type + ".qml");
    if (!file.exists())
        return true;
    return false;
}
