#include "mupServerHandle.h"

mupServerHandle::mupServerHandle()
{
    //connect("localhost",50000);
    //set up client
}

bool mupServerHandle::connect(QString hostName, quint16 port)
{
    serverSocket = new QTcpSocket();
    serverSocket->connectToHost(hostName,port);
    QObject::connect(serverSocket, SIGNAL(readyRead()), this, SLOT(readValue()));
    QObject::connect(serverSocket, SIGNAL(disconnected()), this, SLOT(disconnect()));
    QObject::connect(serverSocket, SIGNAL(connected()), this, SLOT(connectOk()));

    return serverSocket->waitForConnected(1000);
}

void mupServerHandle::disconnectFromServer()
{
    serverSocket->close();
}

void mupServerHandle::readValue()
{
QTcpSocket *client = (QTcpSocket*) sender();
qreal dane;
QDataStream in(client);
in.setVersion(QDataStream::Qt_4_6);
in>>dane;
/*qDebug() << "value: "<< dane << " " << in;
qDebug() << "dane:"<< dane;*/
emit valueChanged(dane);
}

void mupServerHandle::sendValue(QByteArray data)
{
    qDebug() << "żądanie wartości: "<<data ;
    serverSocket->write(data);
}

void mupServerHandle::disconnect(void)
{
    qDebug() << "wywaliło się...";
    emit disconnected();
}

void mupServerHandle::connectOk(void)
{
    qDebug() << "zalogowało";
    emit connected();
}
