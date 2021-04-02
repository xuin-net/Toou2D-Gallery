import QtQuick 2.6
import "../controls" as Controls

Item {
    anchors.fill: parent;

    Controls.TNotifyManagement {
        id: notifyManagement;
        anchors.right: parent.right;
        y: 28
        width: 454;height: parent.height - y;
    }

    Controls.TButton {
        font.pixelSize: 20;
        baseColor: "#00BFB5"
        textColor: "#FFFFFF";
        radius: height

        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left
        anchors.leftMargin: 30
        text: qsTr("显示一条消息")

        onClicked: {
            notifyManagement.appendMessage(qsTr("已启用自动分析"));
        }
    }
}
