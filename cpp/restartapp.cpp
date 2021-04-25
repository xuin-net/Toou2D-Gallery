#include "restartapp.h"
#include <QDebug>
#include <QGuiApplication>
#include <QQmlContext>

ReStartApp::ReStartApp(QQmlApplicationEngine *qmlEngine)
{
    this->engine = qmlEngine;
}

QObject* ReStartApp::initSignal(){
    if(this->engine->rootObjects().length()>0){
        // delete last object
        this->firstrootobj->deleteLater();
    }
    this->engine->load(QUrl(QStringLiteral("qrc:/main.qml")));
//    this->engine->load(QUrl(QStringLiteral("$$PWD/../../../../Toou2D-Gallery/main.qml")));
    this->firstrootobj = this->engine->rootObjects().last();
    QObject::connect(this->firstrootobj,SIGNAL(reStartApp()),this,SLOT(appReload()));
    return this->firstrootobj;
}

void ReStartApp::appReload()
{
    //this operation will cause app exit with crash because of the QTBUG-56935
    //and fix since Qt5.9.3 at qtgraphicaleffects module
    this->engine->clearComponentCache();
    this->initSignal();
}
