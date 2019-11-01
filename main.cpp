#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <time.h>
#include <QDebug>
#include "cpp/restartapp.h"

int main(int argc, char *argv[])
{
    clock_t start,finish;
    double totaltime;
    start=clock();

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    ReStartApp *restart = new ReStartApp(&engine);
    restart->initSignal();

//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
//    if (engine.rootObjects().isEmpty())
//        return -1;

    finish=clock();
    totaltime=(double)(finish-start)/CLOCKS_PER_SEC;
    qDebug() << "startup time :" << totaltime << "s";

    return app.exec();
}