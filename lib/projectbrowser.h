#ifndef PROJECTBROWSER_H
#define PROJECTBROWSER_H

#include <QObject>
#include <QUrl>

class ProjectBrowser : public QObject {
    Q_OBJECT
    Q_PROPERTY(QStringList qmlFiles READ qmlFiles NOTIFY qmlFilesChanged)
    Q_PROPERTY(QUrl projectPath READ projectPath WRITE setProjectPath NOTIFY projectPathChanged)
    Q_PROPERTY(QStringList extensions READ extensions WRITE setExtensions NOTIFY extensionsChanged)

public:
    explicit ProjectBrowser(QObject* parent = nullptr);

    QStringList qmlFiles() const;
    QUrl projectPath() const;
    QStringList extensions() const;

    void setProjectPath(const QUrl &newProjectPath);

signals:
    void qmlFilesChanged();
    void extensionsChanged();

    void projectPathChanged();

public slots:
    void update();

    void setExtensions(const QStringList& extensions);

private:
    QStringList m_qmlFiles;
    QUrl m_projectPath;
    QStringList m_extensions;

    void updateFiles();
};

#endif // PROJECTBROWSER_H
