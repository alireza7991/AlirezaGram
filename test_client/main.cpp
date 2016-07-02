#include <QCoreApplication>
#include <iostream>
#include <string>
#include <AlirezaSocket.h>

class client : public AlirezaSocket {

    void onConnect(SOCKET c) {
        cout << "connected" << endl;

            string s;
            getline(cin,s);
            sendString(c,s);
            cout << recieveString(c) << endl;
            closesocket(c);
    }
};

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    while(1)
    {
        try {
            client c;
            c.Connect((char *)"127.0.0.1",7991);
        } catch(runtime_error e) {
           cout << e.what() << endl;
        }
    }
    return a.exec();
}
