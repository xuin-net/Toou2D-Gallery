import QtQuick 2.6
import QtGraphicalEffects 1.0

Item {
    id: toou2d_rectangularGlow

    property alias color:       content.color
    property alias radiu:       content.radius
    property alias glowRadius:  effect.glowRadius
    property alias spread:      effect.spread
    property alias glowColor:   effect.color

    RectangularGlow {
        id: effect
        anchors.centerIn: content;
        width: content.width - glowRadius - glowRadius * spread
        height: content.height - glowRadius - glowRadius * spread
        glowRadius: 40
        spread: 0.2
        color: "#CFCFCF"
        cornerRadius: content.radius + spread
    }

    Rectangle {
        id: content
        width: toou2d_rectangularGlow.width;
        height: toou2d_rectangularGlow.height;
    }

}
