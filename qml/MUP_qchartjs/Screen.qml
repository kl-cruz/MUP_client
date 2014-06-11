import QtQuick 2.0

/*
 * Base Screen component with states and screen switch transition
 *
 */
Item {
    id: screen

    property Item previousScreen

    width: main.width
    height: main.height
    x: width

    //TopBar{ id: topbar }

    states: [
        State {
            name: "visible"
            PropertyChanges {
                target: screen
                x: 0
            }
        },
        State {
            name: "before"
            PropertyChanges {
                target: screen
                x: -screen.width
            }
        },
        State {
            name: "after"
            PropertyChanges {
                target: screen
                x: screen.width
            }
            onCompleted: {
                // Screen goes off the visible area, we can destroy the object
                screen.destroy()
            }
        }
    ]

    transitions: Transition {
        from: "*"
        to: "*"
        PropertyAnimation {
            target: screen; properties: "x"
            duration: 300; easing.type: Easing.InOutQuint
        }
    }
}
