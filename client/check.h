#ifndef CHECK_H
#define CHECK_H

#define UI Q_INVOKABLE

#include <QObject>
#include <QString>

class Check : public QObject
{
    Q_OBJECT

public:
    explicit Check(QObject *parent = 0);
    UI bool login(QString uname, QString upass);
    UI bool signup(QString uname, QString upass);
signals:

public slots:
};

#endif // CHECK_H
