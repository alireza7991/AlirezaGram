#include <QCoreApplication>
#include <QDebug>
#include <QUdpSocket>
#include <iostream>

#define SERVER_PORT 7991

using namespace std;

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    cout << "Starting server ..." << endl;
    QUdpSocket *serverSocket = new QUdpSocket(0);
    serverSocket->bind(SERVER_PORT,QUdpSocket::ShareAddress);
    while (serverSocket->waitForReadyRead(-1)) {
           while(serverSocket->hasPendingDatagrams()) {
               QByteArray datagram;
               datagram.resize(serverSocket->pendingDatagramSize());
               QHostAddress sender;
               quint16 senderPort;
               serverSocket->readDatagram(datagram.data(), datagram.size(),&sender, &senderPort);
               cout << "datagram received from " << sender.toString().toStdString() << " "<<datagram.data()<<endl;
           }
       }
    return a.exec();
}
