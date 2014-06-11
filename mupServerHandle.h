#ifndef CLIENT_H
#define CLIENT_H

#include <QTcpSocket>

class mupServerHandle : public QObject
{
    Q_OBJECT
private:
    QTcpSocket *serverSocket;

public:
    mupServerHandle();

public slots:
    void readValue();
    void disconnect(void);
    void connectOk(void);
    void sendValue(QByteArray data);
    bool connect(QString hostName, quint16 port);
    void disconnectFromServer();
signals:
    void valueChanged(float newValue);
    void disconnected(void);
    void connected(void);
};

#endif // CLIENT_H
