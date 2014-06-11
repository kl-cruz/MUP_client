import QtQuick 2.0


/*
 * Top bar including Back button and Title text
 *
 */
Rectangle {
    id: topbar

    property alias titleText: title.text
    //property alias isExtraPageEnabled: extraPage.enabled
    z: 100
    width: parent.width
    height: parent.height / 11
    gradient: Gradient {
        GradientStop { position: 0.0; color: "#B0BCCC" }
        GradientStop { position: 1.0; color: "#6E84A2" }
    }

    //BackButton {}

    Text {
        id: title
        anchors.centerIn: parent
        font.pixelSize: parent.height / 3
        font.bold: true
        color: "white"
    }

    Rectangle {
        color: "#48576B"
        width: parent.width
        height: 1
        anchors.bottom: parent.bottom
    }
}

