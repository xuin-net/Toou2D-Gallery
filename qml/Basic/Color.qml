import QtQuick 2.6

Flickable {
    anchors.fill: parent;
    contentHeight: contentColumn.implicitHeight

    Column {
        id: contentColumn
        width: parent.width
        spacing: 30
    }
}
