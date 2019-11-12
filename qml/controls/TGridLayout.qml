import QtQuick 2.6

Item {
    id: toou2d_gridlayout
    width: parent.width
    height: parent.height

    property real spacing: 10;
    property int  columnCount: 1;
    property int  lineMaxHeight: 0;

    function updateLayout(_childrens) {
        if (!_childrens)
            return;

        columnCount = 1;
        var maxHeight = 0;
        for (var i=0;i<_childrens.length;++i) {
            var curItem = _childrens[i];

            var targetX = (i == 0) ?
                        0 : (_childrens[i-1].x + _childrens[i-1].width + toou2d_gridlayout.spacing)
            console.log("目标布局",(targetX + curItem.width + toou2d_gridlayout.spacing),toou2d_gridlayout.width);
            if((targetX + curItem.width + toou2d_gridlayout.spacing) > toou2d_gridlayout.width){
                columnCount++;
                lineMaxHeight = maxHeight;
                maxHeight = 0;
                targetX = 0;
            }
            maxHeight = Math.max(maxHeight,curItem.height);
            console.log("最大高度",maxHeight);
            curItem.x = targetX;
            curItem.y = (spacing + lineMaxHeight) * (columnCount - 1);
        }
    }

    Component.onCompleted: {
        updateLayout(toou2d_gridlayout.children);
        toou2d_gridlayout.childrenChanged.connect(updateLayout);
    }
}
