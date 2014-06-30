import QtQuick 2.0

/*
 * The main QML-file that is loaded first.
 * Handles loading of the XML-data.
 *
 */
Rectangle {
    id: main

    width: 1024
    height: 600

    // Background gradient
    gradient: Gradient {
        GradientStop { position: 0.0; color: "white" }
        GradientStop { position: 1.0; color: "gray" }
    }

    StartScreen {
        state: "visible"
    }
}


