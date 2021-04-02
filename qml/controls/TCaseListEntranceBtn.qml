import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Item {
    id: btn
    width: 140
    height: 40

    property color color: "#BCBCBC"

    property int historyListType: 0; //0[case]/1[screenshot]

    signal clicked()

    BorderImage {
        anchors.horizontalCenter: parent.horizontalCenter
        source: "qrc:/com.aiyunji.lpm.res/resource/checkPage/mask.png"
        width: txt.contentWidth + 50;
        height: 50
        border.left: 35;
        border.right: 35;
    }

    onVisibleChanged: {
        if (!visible) {
            breathAni.complete()
            transAni.complete()
        }
    }

    RectangularGlow {
        id: effect
        visible: false;
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -5
        width: btn.width - glowRadius - glowRadius * spread
        height: 0
        glowRadius: 20
        spread: 0
        cornerRadius: 40
    }

    ColumnLayout {
        id: layout;
        anchors.centerIn: parent;
        Text {
            id: txt
            font.pixelSize: 16
            color: btn.color
            text: historyListType == 0 ? qsTr("点击查看历史病例")
                                       : qsTr("点击查看历史截图")
        }
        LSVGIcon {
            width: 10;height: 6
            Layout.alignment: Qt.AlignCenter
            color: btn.color
            source: "qrc:/com.aiyunji.lpm.res/resource/checkPage/icon_more_default_16＊16.svg"
        }
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: btn.clicked();
    }


    SequentialAnimation {
        id: breathAni
        loops: -1

        ParallelAnimation {
            ColorAnimation {
                target: btn
                property: "color"
                from: "#BCBCBC"
                to: "#00313F"
                duration: 2700
            }
            ColorAnimation {
                target: effect
                property: "color"
                from: "#00FFF2"
                to: "#00313F"
                duration: 2700
            }
        }

        ParallelAnimation {
            ColorAnimation {
                target: btn
                property: "color"
                from: "#00313F"
                to: "#BCBCBC"
                duration: 2700
            }
            ColorAnimation {
                target: effect
                property: "color"
                from: "#00313F"
                to: "#00FFF2"
                duration: 2700
            }
        }

        PauseAnimation {duration: 100}
    }

    SequentialAnimation {
        id: transAni
        ParallelAnimation {
            ColorAnimation {
                target: btn
                property: "color"
                to: "#BCBCBC"
                duration: 1200
            }
            NumberAnimation {
                target: effect
                properties: "glowRadius,cornerRadius"
                to: 0
                duration: 600
            }
        }
        ScriptAction{script: {
                btn.color = "#BCBCBC"
                effect.visible = false;
            }}
    }

    function startAni() {
        transAni.stop()
        if (!breathAni.running) {
            effect.visible = true
            transAni.stop()
            effect.glowRadius = 20
            effect.cornerRadius = 40
            breathAni.start()
        }
    }

    function stopAni() {
        breathAni.stop()
        transAni.start()
    }
}
