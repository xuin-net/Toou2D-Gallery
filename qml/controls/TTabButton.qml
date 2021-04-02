import QtQuick 2.0

Item{
    id: control;

    implicitWidth: 100;implicitHeight: 60
    clip: true;
    property alias bgVisible: bg.visible;
    property alias radius: bg.radius;
    property alias bgOffsetX: bg.x;
    property alias text: txt.text;
    property alias font: txt.font;
    property alias textColor: txt.color;
    property alias color: bg.color
    property alias border: bg.border
    property alias enabled: mouseArea.enabled

    property string type: "default" //[default/idle/checked]

    signal clicked();

    Rectangle{
        id: bg;
        width: control.width+radius;height: control.height;
        color: control.color
    }
    Text{
        id: txt;
        anchors.fill: parent;
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
    MouseArea{
        id: mouseArea
        anchors.fill: parent;
        onClicked: {
            control.clicked();
        }
    }
}
