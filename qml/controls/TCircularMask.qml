import QtQuick 2.6
import QtGraphicalEffects 1.0

MouseArea {
    id: control
    enabled: false;

    property int duration: 480;

    // 动画结束后发射
    signal showAniFinish();
    // 动画结束后发射
    signal destoryAniFinish();

    /*###########Function###########*/
    function enter(_enterPoint) {
        control.enabled = true;
        control.visible = true;
        enterAni.offsetPoint = _enterPoint;
        enterAni.start();
    }

    function exit(_exitPos) {
        control.enabled = false;
        exitAni.exitPosition = Qt.point(_exitPos.x - control.width/2,
                                        _exitPos.y - control.height/2);
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
            width: parent.width
            height: parent.height
            fillMode: Image.PreserveAspectFit
            source: "qrc:/assets/maskRectangle.png"
        }

        SequentialAnimation {
            id: enterAni;
            property point offsetPoint: Qt.point(0,0)
            ParallelAnimation {
                PathAnimation {
                    path: Path {
                        startX: -control.width/2 + enterAni.offsetPoint.x
                        startY: -control.height/2 + enterAni.offsetPoint.y
                        PathLine { x: 0; y: 0}
                    }
                    target: img
                    duration: control.duration
                    easing.type: Easing.OutCubic
                }

                NumberAnimation{
                    target: img;property: "scale"
                    from: 0.0;to: 2.2;duration: control.duration
                    easing.type: Easing.OutCubic
                }
            }
            ScriptAction{script: { control.showAniFinish() }}
        }

        SequentialAnimation {
            id: exitAni;
            property point exitPosition: Qt.point(-control.width/2, -control.height/2)
            ParallelAnimation {
                PathAnimation {
                    path: Path {
                        startX: 0; startY: 0
                        PathLine { x: exitAni.exitPosition.x
                                   y: exitAni.exitPosition.y
                        }
                    }
                    target: img
                    duration: control.duration
                    easing.type: Easing.OutCubic
                }

                NumberAnimation{
                    target: img;property: "scale"
                    from: 2.2;to: 0.0;duration: control.duration
                    easing.type: Easing.OutCubic
                }
            }
            ScriptAction{script: {
                    control.destoryAniFinish();
                    control.visible = false;
                }}
        }
    }

    layer.enabled: true;
    layer.effect: OpacityMask {
        maskSource: maskImg
    }
    /*###########Content###########*/
}
