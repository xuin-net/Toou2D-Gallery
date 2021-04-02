import QtQuick 2.6
import QtQuick.Controls 2.0

BusyIndicator {
    id: control
    running: false;
    width: 172;height: 163
    font.pixelSize: 24

    property alias warnLabelVisable: warnLabel.visible
    property alias warnLabelText:   warnLabel.text;
    property alias warnLabelColor:  warnLabel.color;
    property alias warnLabelScale:  warnLabel.scale;
    property color delegateColor:   "#00BFB5";

    signal reSetPlayTime();
    signal renderFinish();

    background: Rectangle{
        visible: control.visible && control.running
        anchors.fill: parent;
        radius: 8
    }

    onRunningChanged: {
        if (!control.running) {
            delayTimer.stop();
            //timeOutWarnBox.visible = false;
        } else {
            repeater.currentIndex = 0;
            delayTimer.start();
        }
    }

    contentItem: Item {
        id: contentItem;
        implicitWidth: 42
        implicitHeight: 42
        visible: control.visible && control.running

        Item {
            id: item
            width: 42
            height: 42
            y: 32
            opacity: control.running ? 1 : 0
            anchors.horizontalCenter: parent.horizontalCenter;

            Repeater {
                id: repeater
                model: 12
                property int currentIndex: 0;
                Rectangle {
                    id: delegate;
                    x: item.width / 2 - width / 2
                    y: item.height / 2 - height / 2
                    implicitWidth: 5
                    implicitHeight: implicitWidth * 3 + 1
                    radius: implicitWidth
                    color: control.delegateColor
                    opacity: Math.floor((index + repeater.currentIndex)%12 + 1)/12

                    transform: [
                        Translate {
                            y: -Math.min(item.width, item.height) * 0.5 + 2
                        },
                        Rotation {
                            angle: index / repeater.count * 360
                            origin.x: delegate.implicitWidth/2
                            origin.y: delegate.implicitHeight/2
                        }
                    ]
                }
            }

            Timer {
                interval: 120;repeat: true;
                running: control.visible && control.running
                onTriggered: {
                   repeater.currentIndex --
                    if (repeater.currentIndex == -1)
                        repeater.currentIndex = 11;
                }
            }
        }

        Text {
            id: warnLabel;
            font: control.font
            color: "#464646"
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.bottom: parent.bottom;
            anchors.bottomMargin: 26;
            text: qsTr("正在加载")
        }
    }

    Timer {
        id: delayTimer;
        interval: 160;repeat: false;
        onTriggered: {
            control.renderFinish();
        }
    }
}
