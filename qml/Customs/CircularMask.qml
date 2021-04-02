import QtQuick 2.6
import "../controls" as Controls

Item {
    anchors.fill: parent;

    Controls.TButton {
        id: enterBtn;
        x: 30;y: 30
        font.pixelSize: 20;
        baseColor: "#00BFB5"
        textColor: "#FFFFFF";
        radius: height

        text: qsTr("入口")

        onClicked: {
            mask.enter(Qt.point(enterBtn.x+enterBtn.width/2,
                                enterBtn.y+enterBtn.height/2));
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
            id: exitBtn
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            anchors.rightMargin: 30

            font.pixelSize: 20;
            baseColor: "#00BFB5"
            textColor: "#FFFFFF";
            radius: height

            text: qsTr("出口")

            onClicked: {
                mask.exit(Qt.point(exitBtn.x+exitBtn.width/2,
                                   exitBtn.y+exitBtn.height/2));
            }
        }
    }
}
