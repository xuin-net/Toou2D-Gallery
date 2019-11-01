#ifndef RESTARTAPP_H
#define RESTARTAPP_H
#include <QObject>
#include <QQmlApplicationEngine>

class ReStartApp : public QObject
{
    Q_OBJECT
public:
    explicit ReStartApp(QQmlApplicationEngine *qmlEngine);

public slots:
    void appReload();
    QObject* initSignal();
private:
    QQmlApplicationEngine *engine;
    QObject *firstrootobj;
};

#endif // RESTARTAPP_H
