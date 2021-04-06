import QtQuick 2.6

Item {
    id:svgicon
    width:  image.width; height: image.height;

    property bool   asynchronous : true;

    property bool   smooth: true;

    property color  color;

    property string source;

    property alias status: image.status;

    Image {
        id:image
        asynchronous: svgicon.asynchronous;
        source:  svgicon.source;
        smooth: svgicon.smooth
        visible: false;
        enabled: false;
    }

    ShaderEffect {
        id: shaderItem
        property variant source: image
        property color   color: svgicon.color
        enabled: false;
        fragmentShader: "qrc:/assets/svg.cso"
        anchors.fill: parent;
        visible: svgicon.status === Image.Ready;
    }
}
