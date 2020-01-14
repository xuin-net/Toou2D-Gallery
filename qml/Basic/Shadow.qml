import QtQuick 2.6
import "../controls" as Controls

Flickable {
    anchors.fill: parent;
    contentHeight: titleText.contentHeight + 60 + contentColumn.height

    Text {
        id: titleText;
        x: 20;
        text: qsTr("投影")
        font.pixelSize: 18
    }

    Column {
        id: contentColumn
        y: 60
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20

        Controls.TRectangularGlow {
            width: 300;
            height: 100
        }

        Text {
            text: qsTr("glowRadius: 40,spread: 0.2 (default)")
            font.pixelSize: 14
            color: "#909399"
        }

        Controls.TRectangularGlow {
            width: 300;
            height: 100
            glowRadius: 20
        }

        Text {
            text: qsTr("glowRadius: 20,spread: 0.2")
            font.pixelSize: 14
            color: "#909399"
        }

        Controls.TRectangularGlow {
            width: 300;
            height: 100
            glowRadius: 60
        }

        Text {
            text: qsTr("glowRadius: 60,spread: 0.2")
            font.pixelSize: 14
            color: "#909399"
        }

        Controls.TRectangularGlow {
            width: 300;
            height: 100
            glowRadius: 20
            spread: 0.1
        }

        Text {
            text: qsTr("glowRadius: 20,spread: 0.1")
            font.pixelSize: 14
            color: "#909399"
        }

        Controls.TRectangularGlow {
            width: 300;
            height: 100
            glowRadius: 60
            spread: 0.1
        }

        Text {
            text: qsTr("glowRadius: 60,spread: 0.1")
            font.pixelSize: 14
            color: "#909399"
        }
    }
}
