import QtQuick 2.6
import Toou2D 1.0
import "../controls" as Controls

Flickable {
    anchors.fill: parent;
    contentHeight: contentColumn.implicitHeight

    Column {
        id: contentColumn
        width: parent.width
        spacing: 30

        Controls.TPagination {
            id: pagination;

            onPageChange: {
                pagination.pageIndex = page
            }
        }
    }

    TPagination {

    }

    Component.onCompleted: {
        pagination.init(20,1)
    }
}
