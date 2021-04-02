import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Popup {
    id: popup;
    leftPadding: 0
    topPadding: 0
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnReleaseOutsideParent

    background: Item{}

    signal updateText(string text, var valueArr);

    RectangularGlow {
        id: effect
        anchors.centerIn: content;
        width: content.width - glowRadius - glowRadius * spread
        height: content.height - glowRadius - glowRadius * spread
        glowRadius: 40
        spread: 0.2
        color: "#CFCFCF"
        cornerRadius: 0
    }
}
