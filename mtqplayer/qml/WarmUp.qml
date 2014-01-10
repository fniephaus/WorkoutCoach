import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: warmUp
    width: 4096
    height: 2400
    color: "#ff333333"
    
    property int clickCount: 0
    property int currentCorner: 0
    property bool cornerChecked: true
    property bool timeExpired: false
    property int warmUpTime: 10000
    property bool hasStarted: false


    function pickRandomChild() {
        clickCount++;
        if(timeExpired){
            warmUpDone();
        }else{
            cornerChecked = false;
            currentCorner = Math.floor(Math.random() * 4);
            centerButton.color = corners.children[currentCorner].color;
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
        
        hudImage.visible = false;
        hudText.text = "Warm up done!\nYour score: " + clickCount;
        hudText.visible = true;
        startSelectionMenu.start();
    }

    FeetButton {
        id: centerFeet
        x: 1848
        y: 1000
        width: 400
        height: 400
        onMtqTapDown: {
            if(hasStarted == false){
                hudText.text = "Let's start with\nyour warm-up!";
                hudText.visible = true;
                hasStarted = true;
                instructionTimer.start();
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
            BaseWidget {
                anchors.fill: parent;
                onMtqTapDown: {
                    if(cornerChecked){
                        warmUp.pickRandomChild();
                    }
                }
            }
        }

    }

    PushButton {
        id: exitButton
        x: 1898
        y: 2000
        width: 300
        text: "Skip warm-up"
        visible: false
        onMtqTapDown: {
            exitButton.visible = false;
            corners.visible = false;
            instructionTimer.stop();
            getReadyTimer.stop();
            startSpeedCourtTimer.stop();
            endSpeedCourtTimer.stop();
            hudImage.visible = false;
            hudText.text = "You're lazy!"
            hudText.visible = true;
            startSelectionMenu.start();
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
            BaseWidget {
                anchors.fill: parent;
                onMtqTapDown: {
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
            BaseWidget {
                anchors.fill: parent;
                onMtqTapDown: {
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
            BaseWidget {
                anchors.fill: parent;
                onMtqTapDown: {
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
            BaseWidget {
                anchors.fill: parent;
                onMtqTapDown: {
                    if(currentCorner == 3) {
                        correctCornerTapped()
                    }
                }
            }
        }
     }

    Timer {
        id: instructionTimer
        interval: 2000
        onTriggered: {
            hudText.visible = false;
            hudImage.source = "../resources/svg/InstructionsSpeedCourt.svg";
            hudImage.visible = true;
            exitButton.visible = true;

            getReadyTimer.start();
        }
    }
    Timer {
        id: getReadyTimer
        interval: 5000
        onTriggered: {
            hudImage.visible = false;
            hudText.text = "Get ready!";
            hudText.visible = true;

            startSpeedCourtTimer.start();
        }
    }
    Timer {
        id: startSpeedCourtTimer
        interval: 2000
        onTriggered: {
            hudText.visible = false;

            centerFeet.visible = false;
            centerButton.visible = true;
            corners.visible = true;
            warmUp.pickRandomChild();
            //reset clickCount
            clickCount = 0;
            endSpeedCourtTimer.start();
        }
    }
    Timer {
        id: endSpeedCourtTimer
        interval: warmUpTime
        onTriggered: {
            timeExpired = true;
        }
    }

    Timer {
        id: startSelectionMenu
        interval: 2000
        onTriggered: {
            warmUp.visible = false;
            selectionMenu.startSelectionMenu();
        }
    }

    
}

