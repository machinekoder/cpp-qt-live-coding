#include "projectbrowser.h"

#include <QCoreApplication>
#include <QFileInfo>
#include <QDir>
#include <QDirIterator>
#include <QDebug>

ProjectBrowser::ProjectBrowser(QObject *parent) : QObject(parent)
{
    m_projectPath = QUrl::fromLocalFile(QFileInfo(QCoreApplication::applicationFilePath()).dir().path());

    updateFiles();
}

QStringList ProjectBrowser::qmlFiles() const
{
    return m_qmlFiles;
}

QUrl ProjectBrowser::projectPath() const
{
    return m_projectPath;
}

void ProjectBrowser::update()
{
    updateFiles();
}

void ProjectBrowser::updateFiles()
{
    QStringList fileList;
    const auto &root = m_projectPath.toLocalFile();

    QDirIterator it(root, QDirIterator::Subdirectories | QDirIterator::FollowSymlinks);
    while (it.hasNext()) {
        it.next();
        const auto &extension = it.fileInfo().completeSuffix();
        if (extension == "qml") {
            fileList.append(it.fileInfo().filePath());
        }
    }
    m_qmlFiles = fileList;
    emit qmlFilesChanged();
}
