import QtQuick 2.12

ShaderEffect {
    id: genieEffect
    property variant source
    property real minimize: 1.0
    property real bend: 1.0
    property bool minimized: true
    property real side: 1.0
    signal normalizeAniFinish();

    mesh: GridMesh { resolution: Qt.size(16, 16) }

    ParallelAnimation {
        id: animMinimize
        running: genieEffect.minimized
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
                to: 0.97
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
}
