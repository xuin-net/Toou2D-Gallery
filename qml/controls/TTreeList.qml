import QtQuick 2.6

Item {
    id: list

    property var curSelectInfo: ({})
    property int curSelectCount: 0

    property bool firstMoving: false;
    property bool secondMoving: false;
    property bool arrowAni: false;

    property bool isEmpty: firstRepeater.count <= 0
    // 一级互斥
    property bool firstReject: false;

    property int propertyChangeFactor: -1

    readonly property int utilHeight: 58

    /*requireData:
      {
        "srInfo": {
            "firstUUID1": {uuidInfo: {
                "secondUUID1": ["thirdUUID1", thirdUUID2", thirdUUID3", thirdUUID4", thirdUUID5"]
                "secondUUID2": ["thirdUUID6"]
            }}
            firstUUID1": {uuidInfo: ["thirdUUID7", thirdUUID8"]}
        }
        "srArr":["thirdUUID1", thirdUUID2", thirdUUID3", thirdUUID4", thirdUUID5", "thirdUUID6", "thirdUUID7", "thirdUUID8"]
      }
      */
    signal requireListData(var requireData)
    signal removeWithUUID(string uuid)

    // 展开底部二级时，向上推3个Item
    function updateGlobalPosition(_y) {
        var targetY = _y - flickable.contentY
        if (targetY > (flickable.height - list.utilHeight - 32) &&
                targetY < flickable.height) {
            flickable.flick(0,-700)
        }
    }

    Rectangle {
        visible: !isEmpty
        anchors.right: parent.right
        width: 1;height: parent.height
        color: "#C0C4CC"
    }

    Flickable {
        id: flickable
        width: parent.width;height: parent.height
        contentHeight: column.implicitHeight
        clip: true
        property var curEnterItem: null

        interactive: contentHeight > height

        // 级别置顶
        /*onContentYChanged: {
            var topItem = column.childAt(0, contentY)
            if (contentY < 0) {
                curEnterItem = null;
                resetRepeater()
            }

            if (topItem) {
                if (curEnterItem != topItem) {
                    resetRepeater();
                    if (curEnterItem == null
                            || (curEnterItem.delegateIndex < topItem.delegateIndex)) {
                        if (!list.secondMoving) {
                            list.firstMoving = true;
                        }
                        topItem.canMoving = true;
                    }
                    curEnterItem = topItem
                }
                topItem.updateHeader(contentY)
            } else {
                resetRepeater();
            }
        }*/

        function resetRepeater() {
            for (var i=0;i<firstRepeater.count;++i) {
                if (firstRepeater.itemAt(i)) {
                    firstRepeater.itemAt(i).clearEnterItem()
                    firstRepeater.itemAt(i).reset()
                }
            }
        }

        function resetFirstRepeater() {
            curEnterItem = null;
            resetRepeater()
        }

        function checkFirstAndSecond(_first,_second) {
            for (var i=0;i<firstRepeater.count;++i) {
                if (firstRepeater.itemAt(i).itemID == _first) {
                    firstRepeater.itemAt(i).checkSecond(_second)
                    return;
                }
            }
        }

        function packupAllFirst() {
            for (var i=0;i<firstRepeater.count;++i) {
                firstRepeater.itemAt(i).packupCurFirst()
            }
        }

        function expandCurFirst(_index) {
            if (_index > -1 && _index < firstRepeater.count ) {
                for (var i=0;i<firstRepeater.count;++i) {
                    if (firstRepeater.itemAt(i).delegateIndex == _index) {
                        firstRepeater.itemAt(_index).expandCurFirst()
                        break;
                    }
                }
            }
        }

        function expandById(_id) {
            for (var i=0;i<firstRepeater.count;++i) {
                if (firstRepeater.itemAt(i).itemID == _id) {
                    firstRepeater.itemAt(i).expandCurFirst()
                    break;
                }
            }
        }

        function topItem(info) {
            for (var i=0;i<firstRepeater.count;++i) {
                if (firstRepeater.itemAt(i).itemID == info.first) {
                    firstRepeater.itemAt(i).topItem(info)
                }
            }
        }

        Column {
            id: column
            // 一级生成器
            Repeater {
                id: firstRepeater;

                property int currentIndex: -1

                Item {
                    id: delegateItem
                    width: list.width;
                    property int delegateIndex: index
                    property bool canMoving: false;
                    property bool checked: {
                        propertyChangeFactor;
                        if (curSelectInfo[itemID]) {
                            return true;
                        }
                        return false;
                    }

                    property var secondEnterItem: null
                    property string itemName: modelData.name
                    property string itemID: String(modelData.uuid)

                    Rectangle {
                        id: headerRect
                        z: 100
                        width: list.width - 1;height: list.utilHeight

                        Text {
                            id: headerText
                            width: 289
                            height: parent.height
                            verticalAlignment: Text.AlignVCenter
                            anchors.left: parent.left;
                            anchors.leftMargin: 32
                            color: !delegateItem.checked ? "#303133" : "#00BFB5"
                            font.pixelSize :19
                            text: delegateItem.itemName
                            elide: Text.ElideRight
                        }

                        TSVGIcon {
                            color: "#C0C4CC"
                            rotation: secondColumn.visible ? 0 : -180
                            anchors.right: parent.right
                            anchors.rightMargin: 32
                            anchors.verticalCenter: parent.verticalCenter
                            source: "qrc:/assets/Icon/Icon_moreopen.svg"

                            Behavior on rotation {
                                enabled: list.arrowAni
                                NumberAnimation {duration: 150}
                            }
                        }

                        Rectangle {
                            id: countRect
                            visible: delegateItem.checked
                                     && Array.isArray(curSelectInfo[delegateItem.itemID].uuidInfo)
                            anchors.right: parent.right
                            anchors.rightMargin: 32
                            anchors.verticalCenter: parent.verticalCenter
                            width: 30;height: 30
                            radius: 30
                            color: "#00BFB5"

                            Text {
                                id: countTxt
                                width: countRect.width
                                height: countRect.height
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                text: {
                                    propertyChangeFactor
                                    if (countRect.visible
                                            && curSelectInfo[delegateItem.itemID]) {
                                        return String(curSelectInfo[delegateItem.itemID].uuidInfo.length)
                                    }
                                    return "";
                                }
                                font.pixelSize: 16
                                color: "#FFFFFF"
                            }
                        }

                        Rectangle {
                            visible: list.firstMoving && delegateItem.canMoving && headerRect.y > 0
                            anchors.bottom: parent.bottom
                            width: parent.width;height: 1
                            color: "#C0C4CC"
                        }

                        MouseArea {
                            anchors.fill: parent;
                            onClicked: {
                                // 一级互斥
                                if (list.firstReject && !secondColumn.visible) {
                                    flickable.packupAllFirst()
                                }
                                secondColumn.visible = !secondColumn.visible
                                if (secondColumn.visible) {
                                    updateGlobalPosition(delegateItem.y)
                                }

                                firstRepeater.currentIndex = delegateItem.delegateIndex
                            }
                        }
                    }

                    Component.onCompleted: {
                        updateContent();
                    }

                    function packupCurFirst() {
                        secondColumn.visible = false;
                    }

                    function expandCurFirst() {
                        secondColumn.visible = true;
                        if (delegateItem.checked
                                && !Array.isArray(curSelectInfo[delegateItem.itemID].uuidInfo)) {
                            var curInfo = curSelectInfo[delegateItem.itemID].uuidInfo;
                            Object.keys(curInfo).forEach(function(key){
                                for (var i=0;i<secondRepeater.count;++i) {
                                    if (secondRepeater.itemAt(i).secondID == key) {
                                        secondRepeater.itemAt(i).expand()
                                        break;
                                    }
                                }
                            });
                        }
                    }

                    function updateContent(_noReset) {
                        if (secondColumn.visible) {
                            var totalHeight = 0;
                            for (var i=0;i<secondRepeater.count;++i) {
                                totalHeight += secondRepeater.itemAt(i).height
                            }
                            delegateItem.height = totalHeight + list.utilHeight
                        } else {
                            delegateItem.height = list.utilHeight
                        }
                        if (!_noReset) {
                            flickable.resetFirstRepeater();
                        }
                    }

                    function updateHeader(_curPosY) {
                        if (delegateItem.canMoving) {
                            var tarY = _curPosY - delegateItem.y;
                            var dst = delegateItem.height - tarY;
                            if (dst > headerRect.height) {
                                headerRect.y = tarY
                                var topSecondItem = secondColumn.childAt(0, tarY)
                                if (topSecondItem) {
                                    if (secondEnterItem != topSecondItem) {
                                        resetSecondRepeater();
                                        if (secondEnterItem == null
                                                || (secondEnterItem.delegateIndex < topSecondItem.delegateIndex)) {
                                            list.secondMoving = true;
                                            topSecondItem.canMoving = true;
                                        }
                                        secondEnterItem = topSecondItem
                                    }
                                    topSecondItem.updateHeader(tarY)
                                }
                            }
                        }
                    }

                    function reset() {
                        if (delegateItem.canMoving) {
                            delegateItem.canMoving = false;
                            list.firstMoving = false;
                            headerRect.y = 0
                        }
                    }

                    function clearEnterItem() {
                        secondEnterItem = null
                        resetSecondRepeater()
                    }

                    function resetSecondRepeater() {
                        for (var i=0;i<secondRepeater.count;++i) {
                            if (secondRepeater.itemAt(i))
                                secondRepeater.itemAt(i).reset()
                        }
                    }

                    function packupAddSecond() {
                        for (var i=0;i<secondRepeater.count;++i) {
                            if (secondRepeater.itemAt(i))
                                secondRepeater.itemAt(i).packup()
                        }
                    }

                    function checkSecond(_second) {
                        secondColumn.visible = true;
                        for (var i=0;i<secondRepeater.count;++i) {
                            if (secondRepeater.itemAt(i).secondID == _second) {
                                secondRepeater.itemAt(i).expand()
                                return;
                            }
                        }
                    }

                    function packupCurSecond(_nextIndex) {
                        var curIndex = secondRepeater.currentIndex;
                        if (curIndex > -1 && curIndex < _nextIndex
                                && secondRepeater.itemAt(curIndex).divLineVisible == true) {
                            // 需要调整ContentY 以适配内容错乱的问题
                        }
                    }

                    function reInversion(_index) {
                        if (secondRepeater.itemAt(_index)) {
                            secondRepeater.itemAt(_index).inversion();
                        }
                    }

                    function topItem(info) {
                        for (var i=0;i<secondRepeater.count;++i) {
                            if (secondRepeater.itemAt(i).secondID == info.second) {
                                secondRepeater.itemAt(i).topItem(info)
                            }
                        }
                    }

                    Column {
                        id: secondColumn
                        y: list.utilHeight
                        visible: false;

                        onVisibleChanged: {
//                            if (!visible) {
//                                delegateItem.packupAddSecond();
//                            }
                            delegateItem.updateContent()
                        }

                        // 二级生成器
                        Repeater {
                            id: secondRepeater

                            model: modelData.infos

                            property int currentIndex: -1

                            Item {
                                id: secondDelegate
                                width: list.width;height: thirdColumn.visible
                                                          ? (thirdRepeater.count + 1) * list.utilHeight
                                                          : list.utilHeight

                                onHeightChanged: {
                                    delegateItem.updateContent(true)
                                }

                                property bool checked: {
                                    propertyChangeFactor;
                                    var firstID = delegateItem.itemID

                                    if (curSelectInfo[firstID]) {
                                        if (Array.isArray(curSelectInfo[firstID].uuidInfo)) {
                                            if (curSelectInfo[firstID].uuidInfo.indexOf(secondDelegate.secondID) > -1) {
                                                return true;
                                            }
                                        } else if (curSelectInfo[firstID].uuidInfo[secondDelegate.secondID]){
                                            return true;
                                        }
                                    }

                                    return false;
                                }
                                property bool canMoving: false;
                                property int delegateIndex: index
                                property string secondName: modelData.name
                                property string secondID: secondMoreBtn.visible
                                                            ? String(modelData.uuid)
                                                            : modelData.uuid

                                property alias divLineVisible: divLine.visible

                                function updateHeader(_curY) {
                                    if (secondDelegate.canMoving) {
                                        var tarY = _curY - secondDelegate.y;
                                        var dst = secondDelegate.height - tarY;
                                        if (dst > secondHeaderRect.height) {
                                            secondHeaderRect.y = tarY
                                        }
                                    }
                                }

                                function reset() {
                                    if (secondDelegate.canMoving) {
                                        secondDelegate.canMoving = false;
                                        list.secondMoving = false
                                        secondHeaderRect.y = 0
                                    }
                                }

                                function packup() {
                                    thirdColumn.visible = false;
                                }

                                function expand() {
                                    thirdColumn.visible = true;
                                }

                                function inversion() {
                                    thirdColumn.visible = !thirdColumn.visible
                                    if (thirdColumn.visible) {
                                        var curContentY = list.utilHeight + delegateItem.y + secondDelegate.y;
                                        updateGlobalPosition(curContentY);
                                    }
                                }

                                function topItem(info) {
                                    if (secondMoreBtn.visible) {
                                        for (var i=0;i<thirdRepeater.count;++i) {
                                            if (thirdRepeater.itemAt(i).thirdID == info.third) {
                                                thirdRepeater.itemAt(i).topItem()
                                            }
                                        }
                                    } else {
                                        var curContentY = delegateItem.y + secondDelegate.y - flickable.contentY;
                                        delayTime.startDelayTime(curContentY)
                                    }
                                }

                                Component.onCompleted: {
                                    var children = modelData.children
                                    if (children && children.length > 0) {
                                        secondMoreBtn.visible = true;
                                        var infos = []
                                        for (var i=0;i<children.length;++i) {
                                            infos.push({name: children[i].name,
                                                           uuid:  children[i].uuid,count: children[i].count})
                                        }
                                        thirdRepeater.model = infos;
                                    }
                                }

                                Rectangle {
                                    id: secondHeaderRect
                                    z: 50
                                    width: list.width - 1;height: list.utilHeight

                                    Rectangle {
                                        visible: secondDelegate.checked && !secondMoreBtn.visible
                                        anchors.fill: parent;
                                        color: Qt.rgba(0,191,181,0.13)
                                        Rectangle {
                                            width: 4;height: list.utilHeight
                                            color: "#00BFB5"
                                            anchors.right: parent.right
                                        }
                                    }

                                    Text {
                                        id: secondHeaderText
                                        height: parent.height
                                        width: 247
                                        verticalAlignment: Text.AlignVCenter
                                        anchors.left: parent.left
                                        anchors.leftMargin: 70
                                        color: !secondDelegate.checked ? txtCol : "#00BFB5"
                                        property color txtCol: thirdRepeater.count > 0 ? "#606266" : "#AFB7C7"
                                        font.pixelSize :18
                                        text: secondDelegate.secondName
                                        elide: Text.ElideRight
                                    }

                                    TSVGIcon {
                                        id: secondMoreBtn
                                        visible: false
                                        color: "#C0C4CC"
                                        rotation: thirdColumn.visible ? 0 : -180
                                        anchors.right: parent.right
                                        anchors.rightMargin: 32
                                        anchors.verticalCenter: parent.verticalCenter
                                        source: "qrc:/assets/Icon/Icon_moreopen.svg"

                                        Behavior on rotation {
                                            enabled: list.arrowAni
                                            NumberAnimation {duration: 150}
                                        }
                                    }

                                    Rectangle {
                                        id: countThirdRect
                                        visible: secondDelegate.checked && secondMoreBtn.visible;
                                        anchors.right: parent.right
                                        anchors.rightMargin: 32
                                        anchors.verticalCenter: parent.verticalCenter
                                        width: 30;height: 30
                                        radius: 30
                                        color: "#00BFB5"

                                        Text {
                                            id: countThirdTxt
                                            width: countThirdRect.width
                                            height: countThirdRect.height
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                            text: {
                                                propertyChangeFactor
                                                if (countThirdRect.visible
                                                        && curSelectInfo[delegateItem.itemID]
                                                        && curSelectInfo[
                                                            delegateItem.itemID].uuidInfo[
                                                            secondDelegate.secondID]) {
                                                    return String(curSelectInfo[
                                                                      delegateItem.itemID].uuidInfo[
                                                                      secondDelegate.secondID].length)
                                                }
                                                return "";
                                            }
                                            font.pixelSize: 16
                                            color: "#FFFFFF"
                                        }
                                    }

                                    Rectangle {
                                        id: divLine
                                        visible: {
                                            var rest = list.secondMoving && secondDelegate.canMoving
                                                 && secondHeaderRect.y > 0
                                            list.firstMoving = !rest;
                                            return rest;
                                        }
                                        anchors.bottom: parent.bottom
                                        width: parent.width;height: 1
                                        color: "#C0C4CC"
                                    }

                                    MouseArea {
                                        anchors.fill: parent;
                                        onClicked: {
                                            if (secondMoreBtn.visible) {
                                                // 有三级列表
                                                if (!thirdColumn.visible) {
                                                    delegateItem.packupCurSecond(secondDelegate.delegateIndex)
                                                    secondRepeater.currentIndex = secondDelegate.delegateIndex
                                                } else {
                                                    secondRepeater.currentIndex = -1
                                                }
                                                secondDelegate.inversion()
                                            } else {
                                                addToSelectInfo(
                                                            delegateItem.itemID,
                                                            secondDelegate.secondID,
                                                            null)
                                            }
                                        }
                                    }
                                }

                                Column {
                                    id: thirdColumn
                                    y: list.utilHeight
                                    visible: false;

                                    // 三级生成器
                                    Repeater {
                                        id: thirdRepeater

                                        Rectangle {
                                            id: thirdDelegate
                                            width: list.width - 1;height: list.utilHeight

                                            property bool checked: {
                                                propertyChangeFactor;
                                                var firstID = delegateItem.itemID
                                                if (secondDelegate.checked
                                                        && curSelectInfo[firstID].uuidInfo[
                                                            secondDelegate.secondID].indexOf(thirdID) > -1) {
                                                    return true;
                                                }
                                                return false;
                                            }
                                            property string thirdName: modelData.name
                                            property string thirdID: modelData.uuid


                                            function topItem() {
                                                var offsetHeight = list.utilHeight * 2
                                                var curContentY = delegateItem.y + secondDelegate.y + thirdDelegate.y - flickable.contentY;
                                                curContentY += offsetHeight
                                                delayTime.startDelayTime(curContentY)
                                            }

                                            Rectangle {
                                                visible: checked
                                                anchors.fill: parent;
                                                color: Qt.rgba(0,191,181,0.13)
                                                Rectangle {
                                                    width: 4;height: list.utilHeight
                                                    color: "#00BFB5"
                                                    anchors.right: parent.right
                                                }
                                            }

                                            Text {
                                                id: thirdTxt
                                                height: parent.height
                                                width: 250
                                                anchors.left: parent.left
                                                anchors.leftMargin: 107
                                                verticalAlignment: Text.AlignVCenter
                                                color: !thirdDelegate.checked ? "#AFB7C7" : "#00BFB5"
                                                font.pixelSize: 18
                                                text: thirdDelegate.thirdName
                                                elide: Text.ElideRight
                                            }

                                            MouseArea {
                                                anchors.fill: parent;
                                                onClicked: {
                                                    addToSelectInfo(
                                                                delegateItem.itemID,
                                                                secondDelegate.secondID,
                                                                thirdDelegate.thirdID)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Timer {
        id: delayTime
        interval: 80;repeat: false;
        property real contentY: 0
        onTriggered: {
            skipTopItem(delayTime.contentY)
        }
        function startDelayTime(_y) {
            delayTime.contentY = _y
            delayTime.start()
        }
    }

    function skipTopItem(_contentY) {
        flickable.contentY = _contentY
    }

    function setSelectInfo(_info, _firstInfo) {
        if (checkMaxCount()) {
            return false;
        }
        curSelectInfo = _info.srInfo
        curSelectCount = _info.srArr.length
        propertyChangeFactor++;

        Object.keys(curSelectInfo).forEach(function(key){
            flickable.expandById(key);
        });

        if (_firstInfo) {
            flickable.topItem(_firstInfo);
        }
        return true;
    }

    function checkMaxCount() {
        /*if (curSelectCount >= 6) {
            __root_window__.showAlertMessage("fail", qsTr("当前选择的综合征不能超过6个。"))
            return true;
        }*/

        return false;
    }

    function addToSelectInfo(_first, _second, _third) {
        var newSelectInfo = ({})
        var targetUUID = ""

        // 是否已存在
        if (_third) {
            if (curSelectInfo[_first]
                    && curSelectInfo[_first].uuidInfo[_second]
                    && curSelectInfo[_first].uuidInfo[_second].indexOf(_third) > -1)
            targetUUID = _third
        } else if (curSelectInfo[_first]
                && curSelectInfo[_first].uuidInfo.indexOf(_second) > -1) {
            targetUUID = _second
        }
        if (targetUUID) {
            removeWithUUID(targetUUID)
            return;
        }

        if (checkMaxCount()) {
            return;
        }

        copyInfo(curSelectInfo, newSelectInfo)

        if (!newSelectInfo[_first]) {
            if (_third) {
                newSelectInfo[_first] = {"uuidInfo": {}}
            } else {
                newSelectInfo[_first] = {"uuidInfo": []}
            }
        }

        var shouldUpdate = false;

        // 三级列表中发出
        if (_third && !newSelectInfo[_first].uuidInfo[_second]) {
            newSelectInfo[_first].uuidInfo[_second] = []
        }
        if (_third && newSelectInfo[_first].uuidInfo[_second].indexOf(_third) == -1) {
            shouldUpdate = true;
            newSelectInfo[_first].uuidInfo[_second].push(_third)
        }

        // 二级列表中发出
        if (!_third && newSelectInfo[_first].uuidInfo.indexOf(_second) == -1) {
            shouldUpdate = true;
            newSelectInfo[_first].uuidInfo.push(_second)
        }

        if (shouldUpdate) {
            requireData(newSelectInfo)
        }
    }

    function removeSelectSyndrome(uuid) {
        try {
            Object.keys(curSelectInfo).forEach(function(key){
                var curInfo = curSelectInfo[key].uuidInfo
                if (Array.isArray(curInfo)) {
                    var curIndex = curInfo.indexOf(uuid)
                    if (curIndex > -1) {
                        curInfo.splice(curIndex, 1)
                        if (curInfo.length == 0) {
                            delete curSelectInfo[key]
                        }
                        throw new Error("EndIterative");
                    }
                } else {
                    Object.keys(curInfo).forEach(function(secondKey){
                        var curSecondInfo = curInfo[secondKey]
                        var curSecondIndex = curSecondInfo.indexOf(uuid);
                        if (curSecondIndex > -1) {
                            curSecondInfo.splice(curSecondIndex, 1)
                            if (curSecondInfo.length == 0) {
                                delete curInfo[secondKey]
                            }
                            if (JSON.stringify(curInfo) == '{}') {
                                delete curSelectInfo[key]
                            }
                            throw new Error("EndIterative");
                        }
                    })
                }
            })
        } catch(e) {
            // e.message
            curSelectCount --;
            propertyChangeFactor++;
        };
    }

    function requireData(_info) {
        var data = ({})
        var srArr = []
        Object.keys(_info).forEach(function(firstKey){
            if (Array.isArray(_info[firstKey].uuidInfo)) {
                srArr = srArr.concat(_info[firstKey].uuidInfo)
            } else {
                Object.keys(_info[firstKey].uuidInfo).forEach(function(secondKey){
                    srArr = srArr.concat(_info[firstKey].uuidInfo[secondKey])
                })
            }
        });
        data.srInfo = _info
        data.srArr = srArr
        list.requireListData(data)
    }

    function copyInfo(_source, _target) {
        Object.keys(_source).forEach(function(key){
            _target[key] = _source[key]
        });
    }

    function expandItem(_index) {
        flickable.expandCurFirst(_index)
    }

    function updateModel(_arr) {
        if (_arr.length > 0) {
            list.arrowAni = false;
            var firstModel = []
            for (var i=0;i<_arr.length;++i) {
                var secondInfos = _arr[i].children
                var secondArr = []
                for (var j=0;j<secondInfos.length;++j) {
                    secondArr.push(secondInfos[j])
                }
                var value = {
                    name: _arr[i].name,
                    uuid: _arr[i].uuid,
                    count: _arr[i].count,
                    infos: secondArr
                }
                firstModel.push(value)
            }
            firstRepeater.model = firstModel
            list.arrowAni = true;
        }
        // 默认展开第一级
        expandItem(0)
    }
}
