import QtQuick 2.6
import QtQuick.Layouts 1.0

ListView {
    id: notifyView;
    width: 454;height: parent.height;
    spacing: 15
    y: 24
    cacheBuffer: 750
    interactive: false;

    model: notifyModel;
    delegate: notifyDelegate;

    add: Transition {
        id: addTrans
        NumberAnimation {
            property: "y"
            from: addTrans.ViewTransition.destination.y - 80;
            to: addTrans.ViewTransition.destination.y;
            duration: 400;
            easing.type: Easing.OutQuad
        }
        NumberAnimation {
            property: "opacity"
            to: 1.0;duration: 400
        }
    }

    displaced: Transition {
        NumberAnimation{property: "opacity";to: 1.0;}
        NumberAnimation{property: "y";duration: 300;}
    }

    remove: Transition {
        id: removeTrans
        NumberAnimation {
            property: "y";
            from: removeTrans.ViewTransition.item.y;
            to: removeTrans.ViewTransition.item.y - 80
            duration: 400;easing.type: Easing.InQuad
        }
        NumberAnimation {property: "opacity";to: 0.0;duration: 400;}
    }

    ListModel {
        id: notifyModel;
    }

    Component {
        id: notifyDelegate;
        Rectangle {
            id: delegateItem;
            opacity: 0.0
            width: contentRow.width + 36;height: 56;
            anchors.horizontalCenter: parent.horizontalCenter;
            radius: 4;
            color: {
                switch (alertType) {
                    case "fail":
                        return "#FFECEE"
                    case "warning":
                        return "#FDF6EC"
                    case "success":
                    default:
                        return "#EBFAFA";
                }
            }
            border.width: 0.5
            border.color: {
                switch (alertType) {
                    case "fail":
                        return "#FF435A"
                    case "warning":
                        return "#E6A23C"
                    case "success":
                    default:
                        return "#00BFB5";
                }
            }

            RowLayout {
                id: contentRow
                spacing: 8
                Layout.fillWidth: true;
                anchors.centerIn: parent;
                Image {
                    id: notifyIcon
                    source: {
                        switch (alertType) {
                            case "fail":
                                return "qrc:/assets/Icon/Icon_Error_20_20_01.png"
                            case "warning":
                                return "qrc:/assets/Icon/Icon_message_error.png"
                            case "success":
                            default:
                                return "qrc:/assets/Icon/Icon_Successful_20_20_01.png";
                        }
                    }
                }

                Text {
                    id: notifyContent;
                    text: contentText
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    color: {
                        switch (alertType) {
                            case "fail":
                                return "#FF435A"
                            case "warning":
                                return "#E6A23C"
                            case "success":
                            default:
                                return "#00BFB5";
                        }
                    }
                }
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

    function appendMessage(_type,_text) {
        // alertType [success/fail/warning]
        if (!hasShow(_text)) {
            notifyModel.append({contentText: _text,alertType: (_type ? _type : "success")})
        }
    }

    function hasShow(_text) {
        for (var i=0;i<notifyModel.count;++i) {
            if (notifyModel.get(i).contentText == _text) {
                return true;
            }
        }
        return false;
    }
}
