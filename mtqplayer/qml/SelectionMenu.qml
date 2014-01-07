import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: floor
    width: 4096
    height: 2400
    color: "#ff333333"

    FeetButton {
        id: centerFeet
        x: 1848
        y: 1000
        width: 400
        height: 400
        onPressed: {
            lText.visible = false;
        }
    }


    Text {
        id: lText
        x: 1848
        y: 400
        width: 400
        height: 200
        horizontalAlignment: Text.AlignHCenter
        text: "Well done!\nNow make your selection!"
        visible: true
        font.pointSize: 100
        color: "white"
    }

    PushButton {
        id: exitButton
        x: 1898
        y: 2000
        width: 300
        text: "Skip warm-up"
        visible: false
        onPressed: {
        }
    }

    Item {
        id: corners
        visible: true
        Rectangle {
            id: topLeft
            x: 0
            y: 0
            width: 800
            height: 600
            color: "#ff888888"
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if(currentCorner == 0 ){
                        correctCornerTapped()
                    }
                }
            }
            Text {
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "Stretching"
                font.pointSize: 80
                color: "white"
            }
        }

        Rectangle {
            id: topRight
            x: 3296
            y: 0
            width: 800
            height: 600
            color: "#ff888888"
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if(currentCorner==1) {
                        correctCornerTapped()
                    }
                }
            }
            Text {
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "Cardio"
                font.pointSize: 80
                color: "white"
            }
        }

        Rectangle {
            id: bottomLeft
            x: 0
            y: 1800
            width: 800
            height: 600
            color: "#ff888888"
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if(currentCorner == 2) {
                        correctCornerTapped()
                    }
                }
            }
            Text {
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "BodyAttack"
                font.pointSize: 80
                color: "white"
            }
        }

        Rectangle {
            id: bottomRight
            x: 3296
            y: 1800
            width: 800
            height: 600
            color: "#ff888888"
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if(currentCorner == 3) {
                        correctCornerTapped()
                    }
                }
            }
            Text {
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "Whatever"
                font.pointSize: 80
                color: "white"
            }
        }
     }
}

