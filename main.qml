import QtQuick 2.6
//import QtQuick.Controls 2.5
import QtQuick.Window 2.2
import "./qmlList.js" as QMLList

Window {
    id: windows
    visible: true
    width: 1136
    height: 640
    title: qsTr("Toou2D-Gallery")

    signal reStartApp();

    Shortcut {
        sequence: "F5"
        onActivated: windows.reStartApp()
    }

    ListView {
        id: listView
        width: 240;height: parent.height;

        currentIndex: -1;

        model: controlModel;
        delegate: delegateCom;

        section.property: "type"
        section.delegate: sectionDelegateCom;

        Rectangle {
            anchors.right: parent.right
            width: 1;
            height: listView.height;
            color: "#4d4d4d";
        }
    }

    Loader {
        id: contentLoader;
        anchors.left: listView.right;
        anchors.right: parent.right;
        height: parent.height
    }

    ListModel {
        id: controlModel
    }

    Text {
        text: qsTr("Coming soon!")
        font.pixelSize: 28
        anchors.centerIn: contentLoader;
        visible: contentLoader.status == Loader.Ready ? false : true
    }

    Component {
        id: sectionDelegateCom;
        Item {
            width: 240;height: 40;
            Text {
                text: section;
                leftPadding: 10
                anchors.fill: parent;
                verticalAlignment: Text.AlignBottom
                font.pixelSize: 12
                color: "#999999"
            }
        }
    }

    Component {
        id: delegateCom;
        MouseArea {
            id: mouseArea;
            hoverEnabled: true;
            width: 240;height: 40;
            Text {
                text: title
                leftPadding: 10
                anchors.fill: parent;
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
                color: (mouseArea.ListView.isCurrentItem || mouseArea.containsMouse) ? "#409EFF" : "#303133"
            }

            onClicked: {
                windows.switchToQML(qml, title, index);
            }
        }
    }

    Component.onCompleted: {
        windows.initListData();
    }

    /*##############Funtion################*/
    function switchToQML(_src, _title, _index) {
        contentLoader.source = _src;
        listView.currentIndex = _index;
        windows.title = _title;
    }

    function initListData() {
        for (var i=0;i<QMLList.list.length;++i) {
            var type = QMLList.list[i].name;
            var elements = QMLList.list[i].element;
            for (var j=0;j<elements.length;++j) {
                controlModel.append({qml: elements[j].qml,title: elements[j].title,type: type});
            }
        }
    }
    /*##############Funtion################*/
}
