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
    property var pageArr: []
    property int curIndex: 0;
    property int itemCount: 0
    property int pageIndex: 0;
    property int factorChange: -1;
    width: contentRow.width

    signal pageChange(int page)

    RowLayout {
        id: contentRow;
        spacing: 10
//        LImageButton {
//            id: previouBtn
//            Layout.preferredWidth: 14
//            checkable: curIndex!=1;
//            imgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Icon_Previous_01.png"
//            checkImgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Pressed/Icon_Previous_Pressed_01.png"

//            onClicked: {
//                previouBtn.focus = true;
//                lastPage();
//            }
//        }

        TMouseArea {
            id: previouBtn
            width: 25;
            height: 25;
            TAwesomeIcon {
                width: 25;
                height: 25;
                source: TAwesomeType.FA_angle_double_left;
            }
            onClicked: {
                previouBtn.focus = true;
                lastPage();
            }
        }

//        LPageText {
//            id: firstDigital
//            Layout.preferredWidth: contentWidth + 2;
//            visible: num > 0 ? true : false;
//            text: String(num)
//            num: {
//                factorChange;
//                return pageArr.length > 0 ? pageArr[0].digital : 0;
//            }
//            color: (pressed || pageIndex == num) ? "#00BFB5" : "#848484"

//            onClicked: {
//                curIndex = num;
//            }
//        }

        TMouseArea {
            id: firstDigital
            Layout.preferredWidth: contentWidth + 2;
            visible: num > 0 ? true : false;
            property var num: {
                factorChange;
                return pageArr.length > 0 ? pageArr[0].digital : 0;
            }

            Text {
                width: contentWidth
                height: contentHeight
                font.pixelSize: 18
                text: String(firstDigital.num);
                horizontalAlignment: Text.AlignRight
                color: (firstDigital.checked || pageIndex == firstDigital.num) ? "#00BFB5" : "#848484"
            }
            onClicked: {
                curIndex = num;
            }
        }

        TMouseArea {
            visible: {
                if (displayModel.count > 0) {
                    if(displayModel.get(0).digital-1 != firstDigital.num) {
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            }
            width: 25;
            height: 25;
            TAwesomeIcon {
                width: 25;
                height: 25;
                source: TAwesomeType.FA_angle_left;
            }
            onClicked: {
                lastPageGroup();
            }
        }
//        LImageButton {
//            visible: {
//                if (displayModel.count > 0) {
//                    if(displayModel.get(0).digital-1 != firstDigital.num) {
//                        return true;
//                    } else {
//                        return false;
//                    }
//                } else {
//                    return false;
//                }
//            }
//            imgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Icon_more_02.png"
//            checkImgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Pressed/Icon_Previous_Pressing_01.png"
//            onClicked: {
//                lastPageGroup();
//            }
//        }

        ListView {
            id: numList
            spacing: 14
            Layout.preferredHeight: contentHeight;
            Layout.preferredWidth: contentWidth
            interactive: false;
            orientation: ListView.Horizontal
            model: displayModel

//            delegate: LPageText {
//                id: pageTextDelegate
//                text: String(digital)
//                num: digital;
//                anchors.verticalCenter: parent.verticalCenter
//                color: (pressed || pageIndex == digital) ? "#00BFB5" : "#848484"
//                onClicked: {
//                    numList.focus = true;
//                    curIndex = num;
//                }
//            }
            delegate: TMouseArea {
                id: pageTextDelegate
                anchors.verticalCenter: parent.verticalCenter
                property var num: digital;

                Text {
                    width: contentWidth
                    height: contentHeight
                    font.pixelSize: 18
                    text: String(digital);
                    horizontalAlignment: Text.AlignRight
                    color: (pageTextDelegate.checked || pageIndex == digital) ? "#00BFB5" : "#848484"
                }
                onClicked: {
                    numList.focus = true;
                    curIndex = num;
                }
            }
        }

        TMouseArea {
            visible: {
                if (displayModel.count > 0) {
                    if(displayModel.get(displayModel.count-1).digital+1 != lastDigital.num) {
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            }
            width: 25;
            height: 25;
            TAwesomeIcon {
                width: 25;
                height: 25;
                source: TAwesomeType.FA_angle_double_right;
            }
            onClicked: {
                nextPageGroup();
            }
        }

//        LImageButton {
//            visible: {
//                if (displayModel.count > 0) {
//                    if(displayModel.get(displayModel.count-1).digital+1 != lastDigital.num) {
//                        return true;
//                    } else {
//                        return false;
//                    }
//                } else {
//                    return false;
//                }
//            }
//            imgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Icon_more_02.png"
//            checkImgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Pressed/Icon_Previous_Pressing_02.png"
//            onClicked: {
//                nextPageGroup();
//            }
//        }

//        LPageText {
//            id: lastDigital
//            visible: num > 0 ? true : false;
//            Layout.preferredWidth: contentWidth + 2;
//            textWidth: contentWidth + 2;
//            text: String(num);
//            horizontalAlignment: Text.AlignRight
//            num: {
//                factorChange;
//                return pageArr.length > 1 ? pageArr[pageArr.length-1].digital : 0;
//            }
//            color: (pressed || pageIndex == num) ? "#00BFB5" : "#848484"

//            onClicked: {
//                curIndex = num;
//            }
//        }
        TMouseArea {
            id: lastDigital
            visible: num > 0 ? true : false;
            Layout.preferredWidth: contentWidth + 2;

            Text {
                width: contentWidth + 2
                height: contentHeight
                font.pixelSize: 18
                text: String(lastDigital.num);
                horizontalAlignment: Text.AlignRight
                color: (lastDigital.checked || pageIndex == firstDigital.num) ? "#00BFB5" : "#848484"
            }
            property var num: {
                factorChange;
                return pageArr.length > 1 ? pageArr[pageArr.length-1].digital : 0;
            }

            onClicked: {
                curIndex = num;
            }
        }

//        LImageButton {
//            id: nextBtn;
//            Layout.preferredWidth: 14
//            checkable: curIndex!=pageArr.length;
//            rotation: 180
//            imgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Icon_Previous_01.png"
//            checkImgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Pressed/Icon_Previous_Pressed_01.png"

//            onClicked: {
//                nextBtn.focus = true;
//                nextPage();
//            }
//        }

        TMouseArea {
            id: nextBtn;
            width: 25;
            height: 25;
            TAwesomeIcon {
                width: 25;
                height: 25;
                source: TAwesomeType.FA_angle_right;
            }
            onClicked: {
                nextBtn.focus = true;
                nextPage();
            }
        }

        Text {
            text: qsTr("前往")
            Layout.preferredWidth: 43
            font.pixelSize: 18
            color: "#848484"
        }

//        LTextEdit {
//            id: pageEdit;
//            Layout.preferredHeight: 26
//            Layout.preferredWidth: 37
//            leftPadding: 8
//            bottomPadding: 3
//            font.pixelSize: 14
//            verticalAlignment: TextInput.AlignBottom
//            horizontalAlignment: TextInput.AlignHCenter
//            validator: IntValidator{bottom: 1; top: 999;}
//            inputMethodHints: Qt.ImhDigitsOnly

//            onTextChanged: {
//                seekPage(text);
//            }

//            onFocusChanged: {
//                if (focus == false && pageEdit.text == "") {
//                    pageEdit.text = String(curIndex)
//                }
//            }
//        }

        Text {
            text: qsTr("页")
            font.pixelSize: 18
            color: "#848484"
        }
    }

    ListModel {
        id: displayModel;
    }

//    onPageIndexChanged: {
//        pageEdit.text = String(curIndex)
//    }

    onCurIndexChanged: {
        updatePage();
    }

    function updatePage() {
        if (pageArr.length > 0) {
            var i=0
            var count = 0

            pagination.pageChange(curIndex);
            if (curIndex == 1) {
                if (displayModel.count > 0)
                if (displayModel.count > 0 && displayModel.get(0).digital == 2) {
                    return;
                }
                count = 0
                displayModel.clear()
                if (pageArr.length > 8) {
                    count = 6;
                } else {
                    count = pageArr.length - 1;
                }
                for (i=1;i<count;++i) {
                    displayModel.append(pageArr[i])
                }
            } else if (curIndex == pageArr.length) {
                if ((displayModel.count > 0 && displayModel.get(displayModel.count - 1).digital == (curIndex - 1)) || displayModel.count == 0) {
                    return;
                }
                count = 0
                displayModel.clear()
                if (pageArr.length > 8) {
                    count = 5;
                } else {
                    count = pageArr.length - 2;
                }
                var totalCount = pageArr.length - 1
                for (i=totalCount-count;i<totalCount;++i) {
                    displayModel.append(pageArr[i])
                }
            } else {
                for (i=0;i<displayModel.count;++i) {
                    if (displayModel.get(i).digital == curIndex) {
                        return;
                    }
                }
                if (displayModel.count > 0) {
                    var firstDigital = displayModel.get(0).digital;
                    var lastDigital =  displayModel.get(displayModel.count-1).digital
                    if (curIndex < firstDigital && curIndex > (firstDigital - 5)) {
                        lastPageGroup(true);
                    } else if (curIndex > lastDigital && curIndex < (lastDigital + 5)) {
                        nextPageGroup(true);
                    } else {
                        seekPageGroup(curIndex);
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
                    displayModel.append(pageArr[i+firstValue-1])
                }
                if (!_noAutoSetIndex)
                    curIndex = firstValue + 2
            }
        }
    }

    function nextPageGroup(_noAutoSetIndex) {
        if (displayModel.count > 0) {
            var lastDigital = displayModel.get(displayModel.count-1).digital;
            if (lastDigital < pageArr.length-1) {
                displayModel.clear();
                var lastValue = lastDigital+5
                if (lastValue>pageArr.length-1)
                    lastValue = pageArr.length-1
                for (var i=5;i>0;--i) {
                    displayModel.append(pageArr[lastValue-i])
                }
                if (!_noAutoSetIndex)
                    curIndex = lastValue - 2
            }
        }
    }

    function seekPageGroup(_targetIndex) {
        if (displayModel.count > 0) {
            var targetFirstDigital = _targetIndex - 2
            var targetLastDigital = _targetIndex + 2

            if (targetFirstDigital < 2) {
                targetFirstDigital = 2;
            } else if (targetLastDigital > pageArr.length-1) {
                targetFirstDigital -= (targetLastDigital-pageArr.length+1)
            }

            displayModel.clear()

            for (var i=0;i<5;++i) {
                displayModel.append(pageArr[targetFirstDigital+i-1])
            }
        }
    }

    function lastPage() {
        if (curIndex > 1)
            curIndex--;
    }

    function nextPage() {
        if (curIndex < pageArr.length)
            curIndex++;
    }

    function seekPage(_text) {
        if (_text!="") {
            var targetPage = Number(_text)
            if (targetPage > pageArr.length) {
                targetPage = pageArr.length;
            } else if (targetPage == 0) {
                targetPage = 1;
            }
            pageEdit.text = String(targetPage)
            if (targetPage != curIndex)
                curIndex = targetPage;
        }
    }

    function init(_count,_index) {
        reset();
        for (var i=0;i<_count;++i) {
            var value = {digital: (i+1)}
            pageArr.push(value);
        }
        factorChange++;
        curIndex = _index
    }

    function add() {
        var value = {digital: pageArr.length+1}
        pageArr.push(value);
        factorChange ++;
        curIndex = pageArr.length
    }

    function reduce(_noUpdateIndex) {
        pageArr.pop()
        factorChange ++;
        if (!_noUpdateIndex) {
            curIndex = pageArr.length
        } else {
            if (displayModel.count > 0) {
                var lastDigital = displayModel.get(displayModel.count-1).digital
                if (lastDigital == pageArr.length) {
                    displayModel.remove(displayModel.count-1)
                    if (displayModel.count > 0 && displayModel.get(0).digital != 2) {
                        displayModel.insert(0, pageArr[displayModel.get(0).digital-2])
                    }
                }
            }
        }
    }

    function pageCount() {
        return pageArr.length;
    }

    function reset() {
        displayModel.clear()
        pageArr = []
        curIndex = 0;
        itemCount = 0
    }
}
