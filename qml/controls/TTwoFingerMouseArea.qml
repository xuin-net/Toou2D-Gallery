import QtQuick 2.6

MultiPointTouchArea {
    id: area
    // 动作：双指双击
    signal doubleClicked();
    // 动作：单指点击
    signal singleClicked();
    // 手势：单指向上滑动
    signal singleUpFlick();

    touchPoints: [
        TouchPoint {
            id: point1
            property bool hasFistClick: false;
            property real lastSceneY: 0
            onPressedChanged: {
                if(pressed){
                    if(point1.hasFistClick){
                        if(point2.hasFistClick){
                            if(!point3.hasFistClick){
                                area.doubleClicked()
                            }
                            point1.hasFistClick = false
                        }
                    }else{
                        point1.hasFistClick = true;
                        timeOut1.start();
                    }
                }else{
                    lastSceneY = 0
                    if(!point2.hasFistClick){
                        area.singleClicked();
                    }
                }
            }
            onSceneYChanged: {
                if (lastSceneY > sceneY) {
                    area.singleUpFlick()
                }
                lastSceneY = sceneY
            }
        },
        TouchPoint {
            id: point2
            property bool hasFistClick: false;
            onPressedChanged: {
                if(pressed){
                    if(point2.hasFistClick){
                        if(point1.hasFistClick){
                            if(!point3.hasFistClick){
                                area.doubleClicked()
                            }
                            point2.hasFistClick = false
                        }
                    }else{
                        point2.hasFistClick = true;
                        timeOut2.start();
                    }
                }
            }
        },
        TouchPoint {
            id: point3
            property bool hasFistClick: false;
            onPressedChanged: {
                if(pressed){
                    if(point3.hasFistClick){

                    }else{
                        point3.hasFistClick = true;
                        timeOut3.start();
                    }
                }
            }
        }
    ]

    Timer{
        id: timeOut1;
        interval: 600;repeat: false;
        onTriggered: {
            point1.hasFistClick = false;
        }
    }

    Timer{
        id: timeOut2;
        interval: 600;repeat: false;
        onTriggered: {
            point2.hasFistClick = false;
        }
    }

    Timer{
        id: timeOut3;
        interval: 600;repeat: false;
        onTriggered: {
            point3.hasFistClick = false;
        }
    }
}
