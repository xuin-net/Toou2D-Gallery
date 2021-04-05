import QtQuick 2.6
import "../controls" as Controls

Item {
    anchors.fill: parent;

    Text {
        id: warnTxt
        anchors.centerIn: parent;
        font.pixelSize: 18;
        text: qsTr("支持动作：单指单击/双指双击")
    }

    Controls.TTwoFingerMouseArea {
        anchors.fill: parent;
        onSingleClicked: {
            warnTxt.text = qsTr("你刚才操作了单指单击")
        }

        onDoubleClicked: {
            warnTxt.text = qsTr("你刚才操作了双指双击")
        }
    }
}
