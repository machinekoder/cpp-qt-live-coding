#include "projectbrowser.h"

#include <QCoreApplication>
#include <QDebug>
#include <QDir>
#include <QDirIterator>
#include <QFileInfo>

ProjectBrowser::ProjectBrowser(QObject* parent)
    : QObject(parent)
{
    m_projectPath = QUrl::fromLocalFile(QFileInfo(QCoreApplication::applicationFilePath()).dir().path());

    connect(this, &ProjectBrowser::extensionsChanged, this, &ProjectBrowser::updateFiles);
}

QStringList ProjectBrowser::qmlFiles() const
{
    return m_qmlFiles;
}

QUrl ProjectBrowser::projectPath() const
{
    return m_projectPath;
}

QStringList ProjectBrowser::extensions() const
{
    return m_extensions;
}

void ProjectBrowser::update()
{
    updateFiles();
}

void ProjectBrowser::setExtensions(const QStringList& extensions)
{
    if (m_extensions == extensions)
        return;

    m_extensions = extensions;
    emit extensionsChanged();
}

void ProjectBrowser::updateFiles()
{
    QStringList fileList;
    const auto& root = m_projectPath.toLocalFile();

    QDirIterator it(root, QDirIterator::Subdirectories | QDirIterator::FollowSymlinks);
    while (it.hasNext()) {
        it.next();
        const auto& extension = it.fileInfo().completeSuffix();
        if (m_extensions.contains(extension, Qt::CaseInsensitive)) {
            fileList.append(it.fileInfo().filePath());
        }
    }
    m_qmlFiles = fileList;
    emit qmlFilesChanged();
}
