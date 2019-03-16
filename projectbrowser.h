#ifndef PROJECTBROWSER_H
#define PROJECTBROWSER_H

#include <QObject>
#include <QUrl>

class ProjectBrowser : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList qmlFiles READ qmlFiles NOTIFY qmlFilesChanged)
    Q_PROPERTY(QUrl projectPath READ projectPath CONSTANT)

public:
    explicit ProjectBrowser(QObject *parent = nullptr);

    QStringList qmlFiles() const;
    QUrl projectPath() const;

signals:
    void qmlFilesChanged();

public slots:
    void update();

private:
    QStringList m_qmlFiles;
    QUrl m_projectPath;

    void updateFiles();
};

#endif // PROJECTBROWSER_H
