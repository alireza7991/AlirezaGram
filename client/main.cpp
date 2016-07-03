#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QQmlContext>
#include <QLocale>
#include <QDebug>
#include <QVector>
#include <QColor>
#include <QImage>
#include <QPixmap>
#include <QString>
#include <string>
#include <iostream>
#include <AlirezaSocket.h>
#include <opencvQtWrapper.h>

#define SERVER_IP (char *)"127.0.0.1"
#define SERVER_PORT 7991

struct msg {
    string sender;
    string content;
};

class AlirezaLogin : public AlirezaSocket {
public:
    string u,p;
    bool result = false;
    string sid;
    void onConnect(SOCKET c) {
        string out = "l";
        out +=(char)(u.length()+48);
        out += u;
        out +=(char)(p.length()+48);
        out += p;
        cout << "command: " << out << endl;
        sendString(c,out);
        string res=recieveString(c);
        if(res=="lf") {
            result = false;
            closesocket(c);
        }
        sid = res.substr(2,string::npos);
        result = true;
        closesocket(c);
    }
};

class AlirezaGetContacts : public AlirezaSocket {
public:
    string sid;
    vector<string> contacts;
    bool result = false;
    void onConnect(SOCKET c) {
        string out = "c";
        out += sid;
        cout << "command: " << out << endl;
        sendString(c,out);
        string res=recieveString(c);
        if(res=="esid") {
            result = false;
            closesocket(c);
        }
        res += ':';
        int lastPosition = 0;
        bool continueLoop = true;
        while (continueLoop) {
             unsigned int pos = res.find(':', lastPosition);
             if (pos == res.length() - 1) continueLoop = false;
             contacts.push_back(res.substr(lastPosition, pos - lastPosition));
             lastPosition = pos + 1;
         }
        result = true;
        closesocket(c);
    }
};


class AlirezaSignup : public AlirezaSocket {
public:
    string u,p;
    bool result = false;
    string sid;
    void onConnect(SOCKET c) {
        string out = "s";
        out +=(char)(u.length()+48);
        out += u;
        out +=(char)(p.length()+48);
        out += p;
        cout << "command: " << out << endl;
        sendString(c,out);
        string res=recieveString(c);
        if(res=="sf") {
            result = false;
            closesocket(c);
        }
        sid = res.substr(2,string::npos);
        result = true;
        closesocket(c);
    }
};

class AlirezaWriteMessage : public AlirezaSocket {
public:
    string sid,rec,con;
    bool result = false;
    void onConnect(SOCKET c) {
        string out = "w";
        out += sid;
        out += rec;
        out += ':';
        out += con;
        cout << "command: " << out << endl;
        sendString(c,out);
        string res=recieveString(c);
        if(res!="mo") {
            cout << "send message failed with " << res << endl;
            result = false;
            closesocket(c);
        }
        result = true;
        closesocket(c);
    }
};

class AlirezaReadMessage : public AlirezaSocket {
public:
    string sid;
    bool result = false;
    vector<msg> msgs;
    void onConnect(SOCKET c) {
        string out = "r";
        out +=sid;
        cout << "command: " << out << endl;
        sendString(c,out);
        string res=recieveString(c);
        if(res.substr(0,2)!="mo") {
            cout << "read messages failed with " << res << endl;
            result = false;
            closesocket(c);
        }
        int n = stoi(res.substr(2,string::npos));
        cout << "unread messages " << n << endl;
        for(int i=0; i<n;i++) {
            string smsg = recieveString(c);
            unsigned mdiv = smsg.find(':',0);
            string sender = smsg.substr(0,mdiv);
            string content = smsg.substr(mdiv+1,string::npos);
            cout << "recieved msg : " << sender<< " content: " << content << endl;
            msg ms;
            ms.sender = sender;
            ms.content = content;
            msgs.push_back(ms);
        }
        result = true;
        closesocket(c);
    }
};

bool Alogin(string user,string pass,string &sid) {
    try {
        AlirezaLogin a;
        a.u=user;
        a.p=pass;
        a.Connect(SERVER_IP,SERVER_PORT);
        sid=a.sid;
        return a.result;
    } catch(runtime_error e) {
        cout << e.what() << endl;
        return false;
    }
}

bool Asignup(string user,string pass,string &sid) {
    try {
        AlirezaSignup a;
        a.u=user;
        a.p=pass;
        a.Connect(SERVER_IP,SERVER_PORT);
        sid=a.sid;
        return a.result;
    } catch(runtime_error e) {
        cout << e.what() << endl;
        return false;
    }

}

bool Agetcontacts(string sid,vector<string> &contacts) {
    try {
        AlirezaGetContacts a;
        a.sid=sid;
        a.Connect(SERVER_IP,SERVER_PORT);
        contacts=a.contacts;
        return a.result;
    } catch(runtime_error e) {
        cout << e.what() << endl;
        return false;
    }
}

bool Agetmsgs(string sid,vector<msg> &msgs) {
    try {
        AlirezaReadMessage a;
        a.sid=sid;
        a.Connect(SERVER_IP,SERVER_PORT);
        msgs=a.msgs;
        return a.result;
    } catch(runtime_error e) {
        cout << e.what() << endl;
        return false;
    }
}

bool Asendmsg(string sid,string reciever,string content) {
    try {
        AlirezaWriteMessage a;
        a.sid=sid;
        a.con=content;
        a.rec=reciever;
        a.Connect(SERVER_IP,SERVER_PORT);
        return a.result;
    } catch(runtime_error e) {
        cout << e.what() << endl;
        return false;
    }
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QFontDatabase::addApplicationFont(":/fonts/Material-Design-Iconic-Font.ttf");
    QFontDatabase::addApplicationFont(":/fonts/OpenSans-Bold.ttf");
    QFontDatabase::addApplicationFont(":/fonts/OpenSans-Regular.ttf");
    QFontDatabase::addApplicationFont(":/fonts/OpenSans-Semibold.ttf");
    QFontDatabase::addApplicationFont(":/fonts/emoticons.ttf");

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("mi_search", u8"\uf1c3");
    engine.rootContext()->setContextProperty("mi_account", u8"\uf203");
    engine.rootContext()->setContextProperty("mi_account_c", u8"\uf205");
    engine.rootContext()->setContextProperty("mi_close", u8"\uf136");
    engine.rootContext()->setContextProperty("mi_maximize", u8"\uf1ea");
    engine.rootContext()->setContextProperty("mi_minimize", u8"\uf1eb");
    engine.rootContext()->setContextProperty("mi_restore", u8"\uf1ec");
    engine.rootContext()->setContextProperty("mi_chevron_right", u8"\uf2fb");
    engine.rootContext()->setContextProperty("mi_chevron_left", u8"\uf2fa");
    engine.rootContext()->setContextProperty("mi_comments", u8"\uf266");
    engine.rootContext()->setContextProperty("mi_emoji", u8"\uf214");
    engine.rootContext()->setContextProperty("mi_face", u8"\uf20e");
    engine.rootContext()->setContextProperty("mi_check_all", u8"\uf267");
    engine.rootContext()->setContextProperty("mi_check", u8"\uf26b");
    engine.rootContext()->setContextProperty("mi_caret_left", u8"\uf2f4");
    engine.rootContext()->setContextProperty("mi_caret_right", u8"\uf2f6");
    engine.rootContext()->setContextProperty("mi_caret_up", u8"\uf2f8");
    engine.rootContext()->setContextProperty("mi_caret_down", u8"\uf2f2");
    engine.rootContext()->setContextProperty("mi_camera", u8"\uf283");
    engine.rootContext()->setContextProperty("mi_comment_video", u8"\uf264");
    engine.rootContext()->setContextProperty("mi_send", u8"\uf1a1");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}

