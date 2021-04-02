import QtQuick 2.6
import "../controls" as Controls

Item {
    anchors.fill: parent;

    Controls.TAlertMessage {
        id: alertMessage
    }

    Controls.TButton {
        font.pixelSize: 20;
        baseColor: "#00BFB5"
        textColor: "#FFFFFF";
        radius: height
        anchors.centerIn: parent;
        text: qsTr("显示一条消息")

        property var index: -1;
        property var msgInfo: [
            {type: "success",   label: qsTr("这是一条成功的消息")},
            {type: "fail",      label: qsTr("这是一条失败的消息")},
            {type: "warning",   label: qsTr("这是一条警告的消息")}]

        onClicked: {
            index ++;

            var curInfo =  msgInfo[index];
            alertMessage.appendMessage(curInfo.type, curInfo.label)

            if (index == 2) {
                index = -1
            }
        }
    }
}
