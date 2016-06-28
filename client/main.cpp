#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QFontDatabase::addApplicationFont(":/fonts/Material-Design-Iconic-Font.ttf");
    QFontDatabase::addApplicationFont(":/fonts/OpenSans-Bold.ttf");
    QFontDatabase::addApplicationFont(":/fonts/OpenSans-Regular.ttf");
    QFontDatabase::addApplicationFont(":/fonts/OpenSans-Semibold.ttf");

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("mi_search", u8"\uf1c3");
    engine.rootContext()->setContextProperty("mi_account", u8"\uf205");
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

