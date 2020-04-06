import QtQuick 2.6
import Toou2D 1.0
import "../controls" as Controls
import "../Common"

Flickable {
    anchors.fill: parent;
    // contentHeight: contentColumn.implicitHeight

    Controls.TPagination {
        total: 60;
        pageSize: 6;
    }
}
