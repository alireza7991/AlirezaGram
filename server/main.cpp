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

struct SIDEntry {
  char *sid;
  const char *user;
  int time;
};

struct UserEntry {
    const char *user;
    const char *passwd;
};

struct MsgEntry {
    const char *content;
    const char *sender;
    const char *reciever;
    unsigned time;
};

class MessageManager {
public:
    vector<MsgEntry> getUserMsgs(const char *username);
    void addMsg(const char *sender,const char *reciever,const char *content);
    void debug();
private:
    vector<MsgEntry> msgs;
};

vector<MsgEntry> MessageManager::getUserMsgs(const char *username) {
    vector<MsgEntry> m;
    for(int i=0; i<msgs.size();i++) {
        if(!strcmp(username,msgs[i].reciever)) {
            m.push_back(msgs[i]);
            msgs[i].reciever="GARBAGE&&&&&&";
        }
    }
    return m;
}

void MessageManager::addMsg(const char *sender,const char *reciever,const char *content) {
    MsgEntry m;
    m.sender=strdup(sender);
    m.reciever=strdup(reciever);
    m.time=time(0);
    m.content=strdup(content);
    msgs.push_back(m);
}


void MessageManager::debug() {

    for(MsgEntry e : msgs) {
        cout << "sender " << e.sender << " reciever " << e.reciever << " content " << e.content<<endl;
    }
}

class UserManager {
public:
    bool login(const char *user,const char *passwd);
    bool checkSID(const char *sid);
    const char *newSID(const char *user);
    bool signup(const char *user,const char *passwd);
    const char *getSIDUser(const char *sid);
    bool checkUser(const char *user);
    void updateSID(const char *sid);
    vector<UserEntry> getUserList() {
        return this->users;
    }
    void debug();


protected:
    char *genRandomSid();
    vector<SIDEntry> sids;
    vector<UserEntry> users;
};


char *UserManager::genRandomSid() {
    srand(time(0));
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

bool UserManager::checkSID(const char *sid) {
    for(SIDEntry t : sids) {
        if(!strcmp(t.sid,sid) && (t.time + SID_LIFE_TIME > time(0))) {
            return true;
        }
    }
    return false;
}

void UserManager::updateSID(const char *sid) {
    for(int i = 0 ; i<sids.size();i++) {
        if(!strcmp(sids[i].sid,sid)) {
            sids[i].time=time(0);
        }
    }
}

const char *UserManager::getSIDUser(const char *sid) {
    for(int i = 0 ; i<sids.size();i++) {
        if(!strcmp(sids[i].sid,sid)) {
            return sids[i].user;
        }
    }
    return 0;
}

const char *UserManager::newSID(const char *user) {
    SIDEntry t;
    t.user=strdup(user);
    t.time=time(0);
    t.sid=genRandomSid();
    sids.push_back(t);
    return t.sid;
}

// TODO: check if username is not registered before

bool UserManager::signup(const char *user,const char *passwd) {
    cout << "sg " << user<<" p  " << passwd << endl;
    UserEntry e;
    e.user = strdup(user);
    e.passwd = strdup(passwd);
    users.push_back(e);
    return true;
}

bool UserManager::checkUser(const char *user) {
    for(UserEntry t : users) {
        if(!strcmp(t.user,user)) return true;
    }
    return false;
}

void UserManager::debug() {
    cout << "DEBUG =====" << endl;
    for(UserEntry e : users) {
        cout << "name: "<<e.user << " pass:" << e.passwd  << endl;
    }
    for(SIDEntry e : sids) {
        cout << "name: "<<e.user << " sid:" << e.sid << endl;
    }


}

class Server : public AlirezaSocket {

public:

    Server() : AlirezaSocket() {
        manager.signup("alireza","1234");


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
             cout << "recieved a sign-up request" << endl;
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
             if(manager.signup(username.c_str(),passwd.c_str())) {
                  string session_id(manager.newSID(username.c_str()));
                  string out = "so" + session_id;
                  cout << "sign-up " << username << " successfully with password: " << passwd << " sid: " << session_id << endl;
                  sendString(c,out);
             } else {
                   cout << "sign-up failed for " << username << endl;
                   string out = "sf";
                   sendString(c,out);
             }

        // write message
        } else if(command[0]=='w') {
            string sid = command.substr(1,5);
            if(!manager.checkSID(sid.c_str())) {
                string out="esid";
                sendString(c,out);
                closesocket(c);
                return;
            }
            unsigned ul = command.find(':',0);
            string reciever = command.substr(6,ul-6);
            string content = command.substr(ul+1,string::npos);
            string sender = manager.getSIDUser(sid.c_str());
            cout << "recieved a message from " << sender << " to " << reciever << " content " << content << endl;
            msgmanager.addMsg(sender.c_str(),reciever.c_str(),content.c_str());
            string out = "mo";
            sendString(c,out);
        // read message
        } else if(command[0]=='r') {
            string sid = command.substr(1,5);
            if(!manager.checkSID(sid.c_str())) {
                string out="esid";
                sendString(c,out);
                closesocket(c);
                return;
            }
            string out = "mo";
            string username = manager.getSIDUser(sid.c_str());
            vector<MsgEntry> msgs = msgmanager.getUserMsgs(username.c_str());
            out += to_string(msgs.size());
            sendString(c,out);
            for(MsgEntry m : msgs) {
                string ms = "ms";
                ms += string(m.sender);
                ms += ':';
                ms += string(m.content);
                sendString(c,ms);
            }

        // get contacts
        } else if(command[0]=='c') {
            string sid = command.substr(1,5);
            if(!manager.checkSID(sid.c_str())) {
                string out="esid";
                sendString(c,out);
                closesocket(c);
                return;
            }
            vector<UserEntry> users = manager.getUserList();
            string out = "co";
            for(auto u : users) {
                out += u.user;
                out += ":";
            }
            sendString(c,out);
        }
        else if(command[0]=='d') {
            manager.debug();
            msgmanager.debug();
        } // else !
        else {
            string out = "esyntax";
            sendString(c,out);
        }
    }

private:
    UserManager manager;
    MessageManager msgmanager;

};

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    Server server;
    server.Listen(SERVER_PORT);
    return a.exec();
}
