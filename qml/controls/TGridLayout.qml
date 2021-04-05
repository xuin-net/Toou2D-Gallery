import QtQuick 2.6

Item {
    id: lGridlayout
    width: parent.width
    height: childrenRect.height

    property real rowSpacing: 10;

    property real columnSpacing: 10;

    property int  columns: 1;

    property int  offsetX: 0

    // Grid.AlignTop/Grid.AlignVCenter/Grid.AlignBottom
    property int  verticalItemAlignment: Grid.AlignTop

    // Grid.AlignLeft/Grid.AlignHCenter/Grid.AlignRight
    property int  horizontalItemAlignment: Grid.AlignLeft

    function updateLayout() {
        if (!lGridlayout)
            return;
        var childrens = lGridlayout.children;
        var datas = lGridlayout.data;

        columns = 1;
        var rowMaxHeight = 0;
        var lineMaxHeight = 0;
        var lineIndexArr = [];
        for (var i=0;i<childrens.length;++i) {
            var curItem = childrens[i];

            var targetX = (i == 0) ?
                        offsetX : (childrens[i-1].x + childrens[i-1].width
                             + (curItem.width > 0 ? lGridlayout.rowSpacing : 0))
            if((targetX + curItem.width + lGridlayout.rowSpacing) > lGridlayout.width){
                // new line
                offsetLine(lineIndexArr);
                lineMaxHeight += rowMaxHeight + columnSpacing;
                columns++;
                rowMaxHeight = 0;
                targetX = 0;
                lineIndexArr = [];
            }

            curItem.x = targetX;
            curItem.y = lineMaxHeight;

            var newRowMaxHeight = Math.max(rowMaxHeight,curItem.height);
            if (verticalItemAlignment != Grid.AlignTop) {
                curItem.y += verticalItemAlignment == Grid.AlignVCenter
                        ? (newRowMaxHeight - curItem.height)/2
                        : (verticalItemAlignment == Grid.AlignBottom
                           ? newRowMaxHeight - curItem.height : 0)
            }

            // realign when newRowMaxHeight not equal rowMaxHeight
            if (newRowMaxHeight != rowMaxHeight) {
                rowMaxHeight = newRowMaxHeight;
                if (verticalItemAlignment != Grid.AlignTop) {
                    for (var j=0;j<lineIndexArr.length;++j) {
                        var itemAtLastLine = childrens[lineIndexArr[j]];
                        itemAtLastLine.y = lineMaxHeight
                                + (verticalItemAlignment == Grid.AlignVCenter
                                ? (rowMaxHeight - itemAtLastLine.height)/2
                                : (verticalItemAlignment == Grid.AlignBottom
                                   ? rowMaxHeight - itemAtLastLine.height : 0))
                    }
                }
            }
            lineIndexArr.push(i);
        }
        offsetLine(lineIndexArr)
    }

    function offsetLine(lineIndexArr) {
        if (horizontalItemAlignment != Grid.AlignLeft) {
            var childrens = lGridlayout.children;
            var lineOffsetX = 0;
            var lastLineItem = childrens[lineIndexArr[lineIndexArr.length - 1]]
            lineOffsetX = lGridlayout.width - (lastLineItem.x + lastLineItem.width);
            if (horizontalItemAlignment == Grid.AlignHCenter) {
                lineOffsetX /= 2;
            }
            for (var j=0;j<lineIndexArr.length;++j) {
                var itemAtLastLine = childrens[lineIndexArr[j]];
                itemAtLastLine.x += lineOffsetX
            }
        }
    }

    Component.onCompleted: {
        updateLayout();
        lGridlayout.childrenChanged.connect(updateLayout);
    }

    Component.onDestruction: {
        lGridlayout.childrenChanged.disconnect(updateLayout);
    }
}
