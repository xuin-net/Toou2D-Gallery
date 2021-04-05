import QtQuick 2.6
import QtQuick.Layouts 1.0
import "../controls" as Controls

Item {
    id: viewPage
    anchors.fill: parent;

    Controls.TButton {
        font.pixelSize: 20;
        baseColor: "#00BFB5"
        textColor: "#FFFFFF";
        radius: height

        text: qsTr("设置为数量选择模式")

        anchors.left: dateSelect.right
        anchors.top: parent.top
        anchors.leftMargin: 16
        anchors.topMargin: 16

        onClicked: {
            // countSelect type
            datePicker.pageType = 1

            var nowDate = new Date();
            var testData = [
                        {
                            time: nowDate.getFullYear(),
                            children: [
                                {
                                    time: nowDate.getMonth() + 1,
                                    children: [
                                        {
                                            time: 1,
                                            count: 1,
                                            children: [ ]
                                        },
                                        {
                                            time: 2,
                                            count: 3,
                                            children: [ ]
                                        },
                                        {
                                            time: 3,
                                            count: 5,
                                            children: [ ]
                                        },
                                        {
                                            time: 5,
                                            count: 4,
                                            children: [ ]
                                        },
                                        {
                                            time: 6,
                                            count: 86,
                                            children: [ ]
                                        },
                                        {
                                            time: 7,
                                            count: 45,
                                            children: [ ]
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
            datePicker.updateModel(testData)
        }
    }

    Rectangle {
        id: dateSelect
        height: 42;radius: 42
        width: layout.implicitWidth + 64
        color: enabled ? "#FFFFFF" : "#F5F7FA"
        border.width: 1
        border.color: datePicker.isOpen ? "#00BFB5" : "#C0C4CC"

        anchors.top: viewPage.top
        anchors.left: viewPage.left
        anchors.leftMargin: 32
        anchors.topMargin: 16

        property var dateArr: []

        MouseArea {
            anchors.fill: parent;
            onClicked: {
                datePicker.openBox(Qt.point(viewPage.parent.x + dateSelect.x,
                                            dateSelect.y + 54),
                                   dateSelect.dateArr)
            }
        }
        RowLayout {
            id: layout
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 16
            spacing: 12
            Image {
                source: "qrc:/assets/Icon/Icon_datepicker_date.png"
            }
            RowLayout {
                spacing: 6
                Text {
                    id: startDateText
                    Layout.preferredWidth: 112
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 18
                    color: dateText == "" ? "#C0C4CC" : "#606266"
                    text: dateText == "" ? qsTr("开始日期") : dateText
                    property string dateText: ""
                }
                Text {
                    text: qsTr("至")
                    font.pixelSize: 18
                    color: (startDateText.dateText == "" && stopDateText.dateText == "") ? "#C0C4CC" : "#606266"
                }
                Text {
                    id: stopDateText
                    Layout.preferredWidth: 112
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 18
                    color: dateText == "" ? "#C0C4CC" : "#606266"
                    text: dateText == "" ? qsTr("结束日期") : dateText
                    property string dateText: ""
                }
            }
        }
        Controls.TImageButton {
            mouseAreaWidth: 42
            mouseAreaHeight: 42
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 16
            visible: (startDateText.dateText == "" && stopDateText.dateText == "") ? false : true
            imgSrc: "qrc:/assets/Icon/Icon_datepicker_delete.png"
            onClicked: {
                dateSelect.clearFilterDate()
                //updateCaseAndDateList(page.caseTimeLineInfos)
            }
        }
        Controls.TDatePicker {
            id: datePicker

            onSendStartDate: {
                // s_d eg:2021.04.4
                startDateText.dateText = s_d
            }

            onSendStartEndDate: {
                // s_d / e_d eg:2021.04.4
                // dateArr   eg:[[2021,4,5],[2021,4,6]]
                startDateText.dateText = s_d
                stopDateText.dateText = e_d
                dateSelect.dateArr = dateArr
            }
        }

        function setDateMenuDate(s_d, e_d, arr) {
            startDateText.dateText = s_d
            stopDateText.dateText = e_d
            dateSelect.dateArr = arr
        }

        function clearFilterDate() {
            startDateText.dateText = ""
            stopDateText.dateText = ""
            dateSelect.dateArr = []
        }
    }

}
