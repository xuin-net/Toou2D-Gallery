import QtQuick 2.0

Rectangle {
    id: btn;
    implicitWidth: txt.contentWidth + offsetWidth;implicitHeight: 60;
    color: btnColor;
    signal clicked();

    property alias font: txt.font;
    property alias text: txt.text;
    property alias textColor: txt.color;
    property alias textContentWidth: txt.contentWidth

    property color baseColor: "#9E9E9E";
    property color btnColor: area.pressed
                             ? (checkColor ? checkColor
                                           : Qt.darker(btn.baseColor, 1.2))
                             : baseColor
    property var checkColor;
    property bool isChecked: false;
    property bool down: false;
    property int offsetWidth: 40

    Text{
        id: txt
        anchors.centerIn: btn;
    }

    MouseArea{
        id: area
        anchors.fill: btn;
        enabled: btn.enabled;
        onPressed: {
            btn.isChecked = true;
            btn.down = true;
        }
        onReleased: {
            btn.down = false;
            if(btn.isChecked)
                btn.clicked();
            btn.isChecked = false;
        }
        onExited: btn.isChecked = false;
    }
}
