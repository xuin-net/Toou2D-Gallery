import QtQuick 2.6
import "../controls" as Controls
import "../Common"

Flickable {
    anchors.fill: parent;
    contentHeight: contentColumn.implicitHeight + 30

    Column {
        id: contentColumn
        width: parent.width
        spacing: 30
        Text {
            text: qsTr("混和布局")
            leftPadding: 20;
            topPadding: 20;
            color: "#303133"
        }
        Controls.TGridLayout {
            anchors.horizontalCenter: parent.horizontalCenter;
            width: parent.width - 80
            Repeater {
                model: 10;
                delegate: Rectangle {
                    width: 100 + Math.floor(Math.random() * 200)
                    height: 30;
                    radius: 4
                    color: index % 2 == 0 ? "#957bbe" : "#80bdff"
                }
            }
        }

        Text {
            text: qsTr("混和布局-顶部对齐（默认）")
            leftPadding: 20;
            topPadding: 20;
            color: "#303133"
        }
        Controls.TGridLayout {
            anchors.horizontalCenter: parent.horizontalCenter;
            width: parent.width - 80

            Repeater {
                model: 10;
                delegate: Rectangle {
                    width: 100 + Math.floor(Math.random() * 200)
                    height: 30 + Math.floor(Math.random() * 30);
                    radius: 4
                    color: index % 2 == 0 ? "#957bbe" : "#80bdff"
                }
            }
        }

        Text {
            text: qsTr("混和布局-中部对齐")
            leftPadding: 20;
            topPadding: 20;
            color: "#303133"
        }
        Controls.TGridLayout {
            anchors.horizontalCenter: parent.horizontalCenter;
            width: parent.width - 80

            verticalItemAlignment: Grid.AlignVCenter
            Repeater {
                model: 10;
                delegate: Rectangle {
                    width: 100 + Math.floor(Math.random() * 200)
                    height: 30 + Math.floor(Math.random() * 30);
                    radius: 4
                    color: index % 2 == 0 ? "#957bbe" : "#80bdff"
                }
            }
        }

        Text {
            text: qsTr("混和布局-底部对齐")
            leftPadding: 20;
            topPadding: 20;
            color: "#303133"
        }
        Controls.TGridLayout {
            anchors.horizontalCenter: parent.horizontalCenter;
            width: parent.width - 80

            verticalItemAlignment: Grid.AlignBottom
            Repeater {
                model: 10;
                delegate: Rectangle {
                    width: 100 + Math.floor(Math.random() * 200)
                    height: 30 + Math.floor(Math.random() * 30);
                    radius: 4
                    color: index % 2 == 0 ? "#957bbe" : "#80bdff"
                }
            }
        }
    }

}
