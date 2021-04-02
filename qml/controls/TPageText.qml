import QtQuick 2.12

Item {
    id: digitalItem;
    width: numText.width
    height: numText.height
    property alias text: numText.text
    property alias color: numText.color
    property alias contentWidth: numText.contentWidth
    property alias textWidth: numText.width
    property alias horizontalAlignment: numText.horizontalAlignment;
    property int num;
    property alias pressed: mouseArea.pressed

    signal clicked();

    Text {
        id: numText;
        width: contentWidth
        height: contentHeight
        font.pixelSize: 18
    }

    MouseArea {
        id: mouseArea
        width: parent.width;
        height: parent.height + 8
        anchors.centerIn: parent;
        onClicked: {
            digitalItem.focus = true;
            digitalItem.clicked();
        }
    }
}
