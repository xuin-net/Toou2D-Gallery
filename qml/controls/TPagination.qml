/****************************************************************************
**
** Copyright (C) 2020 The TOOU Company Ltd.
** Contact: http://www.toou.net/licensing/
**
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
import QtQuick.Layouts 1.0
import Toou2D 1.0

Item {
    id: pagination;

    property int current;

    property int defaultCurrent: 1;

    property int defaultPageSize: 10;

    property int pageSize;

    property bool disabled: false;

    property bool hideOnSinglePage: false;

    //itemRender
    property var pageSizeOptions: ["10", "20", "30", "40"];

    property bool showLessItems: false;

    property bool showQuickJumper: false;

    property bool showSizeChanger: false;

    property bool simple: false;

    property string size: "";

    property int total: 0

    function showTotal(total, range) {

    }

    signal changed(int page, int pageSize);
    signal showSizeChanged(int current, int size);

//    current	当前页数	number	-
//    defaultCurrent	默认的当前页数	number	1
//    defaultPageSize	默认的每页条数	number	10
//    disabled	禁用分页	boolean	-
//    hideOnSinglePage	只有一页时是否隐藏分页器	boolean	false
//    itemRender	用于自定义页码的结构，可用于优化 SEO	(page, type: 'page' | 'prev' | 'next', originalElement) => React.ReactNode	-
//    pageSize	每页条数	number	-
//    pageSizeOptions	指定每页可以显示多少条	string[]	['10', '20', '30', '40']
//    showLessItems	是否显示较少页面内容	boolean	false
//    showQuickJumper	是否可以快速跳转至某页	boolean | { goButton: ReactNode }	false
//    showSizeChanger	是否可以改变 pageSize	boolean	false
//    showTotal	用于显示数据总量和当前数据顺序	Function(total, range)	-
//    simple	当添加该属性时，显示为简单分页	boolean	-
//    size	当为「small」时，是小尺寸分页	string	""
//    total	数据总数	number	0
//    onChange	页码改变的回调，参数是改变后的页码及每页条数	Function(page, pageSize)	noop
//    onShowSizeChange	pageSize 变化的回调	Function(current, size)	noop

    onTotalChanged: initData();

    onPageSizeChanged: initData();

    function initData() {
//        contentRow.pageCount = Math.floor(total/pageSize);
//        var m_numCount = contentRow.pageCount - 2 > 0
//                ? (contentRow.pageCount - 2) : 0
//        contentRow.numArr = []
//        for(var i=0;i<m_numCount;++i) {
//            contentRow.numArr.push(i+2);
//        }
    }

    Row {
        id: contentRow
        spacing: 8;

        property var model: [
            {type: "LastPage"},
            {type: "Num",page: 1},
            {type: "Num",page: 2},
            {type: "Num",page: 3},
            {type: "NextPage"}
        ];
        property var pageCount: 0;

        Repeater {
            model: contentRow.model;
            delegate: TMouseArea {
                width: (text.contentWidth + 16 > 32) ? text.contentWidth + 16 : 32;
                height: 32

                Rectangle {
                    anchors.fill: parent;
                    radius: 2;
                    border.color: parent.pressed ? "#1890FF": Qt.rgba(0, 0, 0, 0.15)
                    color: parent.pressed ? "#1890FF" : "#FFFFFF"
                }

                Text {
                    id: text;
                    anchors.fill: parent;
                    visible: text != ""
                    text: modelData.page ? String(modelData.page) : "";
                    font.pixelSize: 14;
                    color: parent.pressed ? "#FFFFFF" : Qt.rgba(0, 0, 0, 0.65)
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                TAwesomeIcon {
                    visible: source != ""
                    anchors.centerIn: parent;

                    source: modelData.type == "LastPage" ?
                                TAwesomeType.FA_angle_left
                              : (modelData.type == "NextPage" ? TAwesomeType.FA_angle_right : "")
                    color: parent.selected ? "#FFFFFF" : Qt.rgba(0, 0, 0, 0.65)
                }
                onClicked: {
                    //current = index;
                }
            }
        }
    }

    ListModel {
        id: displayModel
    }

    Component.onCompleted: {
        pagination.current = defaultCurrent;
    }

//    onCurrentChanged: {
//        updatePage();
//    }

    function updatePage() {
        if (contentRow.numArr.length > 0) {
            var i=0
            var count = 0

            pagination.changed(current,pageSize);
            if (current == 1) {
                if (displayModel.count > 0)
                if (displayModel.count > 0 && displayModel.get(0).digital == 2) {
                    return;
                }
                count = 0
                displayModel.clear()
                if (contentRow.numArr.length > 8) {
                    count = 6;
                } else {
                    count = contentRow.numArr.length - 1;
                }
                for (i=0;i<count;++i) {
                    displayModel.append({digital: contentRow.numArr[i]})
                }
            } else if (current == contentRow.numArr.length) {
                if ((displayModel.count > 0 && displayModel.get(displayModel.count - 1).digital == (current - 1)) || displayModel.count == 0) {
                    return;
                }
                count = 0
                displayModel.clear()
                if (contentRow.numArr.length > 8) {
                    count = 5;
                } else {
                    count = contentRow.numArr.length - 2;
                }
                var totalCount = contentRow.numArr.length - 1
                for (i=totalCount-count;i<totalCount;++i) {
                    displayModel.append({digital: contentRow.numArr[i]})
                }
            } else {
                for (i=0;i<displayModel.count;++i) {
                    if (displayModel.get(i).digital == current) {
                        return;
                    }
                }
                if (displayModel.count > 0) {
                    var firstDigital = displayModel.get(0).digital;
                    var lastDigital =  displayModel.get(displayModel.count-1).digital
                    if (current < firstDigital && current > (firstDigital - 5)) {
                        lastPageGroup(true);
                    } else if (current > lastDigital && current < (lastDigital + 5)) {
                        nextPageGroup(true);
                    } else {
                        seekPageGroup(current);
                    }
                }
            }
        }
    }

    function lastPageGroup(_noAutoSetIndex) {
        if (displayModel.count > 0) {
            var firstDigital = displayModel.get(0).digital;
            if (firstDigital > 2) {
                displayModel.clear();
                var firstValue = firstDigital-5
                if (firstValue<2)
                    firstValue = 2
                for (var i=0;i<5;++i) {
                    displayModel.append({digital: contentRow.numArr[i+firstValue-1]})
                }
                if (!_noAutoSetIndex)
                    current = firstValue + 2
            }
        }
    }

    function nextPageGroup(_noAutoSetIndex) {
        if (displayModel.count > 0) {
            var lastDigital = displayModel.get(displayModel.count-1).digital;
            if (lastDigital < contentRow.numArr.length-1) {
                displayModel.clear();
                var lastValue = lastDigital+5
                if (lastValue>contentRow.numArr.length-1)
                    lastValue = contentRow.numArr.length-1
                for (var i=5;i>0;--i) {
                    displayModel.append({digital: contentRow.numArr[lastValue-i]})
                }
                if (!_noAutoSetIndex)
                    current = lastValue - 2
            }
        }
    }

    function seekPageGroup(_targetIndex) {
        if (displayModel.count > 0) {
            var targetFirstDigital = _targetIndex - 2
            var targetLastDigital = _targetIndex + 2

            if (targetFirstDigital < 2) {
                targetFirstDigital = 2;
            } else if (targetLastDigital > contentRow.numArr.length-1) {
                targetFirstDigital -= (targetLastDigital-contentRow.numArr.length+1)
            }

            displayModel.clear()

            for (var i=0;i<5;++i) {
                displayModel.append({digital: contentRow.numArr[targetFirstDigital+i-1]})
            }
        }
    }

    function lastPage() {
        if (current > 1)
            current--;
    }

    function nextPage() {
        if (current < contentRow.numArr.length)
            current++;
    }

    function seekPage(_text) {
        if (_text!="") {
            var targetPage = Number(_text)
            if (targetPage > contentRow.numArr.length) {
                targetPage = contentRow.numArr.length;
            } else if (targetPage == 0) {
                targetPage = 1;
            }
            pageEdit.text = String(targetPage)
            if (targetPage != current)
                current = targetPage;
        }
    }

    function init(_count,_index) {
        reset();
        displayModel.clear()
        for (var i=0;i<_count;++i) {
            var value = {digital: (i+1)}
            contentRow.numArr.push(value);
        }
        factorChange++;
        current = _index
    }

    function add() {
        var value = {digital: contentRow.numArr.length+1}
        contentRow.numArr.push(value);
        factorChange ++;
        current = contentRow.numArr.length
    }

    function reduce(_noUpdateIndex) {
        contentRow.numArr.pop()
        factorChange ++;
        if (!_noUpdateIndex) {
            current = contentRow.numArr.length
        } else {
            if (displayModel.count > 0) {
                var lastDigital = displayModel.get(displayModel.count-1).digital
                if (lastDigital == contentRow.numArr.length) {
                    displayModel.remove(displayModel.count-1)
                    if (displayModel.count > 0 && displayModel.get(0).digital != 2) {
                        displayModel.insert(0, contentRow.numArr[displayModel.get(0).digital-2])
                    }
                }
            }
        }
    }

    function pageCount() {
        return contentRow.numArr.length;
    }

    function reset() {
        contentRow.numArr = []
        current = 0;
        itemCount = 0
        pageIndex = 0;
    }
}
