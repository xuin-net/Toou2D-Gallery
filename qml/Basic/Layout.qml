import QtQuick 2.6
import "../controls" as Controls

Item {
    anchors.fill: parent;
    Text {
        anchors.centerIn: parent;
        text: qsTr("混合布局")
    }

    Controls.TGridLayout {
        id: layout
        Text {
            id: textCom
            text: qsTr("布局")
        }

        Rectangle {
            id: rectCom
            width: 100;height: 60
            color: "blue"
        }

        Repeater {
            model: 10;
            delegate: Rectangle {
                width: 100;height: 30
                color: "red"
            }
        }

        Text {
            text: qsTr("布局")
        }

        Rectangle {
            width: 100;height: 60
            color: "blue"
        }

        Repeater {
            model: 10;
            delegate: Rectangle {
                width: 80;height: 30
                color: "red"
            }
        }

    }

    Component.onCompleted: {
        console.log("检错",parent.width,parent.height);
    }
}
