#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <time.h>
#include <QDebug>
#include "cpp/restartapp.h"
#include "cpp/qmlclipboardapter.h"

int main(int argc, char *argv[])
{
    clock_t start,finish;
    double totaltime;
    start=clock();

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<QmlClipboardAdapter>("Toou_QML_Tools", 1, 0, "LClipboard");

    ReStartApp *restart = new ReStartApp(&engine);


    engine.rootContext()->setContextProperty("_root_window_", restart->initSignal());

//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
//    if (engine.rootObjects().isEmpty())
//        return -1;

    finish=clock();
    totaltime=(double)(finish-start)/CLOCKS_PER_SEC;
    qDebug() << "startup time :" << totaltime << "s";

    return app.exec();
}
