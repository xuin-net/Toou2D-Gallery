import QtQuick 2.12
import QtQuick.Layouts 1.12

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

        Item {
            Layout.preferredWidth: 64
            height: previouBtn.height

            LImageButton {
                id: previouBtn
                mouseAreaWidth: 64
                Layout.preferredWidth: 14
                checkable: curIndex!=1;
                imgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Icon_Previous_01.png"
                checkImgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Pressed/Icon_Previous_Pressed_01.png"
                onClicked: {
                    previouBtn.focus = true;
                    lastPage();
                }
            }
        }

        LPageText {
            id: firstDigital
            Layout.preferredWidth: 64
            visible: num > 0 ? true : false;
            text: String(num)
            num: {
                factorChange;
                return pageArr.length > 0 ? pageArr[0].digital : 0;
            }
            color: (pressed || pageIndex == num) ? "#00BFB5" : "#848484"

            onClicked: {
                curIndex = num;
            }
        }

        Item {
            Layout.preferredWidth: groupBtn.visible ? 64 : 0
            height: groupBtn.height

            LImageButton {
                id: groupBtn
                mouseAreaWidth: 64
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
                imgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Icon_more_02.png"
                checkImgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Pressed/Icon_Previous_Pressing_01.png"
                onClicked: {
                    lastPageGroup();
                }
            }
        }

        ListView {
            id: numList
            spacing: 14
            Layout.preferredHeight: contentHeight;
            Layout.preferredWidth: contentWidth
            interactive: false;
            orientation: ListView.Horizontal
            model: displayModel

            delegate: LPageText {
                id: pageTextDelegate
                text: String(digital)
                num: digital;
                width: 64
                anchors.verticalCenter: parent.verticalCenter
                color: (pressed || pageIndex == digital) ? "#00BFB5" : "#848484"
                onClicked: {
                    numList.focus = true;
                    curIndex = num;
                }
            }
        }

        Item {
            Layout.preferredWidth: nextGroupBtn.visible ? 64 : 0
            height: nextGroupBtn.height

            LImageButton {
                id: nextGroupBtn
                mouseAreaWidth: 64
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
                imgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Icon_more_02.png"
                checkImgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Pressed/Icon_Previous_Pressing_02.png"
                onClicked: {
                    nextPageGroup();
                }
            }
        }

        LPageText {
            id: lastDigital
            visible: num > 0 ? true : false;
            Layout.preferredWidth: 64
            textWidth: contentWidth + 2;
            text: String(num);
            horizontalAlignment: Text.AlignRight
            num: {
                factorChange;
                return pageArr.length > 1 ? pageArr[pageArr.length-1].digital : 0;
            }
            color: (pressed || pageIndex == num) ? "#00BFB5" : "#848484"

            onClicked: {
                curIndex = num;
            }
        }

        Item {
            Layout.preferredWidth: 64
            height: nextBtn.height

            LImageButton {
                id: nextBtn;
                mouseAreaWidth: 64
                Layout.preferredWidth: 14
                checkable: curIndex!=pageArr.length;
                rotation: 180
                imgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Icon_Previous_01.png"
                checkImgSrc: "qrc:/com.aiyunji.lpm.res/resource/Icon/Pressed/Icon_Previous_Pressed_01.png"

                onClicked: {
                    nextBtn.focus = true;
                    nextPage();
                }
            }
        }

        Text {
            text: qsTr("前往")
            Layout.preferredWidth: 43
            font.pixelSize: 18
            color: "#848484"
        }

        LTextEdit {
            id: pageEdit;
            Layout.preferredHeight: 26
            Layout.preferredWidth: 37
            leftPadding: 8
            bottomPadding: 3
            font.pixelSize: 14
            verticalAlignment: TextInput.AlignBottom
            horizontalAlignment: TextInput.AlignHCenter
            validator: IntValidator{bottom: 1; top: 999;}
            inputMethodHints: Qt.ImhDigitsOnly

            onTextChanged: {
                seekPage(text);
            }

            onFocusChanged: {
                if (focus == false && pageEdit.text == "") {
                    pageEdit.text = String(curIndex)
                }
            }
        }

        Text {
            text: qsTr("页")
            font.pixelSize: 18
            color: "#848484"
        }
    }

    ListModel {
        id: displayModel;
    }

    onPageIndexChanged: {
        pageEdit.text = String(curIndex)
    }

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
                if ((displayModel.count > 0 && displayModel.get(displayModel.count - 1).digital == (curIndex - 1))
                        /*|| displayModel.count == 0*/) {
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
