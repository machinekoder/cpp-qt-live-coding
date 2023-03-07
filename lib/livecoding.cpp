#include "livecoding.h"
#include <QCoreApplication>
#include <QDesktopServices>
#include <QDir>
#include <QLocale>
#include <QProcess>
#include <QSettings>

LiveCoding::LiveCoding(QQmlEngine* engine, QObject* parent)
    : QObject(parent)
    , m_engine(engine)
{
}

bool LiveCoding::openUrlWithDefaultApplication(const QUrl& url) const
{
    return QDesktopServices::openUrl(url);
}

void LiveCoding::clearQmlComponentCache() const
{
    m_engine->clearComponentCache();
}

QString LiveCoding::currentLanguage() const
{
    const auto languages = QLocale().uiLanguages();
    return languages.first();
}

void LiveCoding::setLanguage(const QString& language)
{
    QSettings settings;
    settings.setValue("language", language);
    settings.sync();
}

void LiveCoding::restartApplication()
{
    QProcess::startDetached(qApp->arguments().at(0), qApp->arguments().sliced(1));
    QCoreApplication::exit();
}
