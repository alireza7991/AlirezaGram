function Create(arg1, arg2, arg3) {
    Qt.createQmlObject('\
    import QtQuick 2.5

    Rectangle {
        x: 500
        y: 100
        width: 100
        height: 100
    }', arg2, arg3)
}

