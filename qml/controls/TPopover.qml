import QtQuick 2.6
import QtGraphicalEffects 1.0

TPopup {
    id: popover

    property alias mainLabelText: mainLabel.text;
    property alias subLabelText: subLabel.text;

    property int errorCode: 0;
    property string errorType: ""

    signal cancelClick();
    signal submitClick();
    signal retryClick();
    signal cancelPopover();

    childitem : [
        Rectangle {
            y: 306
            anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
            width: 485;height: 206
            color: "#fff"

            Rectangle {
                width: 485;height: 30
                color: "#00BFB5"

                Image {
                    anchors.right: parent.right;
                    anchors.rightMargin: 16
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/com.aiyunji.lpm.res/UKFault404_btn_03.png"
                }

                MouseArea {
                    width: parent.height
                    height: parent.height;
                    anchors.right: parent.right
                    anchors.rightMargin: 8
                    onClicked:  {
                        popover.cancelPopover();
                        close();
                    }
                }
            }

            Row {
                anchors.bottom: parent.bottom;
                anchors.right: parent.right
                anchors.margins: 24
                spacing: 14
                TImageButton {
                    id: cancelBtn
                    visible: (errorType != "authError" && errorType != "unknowError")
                             ? true : false;
                    imgSrc: "qrc:/com.aiyunji.lpm.res/UKFault404_btn_04.png"
                    checkImgSrc: "qrc:/com.aiyunji.lpm.res/UKFault404_btn_06.png"

                    onClicked: {
                        popover.cancelClick();
                    }
                }

                TImageButton {
                    id: sumitBtn
                    visible: (errorType != "authError" && errorType != "unknowError")
                             ? true : false;
                    imgSrc: "qrc:/com.aiyunji.lpm.res/UKFault404_btn_05.png"
                    checkImgSrc: "qrc:/com.aiyunji.lpm.res/UKFault404_btn_07.png"

                    onClicked: {
                        popover.submitClick();
                    }
                }

                TImageButton {
                    id: retryBtn
                    visible: (errorType == "authError" || errorType == "unknowError") ? true : false;
                    imgSrc: "qrc:/com.aiyunji.lpm.res/Fail506_btn_01.png"
                    checkImgSrc: "qrc:/com.aiyunji.lpm.res/Fail506_btn_02.png"

                    onClicked: {
                        popover.retryClick();
                    }
                }
            }

            Item {
                id: warnBox;

                Rectangle {
                    id: warnIcon
                    x: 32;y: 55
                    width: 36;height: 36
                    radius: 36;
                    color: "#297AFF"
                    Image {
                        anchors.centerIn: parent;
                        source: "qrc:/com.aiyunji.lpm.res/UKFault404_icon_02.png"
                    }
                }

                Column {
                    anchors.left: warnIcon.right;
                    anchors.leftMargin: 16
                    anchors.top: warnIcon.top;
                    spacing: 14
                    Text {
                        id: mainLabel;
                        font.pixelSize: 24
                        color: "#464646"
                    }

                    Text {
                        id: subLabel;
                        font.pixelSize: 16
                        width: 380
                        wrapMode: Text.WordWrap
                        color: "#848484"
                    }
                }
            }

            layer.enabled: true;
            layer.effect: OpacityMask {
                maskSource: Rectangle {
                    width: 485;height: 206
                    radius: 8
                }
            }
        }
    ]
}
