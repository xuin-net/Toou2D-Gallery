import QtQuick 2.6
import QtQuick.Controls 2.0

Image {
    id: imgBtn
    source: imgSrc;
    property var imgSrc: null;
    property var checkImgSrc: imgSrc;
    property var uncheckImgSrc: imgSrc;
    property bool down: false;
    property bool isChecked: false;
    property bool checkable: true;

    property alias mouseAreaWidth: area.width;
    property alias mouseAreaHeight: area.height;
    property alias mouseAreaX: area.x;
    property alias mouseAreaY: area.y;

    signal clicked();
    signal pressed();
    signal released();
    signal exited();

    MouseArea{
        id: area;
        enabled: imgBtn.checkable
        x: ( imgBtn.width - area.width) /2
        y: ( imgBtn.height - area.height ) /2
        width: imgBtn.width;
        height: imgBtn.height;
        onPressed: {
            imgBtn.isChecked = true;
            imgBtn.down = true;
            imgBtn.pressed();
        }

        onReleased: {
            imgBtn.down = false;
            if(imgBtn.isChecked)
                imgBtn.clicked();
            imgBtn.isChecked = false;
            imgBtn.released();
        }

        onExited: {
            imgBtn.isChecked = false;
            imgBtn.exited();
        }

        onCanceled: {
            imgBtn.down = false;
        }
    }

    onDownChanged: {
        if (down) {
            imgBtn.source = imgBtn.checkImgSrc;
        } else {
            imgBtn.source = imgBtn.imgSrc;
        }
    }

    onCheckableChanged: {
        if (checkable) {
            imgBtn.source = imgBtn.imgSrc
        } else {
            imgBtn.source = imgBtn.uncheckImgSrc
        }
    }
}
