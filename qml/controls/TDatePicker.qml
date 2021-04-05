import QtQuick 2.6
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.0
import "../controls" as Controls

Controls.TPopup {
    id: popover
    property var contentRectObj: null;
    property real targetY: 0
    property var countDateInfo: ({});
    property int pageType: 0  // 0[defalut]/1[countSelect]

    readonly property int unitWidth: 64;

    // s_d eg:2021.04.4
    signal sendStartDate(string s_d);
    // s_d / e_d eg:2021.04.4
    // dateArr   eg:[[2021,4,5],[2021,4,6]]
    signal sendStartEndDate(string s_d, string e_d, var dateArr);

    onTriggeredBackground: {
        if (contentRectObj) {
            contentRectObj.setEndDate()
            closeBox()
        }
    }

    function openBox(_pos, _selectDateArr) {
        targetY = _pos.y
        checkObj(_selectDateArr);
        contentRectObj.x = _pos.x
        popover.open();
    }

    function closeBox() {
        reset();
        popover.close()
    }

    function updateModel(_arr) {
        popover.countDateInfo = {}
        for (var i=0; i<_arr.length; ++i) {
            for (var j=0; j<_arr[i].children.length; ++j) {
                popover.countDateInfo[
                            String(_arr[i].time)
                            + "%"
                            + String(_arr[i].children[j].time)
                        ] = _arr[i].children[j].children
            }
        }
    }

    function reset() {
        if (contentRectObj) {
            contentRectObj.destroy(1)
            popover.childitem=[];
            contentRectObj = null;
        }
    }

    function checkObj(_arr) {
        if (!contentRectObj) {
            contentRectObj = contentRectCom.createObject();
            if (_arr.length == 2) {
                contentRectObj.selectDateArr = _arr
            }
            var nowDate = new Date()
            contentRectObj.init((nowDate.getMonth() + 1), nowDate.getFullYear())
            popover.childitem.push(contentRectObj);
        }
    }

    function daysInMonth (month, year) {
        // Use 1 for January, 2 for February, etc.
        return new Date(year, month, 0).getDate();
    }

    function getDay (day, month, year) {
        // Use 1 for January, 2 for February, etc.
        return new Date(year, month - 1, day).getDay();
    }

    onOpened: {
        if (contentRectObj) {
            contentRectObj.opacity = 1.0
            contentRectObj.y = targetY;
        }
    }

    onHided: {
        if (contentRectObj) {
            contentRectObj.opacity = 0.0
            contentRectObj.y = targetY-12;
        }
    }

    onCloseed: {
        if (contentRectObj) {
            contentRectObj.opacity = 0.0
            contentRectObj.y = targetY-12;
        }
    }

    backgroundComponent:  Item{}

    Component {
        id: contentRectCom;
        MouseArea {
            id: contentItem
            y: targetY-12
            width: 504;height: groupDayObj ? (108 + groupDayObj.height + 30) : 423

            property var dayArr: []
            property var groupDayObj: null
            property int selectStep: 0
            property var selectDateArr: []

            RectangularGlow {
                y: 55
                anchors.horizontalCenter: contentRect.horizontalCenter
                width: contentRect.width - 86
                height: contentRect.height - glowRadius - glowRadius * spread
                glowRadius: 80
                spread: 0.1
                color: "#CFCFCF"
                cornerRadius: 0
            }

            Rectangle {
                id: contentRect;
                anchors.fill: parent
                radius : 12

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter;
                    y: 24
                    spacing: 235
                    Row {
                        spacing: 45;
                        Controls.TImageButton {
                            imgSrc: "qrc:/assets/Icon/Icon_calendar_previousyear.png"
                            uncheckImgSrc: "qrc:/assets/Icon/Icon_calendar_previousyear_disable.png"
                            checkable: selectDate.year != 1920 ? true : false
                            onClicked: {
                                contentItem.reduceYear()
                            }
                        }
                        Controls.TImageButton {
                            imgSrc: "qrc:/assets/Icon/Icon_calendar_previousmonth.png"
                            uncheckImgSrc: "qrc:/assets/Icon/Icon_calendar_previousmonth_disable.png"
                            checkable: selectDate.month != 1 ? true : false
                            onClicked: {
                                contentItem.reduceMonth()
                            }
                        }
                    }
                    Row {
                        spacing: 45;
                        Controls.TImageButton {
                            imgSrc: "qrc:/assets/Icon/Icon_calendar_nextmonth.png"
                            uncheckImgSrc: "qrc:/assets/Icon/Icon_calendar_nextmonth_disable.png"
                            checkable: selectDate.month != 12 ? true : false
                            onClicked: {
                                contentItem.addMonth()
                            }
                        }
                        Controls.TImageButton {
                            imgSrc: "qrc:/assets/Icon/Icon_calendar_nextyear.png"
                            uncheckImgSrc: "qrc:/assets/Icon/Icon_calendar_nextyear_disable.png"
                            checkable: selectDate.year != 2120 ? true : false
                            onClicked: {
                                contentItem.addYear()
                            }
                        }
                    }
                }

                Text {
                    id: selectDate
                    text: String(year) + qsTr("年 ") + String(month) + qsTr("月")
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: 20
                    color: "#606266"
                    y: 20
                    property int year: 2020
                    property int month: 6
                }

                Row {
                    y: 80
                    anchors.horizontalCenter: parent.horizontalCenter
                    Repeater {
                        model: [qsTr("日"),qsTr("一"),qsTr("二"),qsTr("三"),qsTr("四"),qsTr("五"),qsTr("六"),]
                        delegate: Text {
                            horizontalAlignment: Text.AlignHCenter
                            width: popover.unitWidth;height: 28
                            font.pixelSize: 18
                            color: "#C0C4CC"
                            text: modelData
                        }
                    }
                }
            }

            Behavior on opacity {
                NumberAnimation{duration: 200;easing.type: contentItem.opacity > 0 ? Easing.OutQuart : Easing.InOutQuart}
            }

            Behavior on y {
                NumberAnimation{duration: 200;easing.type: Easing.OutQuart}
            }

            Behavior on height {
                NumberAnimation{duration: 200;easing.type: Easing.OutQuart}
            }

            Timer {
                id: delayTimer;
                interval: 400
                onTriggered: {
                    closeBox()
                }
            }

            function addMonth() {
                selectDate.month ++;
                updateDayGroup();
            }

            function reduceMonth() {
                selectDate.month --;
                updateDayGroup();
            }

            function addYear() {
                selectDate.year ++;
                updateDayGroup();
            }

            function reduceYear() {
                selectDate.year --;
                updateDayGroup();
            }

            function updateDayGroup() {
                if (groupDayObj) {
                    groupDayObj.destroy(1)
                }
                groupDayObj = null;
                groupDayObj = dayGroupCom.createObject(contentItem)
                groupDayObj.offsetX = Qt.binding(function(){
                    return popover.getDay(1, selectDate.month, selectDate.year) * popover.unitWidth
                })
                var days = popover.daysInMonth(selectDate.month, selectDate.year)
                dayArr = []
                var defaultState = "idle";
                if (popover.pageType == 1) {
                    defaultState = "disable";
                }
                for (var i=0; i < days; ++i) {
                    dayArr.push({label: String(i+1), today: false, count: 0, state: defaultState})
                }
                var nowDate = new Date();
                if (selectDate.year == nowDate.getFullYear() && selectDate.month == nowDate.getMonth()+1) {
                    dayArr[nowDate.getDate()-1].today = true;
                }
                // search day info from date info
                var datesInfo = popover.countDateInfo[String(selectDate.year) + "%" + String(selectDate.month)]
                if (datesInfo) {
                    for (var j=0;j<datesInfo.length;++j) {
                        var curDateItem = dayArr[datesInfo[j].time-1]
                        curDateItem.count = datesInfo[j].count
                        curDateItem.state = "idle"
                    }
                }
                // check start check day item
                if (contentItem.selectStep > 0
                        && contentItem.selectDateArr.length > 0
                        && contentItem.selectDateArr[0][0] == selectDate.year
                        && contentItem.selectDateArr[0][1] == selectDate.month) {
                    dayArr[contentItem.selectDateArr[0][2]-1].state = "checked"
                }

                groupDayObj.daysModel = dayArr

                fillSelectDate()
            }

            function init(month, year) {
                selectDate.year = year;
                selectDate.month = month;
                updateDayGroup()
            }

            function fillSelectDate() {
                if (contentItem.selectDateArr.length == 2) {
                    var selectDateCount = selectDate.year * 10000 + selectDate.month
                    var s_start_count = contentItem.selectDateArr[0][0] * 10000 + contentItem.selectDateArr[0][1]
                    var s_end_count = contentItem.selectDateArr[1][0] * 10000 + contentItem.selectDateArr[1][1]
                    var startIndex = contentItem.selectDateArr[0][2]
                    var endIndex = contentItem.selectDateArr[1][2]
                    var i = 0;

                    if (selectDateCount > s_start_count
                            && selectDateCount < s_end_count) {
                        for (i=0; i<groupDayObj.daysModel.length; ++i) {
                            groupDayObj.fillBox(i, "middle")
                        }
                        return;
                    } else if (selectDateCount == s_start_count && s_start_count == s_end_count) {
                        if (startIndex != endIndex) {
                            groupDayObj.fillBox(startIndex-1, "start_checked")
                            groupDayObj.fillBox(endIndex-1, "end_checked")
                        } else {
                            groupDayObj.fillBox(startIndex-1, "start_checked_single")
                        }
                    } else if (selectDateCount == s_start_count) {
                        startIndex = contentItem.selectDateArr[0][2]-1
                        endIndex = popover.daysInMonth(contentItem.selectDateArr[0][1], contentItem.selectDateArr[0][0]) + 1
                        groupDayObj.fillBox(startIndex, "start_checked")
                    } else if (selectDateCount == s_end_count) {
                        startIndex = 0
                        endIndex = contentItem.selectDateArr[1][2]
                        groupDayObj.fillBox(endIndex-1, "end_checked")
                    } else {
                        return;
                    }
                    for (i=startIndex; i<endIndex-1; ++i) {
                        groupDayObj.fillBox(i, "middle")
                    }
                }
            }

            function fillDate() {
                var startIndex = 0
                var endIndex = 0
                var startDate = 0
                var endDate = 0
                var reverse = false

                if (contentItem.selectDateArr[0][0]*10000+contentItem.selectDateArr[0][1]*100+contentItem.selectDateArr[0][2]
                        <= contentItem.selectDateArr[1][0]*10000+contentItem.selectDateArr[1][1]*100+contentItem.selectDateArr[1][2]) {
                    startDate = contentItem.selectDateArr[0][2]
                    endDate = contentItem.selectDateArr[1][2]
                } else {
                    reverse = true
                    startDate = contentItem.selectDateArr[1][2]
                    endDate = contentItem.selectDateArr[0][2]
                }

                if (contentItem.selectDateArr[0][0] == contentItem.selectDateArr[1][0]
                        && contentItem.selectDateArr[0][1] == contentItem.selectDateArr[1][1]) {
                    startIndex = startDate-1
                    endIndex = endDate-1
                } else if (reverse){
                    startIndex = startDate-1
                    endIndex = popover.daysInMonth(contentItem.selectDateArr[1][1], contentItem.selectDateArr[1][0])-1
                } else {
                    startIndex = 0
                    endIndex = endDate-1
                }

                for (var i=startIndex+1; i<endIndex; ++i) {
                    groupDayObj.fillBox(i, "middle")
                }

                if (startIndex != endIndex) {
                    if (groupDayObj.getState(startIndex) == "checked") {
                        groupDayObj.fillBox(startIndex, "start")
                    } else {
                        groupDayObj.fillBox(startIndex, "middle")
                    }
                    if (groupDayObj.getState(endIndex) == "checked") {
                        groupDayObj.fillBox(endIndex, "end")
                    } else {
                        groupDayObj.fillBox(endIndex, "middle")
                    }
                }
            }

            function pushSelectDateArr(_v) {
                var isUpdate = false
                if (contentItem.selectDateArr.length == 2) {
                    contentItem.selectDateArr = []
                    isUpdate = true;
                }
                contentItem.selectDateArr.push([selectDate.year, selectDate.month, _v])
                if (isUpdate) {
                    updateDayGroup()
                }
            }

            function addSelectStep(_v) {
                contentItem.selectStep ++
            }

            function setStartDate() {
                popover.sendStartDate(
                                String(contentItem.selectDateArr[0][0]) + '.'
                            +   (contentItem.selectDateArr[0][1] < 10 ? '0'
                            +   String(contentItem.selectDateArr[0][1])
                            :   String(contentItem.selectDateArr[0][1])) + '.'
                            +   String(contentItem.selectDateArr[0][2]));
            }

            function setEndDate() {
                if (contentItem.selectDateArr.length == 0) {
                    return;
                }

                if (contentItem.selectDateArr.length > 1) {
                    var startDateStr = String(contentItem.selectDateArr[0][0]) + '.'
                            +   (contentItem.selectDateArr[0][1] < 10 ? '0'
                            +   String(contentItem.selectDateArr[0][1])
                            :   String(contentItem.selectDateArr[0][1])) + '.'
                            +   String(contentItem.selectDateArr[0][2])
                    var endDateStr = String(contentItem.selectDateArr[1][0]) + '.'
                            +   (contentItem.selectDateArr[1][1] < 10 ? '0'
                            +   String(contentItem.selectDateArr[1][1])
                            :   String(contentItem.selectDateArr[1][1])) + '.'
                            +   String(contentItem.selectDateArr[1][2])
                    if (contentItem.selectDateArr[0][0] * 10000 + contentItem.selectDateArr[0][1] * 100 + contentItem.selectDateArr[0][2] <=
                            contentItem.selectDateArr[1][0] * 10000 + contentItem.selectDateArr[1][1] * 100 + contentItem.selectDateArr[1][2]) {
                        popover.sendStartEndDate(startDateStr, endDateStr, [contentItem.selectDateArr[0], contentItem.selectDateArr[1]])
                    } else {
                        popover.sendStartEndDate(endDateStr, startDateStr, [contentItem.selectDateArr[1], contentItem.selectDateArr[0]])
                    }
                } else {
                    var curDateStr = String(contentItem.selectDateArr[0][0]) + '.'
                            +   (contentItem.selectDateArr[0][1] < 10 ? '0'
                            +   String(contentItem.selectDateArr[0][1])
                            :   String(contentItem.selectDateArr[0][1])) + '.'
                            +   String(contentItem.selectDateArr[0][2])
                    popover.sendStartEndDate(curDateStr, curDateStr, [contentItem.selectDateArr[0], contentItem.selectDateArr[0]]);
                }

                delayTimer.start()
            }
        }
    }

    Component {
        id: dayGroupCom
        Controls.TGridLayout {
            id: dayLayout
            x: 28;y: 108
            width: 448
            rowSpacing: 0
            columnSpacing: 0
            property alias daysModel: dayRepeater.model

            function getSelectStep() {
                return dayLayout.parent.selectStep
            }

            function pushSelectDateArr(_v) {
                dayLayout.parent.pushSelectDateArr(_v)
            }

            function fillDate() {
                dayLayout.parent.fillDate()
            }

            function addSelectStep() {
                dayLayout.parent.addSelectStep()
            }

            function fillBox(index, type) {
                dayRepeater.itemAt(index).fill(type)
            }

            function getState(index) {
                return dayRepeater.itemAt(index).state
            }

            function clickStartDate() {
                dayLayout.parent.setStartDate();
            }

            function clickEndDate() {
                dayLayout.parent.setEndDate();
            }

            Repeater {
                id: dayRepeater;
                delegate: MouseArea {
                    id: mouseArea
                    width: popover.unitWidth;height: 58
                    enabled: state != "disable"

                    onClicked: {
                        var step = dayLayout.getSelectStep()
                        if (step < 2) {
                            dayLayout.addSelectStep()
                            dayLayout.pushSelectDateArr(Number(modelData.label))
                            mouseArea.state = "checked"
                            if (step == 0) {
                                dayLayout.clickStartDate()
                            } else if (step == 1) {
                                dayLayout.clickEndDate()
                                dayLayout.fillDate()
                            }
                        }
                    }

                    function fill(type) {
                        switch(type) {
                            case "start":
                                fillRect.x = mouseArea.width/2;
                                fillRect.width = mouseArea.width/2
                                break;
                            case "end":
                                fillRect.width = mouseArea.width/2
                                break;
                            case "start_checked":
                                mouseArea.state = "checked"
                                fillRect.x = mouseArea.width/2;
                                fillRect.width = mouseArea.width/2
                                break;
                            case "start_checked_single":
                                mouseArea.state = "checked"
                                fillRect.width = 0
                                break;
                            case "end_checked":
                                mouseArea.state = "checked"
                                fillRect.width = mouseArea.width/2
                                break;
                        }

                        fillRect.visible = true;
                    }

                    Rectangle {
                        id: fillRect;
                        color: Qt.rgba(0,191,181,0.13)
                        width: parent.width;height: 42
                        anchors.verticalCenter: parent.verticalCenter
                        visible: false
                    }

                    Rectangle {
                        id: checkedBox;
                        color: "#00BFB5"
                        property int designWidth: 48
                        width: designWidth;height: designWidth
                        radius: 48
                        anchors.centerIn: parent;
                        visible: false
                    }

                    Text {
                        id: dayTxt
                        width: parent.width;height: parent.height
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 20
                        property color disColor: !modelData.today ? "#C0C4CC" : "#00BFB5"
                        property color idleColor: !modelData.today ?"#606266" : "#00BFB5"
                        property color checkedColor: "#FFFFFF"
                        property color fullColor: dayCountBox.visible ? "#00BFB5" : "#C0C4CC"
                        color: disColor
                        text: !modelData.today ? modelData.label : qsTr("今")

                        Rectangle {
                            visible: modelData.today
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 5
                            width: 6;height: 6
                            radius: 6
                            color: "#00BFB5"
                        }
                    }

                    Rectangle {
                        id: dayCountBox
                        anchors.right: parent.right
                        width: 22;height: width
                        radius: width
                        color: "#F6B439"
                        visible: modelData.count > 0 ? true : false;
                        Text {
                            width: parent.width;height: parent.height
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: "#FFFFFF"
                            font.pixelSize: 12
                            text: String(modelData.count)
                        }
                    }

                    state: modelData.state
                    states: [
                        State {
                            name: "disable"
                            PropertyChanges { target: dayTxt; color: dayTxt.disColor }
                            PropertyChanges { target: checkedBox; visible: false }
                        },
                        State {
                            name: "idle"
                            PropertyChanges { target: dayTxt; color: dayTxt.idleColor }
                            PropertyChanges { target: checkedBox; visible: false }
                        },
                        State {
                            name: "checked"
                            PropertyChanges { target: dayTxt; color: dayTxt.checkedColor }
                            PropertyChanges { target: checkedBox; visible: true }
                        },
                        State {
                            name: "fill"
                            PropertyChanges { target: dayTxt; color: dayTxt.fullColor }
                            PropertyChanges { target: checkedBox; visible: false }
                        }
                    ]
                }
            }
        }
    }
}
