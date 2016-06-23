#include <QCoreApplication>
#include <QDebug>
#include <QUdpSocket>
#include <vector>
#include <iostream>
#include <cstring>
#include <ctime>

#define SERVER_PORT 7991
#define SID_LIFE_TIME 60*15 // 15 minute
#define SID_LEN 5

using namespace std;


class UserManager {
public:
    bool login(char *user,char *passwd);
    bool checkSID(char *sid);
    char *newSID(char *user);
    void signup(char *user,char *passwd);
    char *getSIDUser(char *sid);
    bool checkUser(char *user);
    void updateSID(char *sid);
    struct SIDEntry {
      char *sid;
      char *user;
      int time;
    };
    struct UserEntry {
        char *user;
        char *passwd;
    };

protected:
    char *genRandomSid();
    vector<SIDEntry> sids;
    vector<UserEntry> users;
};


char *UserManager::genRandomSid() {
    char *s = new char[SID_LEN];
    static const char alphanum[] =
        "0123456789"
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        "abcdefghijklmnopqrstuvwxyz";

    for (int i = 0; i < SID_LEN; ++i) {
        s[i] = alphanum[rand() % (sizeof(alphanum) - 1)];
    }
    s[SID_LEN] = 0;
    return s;
}

bool UserManager::login(char *user,char *passwd) {
    for(UserEntry t : users) {
        if(!strcmp(t.user,user) && !strcmp(t.passwd,passwd)) {
            return true;
        }
    }
    return false;
}

bool UserManager::checkSID(char *sid) {
    for(SIDEntry t : sids) {
        if(!strcmp(t.sid,sid) && (t.time + SID_LIFE_TIME > time(0))) {
            return true;
        }
    }
    return false;
}

void UserManager::updateSID(char *sid) {
    for(int i = 0 ; i<sids.size();i++) {
        if(!strcmp(sids[i].sid,sid)) {
            sids[i].time=time(0);
        }
    }
}

char *UserManager::getSIDUser(char *sid) {
    for(int i = 0 ; i<sids.size();i++) {
        if(!strcmp(sids[i].sid,sid)) {
            return sids[i].user;
        }
    }
    return 0;
}

char *UserManager::newSID(char *user) {
    SIDEntry t;
    t.user=user;
    t.time=time(0);
    t.sid=genRandomSid();
    sids.push_back(t);
    return t.sid;
}

void UserManager::signup(char *user,char *passwd) {
    UserEntry e;
    e.user = user;
    e.passwd = passwd;
    users.push_back(e);
}

bool UserManager::checkUser(char *user) {
    for(UserEntry t : users) {
        if(!strcmp(t.user,user)) return true;
    }
    return false;
}

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
