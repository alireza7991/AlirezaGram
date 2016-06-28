#include <QCoreApplication>
#include <QDebug>
#include <QUdpSocket>
#include <vector>
#include <iostream>
#include <cstring>
#include <ctime>
#include <AlirezaSocket.h>

#define SERVER_PORT 7991
#define SID_LIFE_TIME 60*15 // 15 minute
#define SID_LEN 5

using namespace std;


class UserManager {
public:
    struct SIDEntry {
      char *sid;
      const char *user;
      int time;
    };
    struct UserEntry {
        const char *user;
        const char *passwd;
    };
    bool login(const char *user,const char *passwd);
    bool checkSID(char *sid);
    char *newSID(const char *user);
    void signup(const char *user,const char *passwd);
    const char *getSIDUser(char *sid);
    bool checkUser(const char *user);
    void updateSID(char *sid);
    vector<UserEntry> getUserList() {
        return this->users;
    }


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

bool UserManager::login(const char *user,const char *passwd) {
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

const char *UserManager::getSIDUser(char *sid) {
    for(int i = 0 ; i<sids.size();i++) {
        if(!strcmp(sids[i].sid,sid)) {
            return sids[i].user;
        }
    }
    return 0;
}

char *UserManager::newSID(const char *user) {
    SIDEntry t;
    t.user=user;
    t.time=time(0);
    t.sid=genRandomSid();
    sids.push_back(t);
    return t.sid;
}

void UserManager::signup(const char *user,const char *passwd) {
    UserEntry e;
    e.user = user;
    e.passwd = passwd;
    users.push_back(e);
}

bool UserManager::checkUser(const char *user) {
    for(UserEntry t : users) {
        if(!strcmp(t.user,user)) return true;
    }
    return false;
}


class Server : public AlirezaSocket {

public:

    Server() : AlirezaSocket() {
        manager.signup("alireza","testpassw");


    }

    void onConnect(SOCKET c) {
        string command = recieveString(c);
        // login command
        if(command[0]=='l') {
            cout << "recieved a login request" << endl;
            // retrieve username and password
            if(command[1]<'0' || command[1]>'9') {
                sendString(c,"esyntax");
                closesocket(c);
                return;
            }
            int usernamelen = command[1]-48;
            string username = command.substr(2,usernamelen);
            if(command[1]<'0' || command[1]>'9') {
                sendString(c,"esyntax");
                closesocket(c);
                return;
            }
            string passwd = command.substr(3+usernamelen,string::npos);
            // create session id if user
            if(manager.login(username.c_str(),passwd.c_str())) {
                string session_id(manager.newSID(username.c_str()));
                string out = "lo" + session_id;
                cout << "authenticated " << username << " successfully with sid: " << session_id << endl;
                sendString(c,out);
            } else {
                // auth failed!
                cout << "authentication failed for " << username << endl;
                string out = "lf";
                sendString(c,out);
            }
        // signup
        } else if(command[0]=='s') {



        // write message
        } else if(command[0]=='w') {


        // read message
        } else if(command[0]=='r') {


        // get contacts
        } else if(command[0]=='c') {


        } // else !
        else {
            string out = "esyntax";
            sendString(c,out);
        }
    }

private:
    UserManager manager;

};

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    Server server;
    server.Listen(SERVER_PORT);
    return a.exec();
}
