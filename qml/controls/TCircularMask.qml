import QtQuick 2.6
import QtGraphicalEffects 1.0

MouseArea {
    id: control
    enabled: false;

    // 动画结束后发射
    signal showAniFinish();
    // 动画结束后发射
    signal destoryAniFinish();

    /*###########Function###########*/
    function enter(_enterPoint) {
        control.enabled = true;
        enterAni.offsetPoint = _enterPoint;
        enterAni.start();
    }

    function exit(_exitPos) {
        control.enabled = false;
        exitAni.exitPosition = _exitPos;
        exitAni.start();
    }
    /*###########Function###########*/

    /*###########Content###########*/
    Item {
        id: maskImg
        visible: false;
        width: parent.width;height: parent.height

        Image {
            id: img
            scale: 0.0
            source: "qrc:/assets/maskRectangle.png"
        }

        SequentialAnimation {
            id: enterAni;
            property point offsetPoint: Qt.point(0,0)
            ParallelAnimation {
                PathAnimation {
                    path: Path {
                        startX: -960 + enterAni.offsetPoint.x
                        startY: -540 + enterAni.offsetPoint.y
                        PathLine { x: 0; y: 0}
                    }
                    target: img
                    duration: 480
                    easing.type: Easing.OutCubic
                }

                NumberAnimation{
                    target: img;property: "scale"
                    from: 0.0;to: 2.2;duration: 480
                    easing.type: Easing.OutCubic
                }
            }
            ScriptAction{script: { control.showAniFinish() }}
        }

        SequentialAnimation {
            id: exitAni;
            property point exitPosition: Qt.point(-960, -540)
            ParallelAnimation {
                PathAnimation {
                    path: Path {
                        startX: 0; startY: 0
                        PathLine { x: exitAni.exitPosition.x+35
                                   y: exitAni.exitPosition.y+30
                        }
                    }
                    target: img
                    duration: 480
                    easing.type: Easing.OutCubic
                }

                NumberAnimation{
                    target: img;property: "scale"
                    from: 2.2;to: 0.0;duration: 480
                    easing.type: Easing.OutCubic
                }
            }
            ScriptAction{script: {control.destoryAniFinish()}}
        }
    }

    layer.enabled: true;
    layer.effect: OpacityMask {
        maskSource: maskImg
    }
    /*###########Content###########*/
}
