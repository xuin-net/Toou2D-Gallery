/****************************************************************************
**
** Copyright (C) 2019 The TOOU Company Ltd.
** Contact: http://www.toou.net/licensing/
**
** This file is part of the examples of the Qt Toolkit.
** This file is part of the Toou 2d module of the Toou-2D Toolkit.
**
** $TOOU_BEGIN_LICENSE:MIT$
**
** Permission is hereby granted, free of charge, to any person obtaining a copy
** of this software and associated documentation files (the "Software"), to deal
** in the Software without restriction, including without limitation the rights
** to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
** copies of the Software, and to permit persons to whom the Software is
** furnished to do so, subject to the following conditions:
**
** The above copyright notice and this permission notice shall be included in all
** copies or substantial portions of the Software.
**
** THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
** IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
** FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
** AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
** LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
** OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
** SOFTWARE.
**
** $TOOU_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.6

Item {
    id: toou2d_gridlayout
    width: parent.width
    height: childrenRect.height

    property real rowSpacing: 10;

    property real columnSpacing: 10;

    property int  columns: 1;

    // Grid.AlignTop/Grid.AlignVCenter/Grid.AlignBottom
    property int  verticalItemAlignment: Grid.AlignTop

    function updateLayout() {
        if (!toou2d_gridlayout)
            return;
        var childrens = toou2d_gridlayout.children;
        var datas = toou2d_gridlayout.data;

        columns = 1;
        var rowMaxHeight = 0;
        var lineMaxHeight = 0;
        var lineIndexArr = [];
        for (var i=0;i<childrens.length;++i) {
            var curItem = childrens[i];

            var targetX = (i == 0) ?
                        0 : (childrens[i-1].x + childrens[i-1].width
                             + (curItem.width > 0 ? toou2d_gridlayout.rowSpacing : 0))
            if((targetX + curItem.width + toou2d_gridlayout.rowSpacing) > toou2d_gridlayout.width){
                // new line
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
    }

    Component.onCompleted: {
        updateLayout();
        toou2d_gridlayout.childrenChanged.connect(updateLayout);
    }

    Component.onDestruction: {
        toou2d_gridlayout.childrenChanged.disconnect(updateLayout);
    }
}
