import QtQuick 2.6
import Toou2D 1.0
import Toou_QML_Tools 1.0

Flickable {
    anchors.fill: parent;

    LClipboard {
        id: clipboard
    }

    GridView {
        id:gview
        clip: true;
        width: parent.width
        height: 640

        cellWidth: 112;
        cellHeight: 60

        model: T2D.awesomelist();

        delegate: TMouseArea {
            clip: true;
            width: 110;
            height: 60;
            TAwesomeIcon {
                source: modelData;
                width: 20;
                height: 20;
                anchors.centerIn: parent;
            }

            TLabel {
                text: modelData;
                font.pixelSize: 10;
                anchors.bottom: parent.bottom;
                anchors.horizontalCenter: parent.horizontalCenter;
                onContentWidthChanged: {
                    if(contentWidth > parent.width){
                        text = text.slice(0,10) + "..";
                    }
                }
            }

            onClicked: {
                clipboard.setText(modelData);
            }
        }
    }
}
