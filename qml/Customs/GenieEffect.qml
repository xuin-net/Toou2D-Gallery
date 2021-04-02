import QtQuick 2.6
import "../controls" as Controls

Item {
    id: viewPage
    anchors.fill: parent;

    Controls.TGenieEffect {
        id: effect
        side: (enterBtn.x + enterBtn.width/2) / viewPage.width
        width: parent.width;height: parent.height;
    }

    Controls.TButton {
        id: enterBtn;
        x: 100;
        font.pixelSize: 20;
        baseColor: "#00BFB5"
        textColor: "#FFFFFF";
        radius: height

        property bool hasOpen: false;
        text: !hasOpen ? qsTr("打开一张图") : qsTr("关闭一张图");

        onClicked: {
            if (effect.firstLoader) {
                // 等待渲染完再做动画
                effect.imgSrc = "qrc:/assets/pic-todaybing-hd-5EwjDtWR.jpeg"
                hasOpen = true;
                return;
            }

            if (hasOpen) {
                effect.close();
            } else {
                effect.open();
            }
            hasOpen = !hasOpen;
        }
    }
}
