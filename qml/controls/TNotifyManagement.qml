import QtQuick 2.6

Item {
    id: notity;

    ListView {
        id: notifyView;
        width: parent.width;height: parent.height;
        spacing: 8
        cacheBuffer: 750
        interactive: false;

        model: notifyModel;
        delegate: notifyDelegate;

        add: Transition {
            NumberAnimation {
                alwaysRunToEnd: true;
                property: "x"
                from: notifyView.width
                to: 0;
                duration: 400;
                easing.type: Easing.OutBack;
                easing.overshoot: 0.7
            }
        }

        displaced: Transition {
             NumberAnimation {property: "y";duration: 300;easing.type: Easing.OutQuad}
        }

        remove: Transition {
            id: removeTrans
            NumberAnimation {property: "y";to: removeTrans.ViewTransition.item.y + 60;duration: 200}
            NumberAnimation {property: "opacity";to: 0.0;duration: 200;}
        }
    }

    ListModel {
        id: notifyModel;
    }

    Component {
        id: notifyDelegate;
        Item {
            width: 454;height: 75;
            Rectangle {
                id: delegateItem;
                width: 430;height: 75;
                anchors.horizontalCenter: parent.horizontalCenter;
                radius: 3;
                color: "#F0F0F0"

                Rectangle {
                    id: notifyRect;
                    width: 13;height: parent.height;
                    radius: 3;
                    color: "#2470F5"
                    layer.enabled: true
                    Rectangle {
                        width: 3;height: notifyRect.height;
                        color: notifyRect.color;
                        anchors.left: notifyRect.right;
                        anchors.leftMargin: -3;
                    }
                }

                Image {
                    id: notifyIcon
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.left: notifyRect.right;
                    anchors.leftMargin: 17;
                    source: "qrc:/assets/Icon/Icon_New_01.png"
                }

                Text {
                    id: notifyContent;
                    text: contentText
                    anchors.verticalCenter: notifyIcon.verticalCenter
                    anchors.left: notifyIcon.right;
                    anchors.leftMargin: 8
                    font.pixelSize: 22
                    color: "#878889"
                }

                Timer {
                    id: timeOut
                    running: true;
                    interval: 3000;repeat: false;
                    onTriggered: {
                        notifyModel.remove(index);
                    }
                }
            }
        }
    }

    function appendMessage(_text) {
        notifyModel.insert(0,{contentText: _text})
    }
}
