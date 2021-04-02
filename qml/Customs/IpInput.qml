import QtQuick 2.0
import "../controls" as Controls

Flickable {
    anchors.fill: parent;
    property var addressRegExp: /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])(\:([0-9]|[1-9]\d{1,3}|[1-5]\d{4}|6[0-5]{2}[0-3][0-5]))?$/;

    Controls.TAddressInput {
        id: addressInput;
        width: 800;height: 70

        validator: RegExpValidator { regExp: addressRegExp }
        inputMethodHints: Qt.ImhPreferLowercase

        anchors.centerIn: parent;

        onStartConnect: {
            emulateTimer.start()
        }
    }

    Timer {
        id: emulateTimer
        interval: 2000
        onTriggered: {
            addressInput.setSuccessState();
        }
    }
}
