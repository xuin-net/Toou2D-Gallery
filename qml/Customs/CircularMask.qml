import QtQuick 2.6
import "../controls" as Controls

Item {
    anchors.fill: parent;

    Controls.TButton {
        font.pixelSize: 20;
        baseColor: "#00BFB5"
        textColor: "#FFFFFF";
        radius: height

        text: qsTr("入口")

        onClicked: {
            mask.enter(Qt.point(0, 0));
        }
    }

    Controls.TCircularMask {
        anchors.fill: parent;
        id: mask

        Rectangle {
            anchors.fill: parent;
            color: "skyBlue"
        }

        Controls.TButton {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            font.pixelSize: 20;
            baseColor: "#00BFB5"
            textColor: "#FFFFFF";
            radius: height

            text: qsTr("出口")

            onClicked: {
                mask.exit(Qt.point(0, 0));
            }
        }
    }
}
