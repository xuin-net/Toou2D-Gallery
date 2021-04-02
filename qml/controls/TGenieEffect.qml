import QtQuick 2.6

ShaderEffect {
    id: genieEffect
    property real minimize: 1.0
    property real bend: 1.0
    // 控制起始点的占宽度的比例
    property real side: 1.0
    // 收起时顶端保持的宽度比例[1.0-以点形状离场/0.0-保持宽度离场]
    property real minSide: 0.99

    property bool minimized: true

    property bool firstLoader: true;

    property alias imgSrc: img.source

    property variant source: Image {
        id: img
        visible: false
        onStatusChanged: {
            if (genieEffect.firstLoader && status == Image.Ready) {
                genieEffect.firstLoader = false;
                minimized = false;
            }
        }
    }

    signal normalizeAniFinish();

    mesh: GridMesh { resolution: Qt.size(16, 16) }

    ParallelAnimation {
        id: animMinimize
        running: !genieEffect.firstLoader && genieEffect.minimized

        SequentialAnimation {
            PauseAnimation { duration: 120 }
            UniformAnimator {
                target: genieEffect
                uniform: "minimize"
                from: 0
                to: 1
                duration: 280
                easing.type: Easing.InOutSine
            }
            PauseAnimation { duration: 400 }
        }
        SequentialAnimation {
            UniformAnimator {
                target: genieEffect
                uniform: "bend"
                from: 0
                to: minSide
                duration: 280
                easing.type: Easing.InOutSine
            }
            PauseAnimation { duration: 520 }
        }
    }

    ParallelAnimation {
        id: animNormalize
        running: !genieEffect.minimized
        SequentialAnimation {
            UniformAnimator {
                target: genieEffect
                uniform: "minimize"
                from: 1
                to: 0
                duration: 260
                easing.type: Easing.OutQuart
            }
            PauseAnimation { duration: 540 }
            ScriptAction{script: {genieEffect.normalizeAniFinish()}}
        }
        SequentialAnimation {
            UniformAnimator {
                target: genieEffect
                uniform: "bend"
                from: 1
                to: 0
                duration: 440
                easing.type: Easing.InOutSine
            }
            PauseAnimation { duration: 340 }
        }
    }

    vertexShader: "
        uniform highp mat4 qt_Matrix;
        attribute highp vec4 qt_Vertex;
        attribute highp vec2 qt_MultiTexCoord0;
        uniform highp float height;
        uniform highp float width;
        uniform highp float minimize;
        uniform highp float bend;
        uniform highp float side;
        varying highp vec2 qt_TexCoord0;
        void main() {
            qt_TexCoord0 = qt_MultiTexCoord0;
            highp vec4 pos = qt_Vertex;
            pos.y = mix(qt_Vertex.y, 0.0, minimize);
            highp float t = (height - pos.y) / height;
            t = (3.0 - 2.0 * t) * t * t;
            pos.x = mix(qt_Vertex.x, side * width, t * bend);
            gl_Position = qt_Matrix * pos;
        }"

    /*################Function###############*/
    function open() {
        minimized = false
    }

    function close() {
        minimized = true
    }
    /*################Function###############*/
}
