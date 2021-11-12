import QtQuick 2.12
import QtGraphicalEffects 1.0

MouseArea {
    id: control;

    implicitWidth: 260;
    implicitHeight: 44;

    enabled: interactive;

    property bool  opened: false;

    property bool  interactive: true;
    property bool  effectable: true;
    property bool  boraderable: false;
    property alias radius: bgRect.radius;
    property alias text: contentText.displayText;
    property alias color: contentText.displayTextColor;
    property alias placeholderText: contentText.placeholderText;
    property alias placeholderTextColor: contentText.placeholderTextColor;
    property alias textLeftPadding: contentText.leftPadding
    property alias textPixelSize: contentText.font.pixelSize
    property alias textContentWidth: contentText.contentWidth
    property alias valueArr: popupLoader.valueArr;
    property alias menuData: popupLoader.menuData;
    property alias totalItem: popupLoader.totalItem;
    property alias font: contentText.font
    property alias indicatorColor: indicatorImg.color
    property alias bgRectColor: bgRect.color
    property alias bgRectRadius: bgRect.radius
    property var popupContentItem: popupLoader.item;
    property var itemContentItem: itemLoader.item;
    property int targetX: -1

    property Component popup;
    property Component itemCom;

    signal requireHospitalList(int pages);
    signal updateText(string text, var valueArr);

    onOpenedChanged: {
        if (opened) {
            popupLoader.sourceComponent = popup
            popupLoader.item.y = control.height + 10;
            popupLoader.item.x = targetX > -1 ? targetX : control.x
        } else {
            popupLoader.sourceComponent = null;
        }
    }

    onItemComChanged: {
        if (itemCom) {
            itemLoader.sourceComponent = itemCom
        }
    }

    Loader{
        id:popupLoader;
        anchors.fill: parent;
        asynchronous: true;
        property var valueArr: []
        property var menuData: null;
        property int totalItem: 0;
    }

    Loader {
        id: itemLoader;
        z: 1
        anchors.fill: parent;
        asynchronous: true;
    }

    Connections {
        target: popupLoader.item;
        ignoreUnknownSignals: true;
        onClosed: {
            if (!control.pressed)
                control.opened = false;
        }
        onUpdateText: {
            control.text = text;
            popupLoader.valueArr = valueArr;
            control.updateText(text, valueArr)
        }
        onRequireHospitalList: {
            control.requireHospitalList(pages);
        }
    }

    RectangularGlow {
        id: effect
        visible: control.opened && control.effectable
        anchors.centerIn: bgRect;
        width: bgRect.width - glowRadius - glowRadius * spread
        height: bgRect.height - glowRadius - glowRadius * spread
        glowRadius: 40
        spread: 0.2
        color: "#CFCFCF"
        cornerRadius: 0
    }

    Rectangle {
        id: bgRect
        radius: 4
        anchors.fill: parent;
        color: control.enabled ? "#FFF" : (control.effectable ? "#F1F1F1" : "#FFF")
        border.width: ((!control.opened && control.effectable)
                       ||control.boraderable) ? 1 : 0;
        border.color: !control.boraderable ? "#BCBCBC"
                                           : (control.opened ? "#00BFB5" : "#DCDFE6")
    }

    Text {
        id: contentText;
        leftPadding: 28;
        height: control.height
        width: control.width - leftPadding
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        color: contentText.displayText.length > 0
            ? displayTextColor : placeholderTextColor
        font.pixelSize: 14
        text: contentText.displayText.length > 0
              ? contentText.displayText : contentText.placeholderText

        property string placeholderText: ""
        property color placeholderTextColor: "#BCBCBC"
        property string displayText: ""
        property color displayTextColor: "#848484"
    }

    Item {
        id: indicator
        visible: control.interactive
        width: control.height
        height: control.height;
        anchors.right: control.right;
        LSVGIcon {
            id: indicatorImg
            color: "#BCBCBC"
            rotation: control.opened ? 0 : 180
            anchors.centerIn: indicator
            source: "qrc:/net.xuin.lpm.res/resource/checkPage/icon_moreopen_16＊16.svg"

            Behavior on rotation {
                NumberAnimation {duration: 150}
            }
        }
    }

    onClicked: {
        control.focus = true;
        control.opened = !control.opened;
    }
}
