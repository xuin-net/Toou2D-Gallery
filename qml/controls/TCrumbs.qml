import QtQuick 2.6
import QtQuick.Layouts 1.0

RowLayout {
    id: layout
    spacing: 8

    property alias model: repeater.model
    property color textColor: "#303133"
    property font textFont: Qt.font({pixelSize: 16});

    signal clickItem(int index);

    Repeater {
        id: repeater
        delegate: delegateCom
    }

    Component {
        id: delegateCom
        RowLayout {
            spacing: layout.spacing
            Text {
                font.pixelSize: layout.textFont.pixelSize
                // color: index < (layout.model.length-1) ? "#303133" : "#C0C4CC"
                color: layout.textColor
                text: modelData

                MouseArea {
                    //enabled: index < (layout.model.length-1) ? true : false
                    anchors.fill: parent;
                    onClicked: {
                        layout.clickItem(index)
                    }
                }
            }
            Image {
                visible: index < (layout.model.length-1)
                source: "qrc:/assets/Icon/Icon_Next.png"
            }
        }
    }
}
