import QtQuick 2.6
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import "../controls" as Controls

TextField {
    id: control
    font.pixelSize: 24
    color: "#848484";
    leftPadding: 30
    rightPadding: btnBox.width
    enabled: state == "idle"

    signal startConnect();

    EnterKey.type: Qt.EnterKeySearch

    onAccepted: {
        control.focus = false;
    }

    background: Item {
        anchors.fill: parent;
        RectangularGlow {
            id: effect
            visible: control.focus
            anchors.centerIn: bgRect;
            width: bgRect.width - glowRadius - glowRadius * spread
            height: bgRect.height - glowRadius - glowRadius * spread
            glowRadius: 40
            spread: 0.2
            color: "#BFBFBF"
            cornerRadius: bgRect.radius + glowRadius
        }

        Rectangle {
            id: bgRect
            width: parent.width;height: parent.height
            radius: height
            border.color: "#00BFB5"
            border.width: control.focus ? 0 : 2;
        }

        Row {
            visible: (control.displayText.length > 0 || control.activeFocus) ? false : true
            x: 30
            height: parent.height
            spacing: 13
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/assets/Icon/Icon_Input_01.png"
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 24
                color: "#BCBCBC"
                text: qsTr("请输入本地服务器地址进行配对连接")
            }
        }
    }

    state: "idle" //["idle"/"connect"/"success"]
    states: [
        State {
            name: "idle"
            PropertyChanges { target: contBtnTxt; opacity: 0.0 }
            PropertyChanges { target: successBtnTxt; opacity: 0.0 }
            PropertyChanges { target: idleBtnTxt; opacity: 1.0 }
            PropertyChanges { target: connectIcon; running: false }
            PropertyChanges { target: icon;behaviorEnable: false; }
            PropertyChanges { target: icon; scale: 1.0;
                source: "qrc:/assets/Icon/Icon_Connect_01.png"}
        },
        State {
            name: "connect"
            PropertyChanges { target: idleBtnTxt; opacity: 0.0 }
            PropertyChanges { target: successBtnTxt; opacity: 0.0 }
            PropertyChanges { target: contBtnTxt; opacity: 1.0 }
            PropertyChanges { target: connectIcon; running: true }
            PropertyChanges { target: icon; scale: 0.0 ; source: ""}
        },
        State {
            name: "success"
            PropertyChanges { target: contBtnTxt; opacity: 0.0 }
            PropertyChanges { target: idleBtnTxt; opacity: 0.0 }
            PropertyChanges { target: successBtnTxt; opacity: 1.0 }
            PropertyChanges { target: connectIcon; running: false }
            PropertyChanges { target: icon; scale: 1.0;
                source: "qrc:/assets/Icon/Icon_Successful_28_28_01.png" }
        }
    ]

    Item {
        id: btnBox
        anchors.right: parent.right
        width: 235;height: 70;
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: btnBox.width
                height: btnBox.height
                Rectangle {
                    anchors.fill: parent;
                    radius: height;
                }
            }
        }

        Controls.TButton {
            id: sumitBtn
            anchors.right: parent.right
            width: 200;height: 70
            baseColor: "#00BFB5"
            onClicked: {
                control.focus = false;
                if (control.state == "idle") {
                    control.state = "connect"
                    control.startConnect();
                }
            }

            Controls.TBusyIndicator {
                id: connectIcon
                anchors.verticalCenter: parent.verticalCenter;
                anchors.verticalCenterOffset: 13
                x: -50
                delegateColor: "#FFFFFF"
                warnLabelVisable: false
                scale: 0.5
                background: Item{
                    anchors.fill: parent;
                }
            }

            Image {
                id: icon
                x: 20
                property alias behaviorEnable: scaleBehavior.enabled
                anchors.verticalCenter: parent.verticalCenter;
                source: "qrc:/assets/Icon/Icon_Connect_01.png"
                Behavior on scale {
                    id: scaleBehavior
                    ScaleAnimator{duration: 400;easing.type: Easing.OutBack;}
                }
            }

            Text {
                id: idleBtnTxt;
                x: 60
                opacity: 1.0
                text: qsTr("马上连接")
                anchors.verticalCenter: parent.verticalCenter;
                font.pixelSize: 28
                color: "#FFFFFF"
            }
            Text {
                id: contBtnTxt;
                x: 60
                opacity: 0.0
                text: qsTr("加载中...")
                anchors.verticalCenter: parent.verticalCenter;
                font.pixelSize: 28
                color: "#FFFFFF"
                Behavior on opacity {
                    OpacityAnimator{duration: 300}
                }
            }
            Text {
                id: successBtnTxt;
                x: 60
                opacity: 0.0
                text: qsTr("连接成功")
                anchors.verticalCenter: parent.verticalCenter;
                font.pixelSize: 28
                color: "#FFFFFF"
                Behavior on opacity {
                    OpacityAnimator{duration: 300}
                }
            }
        }
    }

    /*##############Funtion################*/
    function setSuccessState() {
        control.state = "success";
    }
    function setConnectState() {
        control.state = "connect";
    }
    function setIdleState() {
        control.state = "idle";
    }
    /*##############Funtion################*/
}
