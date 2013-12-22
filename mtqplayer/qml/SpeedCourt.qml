import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: floor
    width: 4096
    height: 2400
    color: "#ff333333"
    property int clickCount: 0
    property int currentCorner: 0
    property bool cornerChecked: true


    function pickRandomChild() {
        clickCount+=1

        if(clickCount < 10)
        {
            cornerChecked = false;
            currentCorner = Math.floor(Math.random() * 4);
            centerButton.color = corners.children[currentCorner].color; return;
        } else {
            warmUpDone();
        }
    }

    function correctCornerTapped() {
        cornerChecked = true;
        centerButton.color = "white"
    }

    function warmUpDone() {
        corners.visible = false;
        centerButton.visible = false;
        exitButton.visible = false;
        centerFeet.visible = true;
        xxlText.visible = true;
    }

    FeetButton {
        id: centerFeet
        x: 1848
        y: 1000
        width: 400
        height: 400
        onPressed: {
            lText.visible = true;
            welcomeTimer.start()
        }
        Timer {
            id: welcomeTimer
            interval: 2000
            onTriggered: {
                instructionTimer.start()
            }
        }
        Timer {
            id: instructionTimer
            interval: 2000
            onTriggered: {
                lText.text = "<insert Instructions here>"
                getReadyTimer.start()
                exitButton.visible = true;
            }
        }
        Timer {
            id: getReadyTimer
            interval: 2000
            onTriggered: {
                lText.text = "Get ready!"
                startSpeedCourtTimer.start()
            }
        }
        Timer {
            id: startSpeedCourtTimer
            interval: 2000
            onTriggered: {
                lText.visible = false;
                parent.visible = false;
                centerButton.visible = true;
                corners.visible = true;
                floor.pickRandomChild();
            }
        }
    }

    Rectangle {
        id: centerButton
        x: 1548
        y: 700
        width: 1000
        height: 1000
        visible: false
        Rectangle {
            id: innerRect
            x: 300
            y: 300
            width: 400
            height: 400
            color: "#ff333333"
            visible: parent.visible
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if(cornerChecked){
                        floor.pickRandomChild();
                    }
                }
            }
        }

    }

    Text {
        id: xxlText
        x: 1848
        y: 400
        width: 400
        height: 200
        horizontalAlignment: Text.AlignHCenter
        text: "Warm up done!"
        visible: false
        font.pointSize: 200
        color: "white"
    }

    Text {
        id: lText
        x: 1848
        y: 400
        width: 400
        height: 200
        horizontalAlignment: Text.AlignHCenter
        text: "Let's start with\nyour warm-up!"
        visible: false
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
            warmUpDone();
        }
    }

    Item {
        id: corners
        visible: false
        Rectangle {
            id: topLeft
            x: 0
            y: 0
            width: 800
            height: 600
            color: "red"
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if(currentCorner == 0 ){
                        correctCornerTapped()
                    }
                }
            }
        }

        Rectangle {
            id: topRight
            x: 3296
            y: 0
            width: 800
            height: 600
            color: "blue"
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if(currentCorner==1) {
                        correctCornerTapped()
                    }
                }
            }
        }

        Rectangle {
            id: bottomLeft
            x: 0
            y: 1800
            width: 800
            height: 600
            color: "green"
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if(currentCorner == 2) {
                        correctCornerTapped()
                    }
                }
            }
        }

        Rectangle {
            id: bottomRight
            x: 3296
            y: 1800
            width: 800
            height: 600
            color: "yellow"
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if(currentCorner == 3) {
                        correctCornerTapped()
                    }
                }
            }
        }
     }
}
