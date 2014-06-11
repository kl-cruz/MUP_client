#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include "mupServerHandle.h"
#include <QObject>
#include <QQmlComponent>
#include <QQmlEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QtQuick2ApplicationViewer viewer;
    qmlRegisterType<mupServerHandle>("mupServerHandle", 1, 0, "ServerHandle");
    viewer.setMainQmlFile(QStringLiteral("qml/MUP_qchartjs/main2.qml"));

    viewer.showExpanded();

    return app.exec();
}
