import QtQuick 2.6
import "../controls" as Controls

Item {
    anchors.fill: parent;

    Controls.TCrumbs {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 24
        anchors.topMargin: 24

        model: [qsTr("典型超声图"), qsTr("病例解剖图"), qsTr("动态视频")]

        onClickItem: {
            warnTxt.text = qsTr("点击级数：" + String(index))
        }
    }

    Text {
        id: warnTxt
        font.pixelSize: 20
        anchors.centerIn: parent;
    }
}
