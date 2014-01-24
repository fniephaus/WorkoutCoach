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
    property int warmUpTime: 20000
    property bool hasStarted: false
    property bool training: true


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
        onMtqContactDown: {
            if(warmUp.visible && hasStarted == false){
                hudText.text = "Let's start with\nyour warm-up!";
                hudText.visible = true;
                hasStarted = true;
                startInstructionsTimer.start();
                centerFeet.visible = false;
            }
        }
    }

    Image {
        id: redArrow
        width: 800
        height: 400
        x: 700
        y: 480
        sourceSize.width: 800
        sourceSize.height: 600
        visible: false
        rotation: 210
        source: "../resources/svg/WhiteArrow.svg"
    }


    Image {
        id: blueArrow
        width: 800
        height: 400
        x: 2550
        y: 480
        sourceSize.width: 800
        sourceSize.height: 600
        visible: false
        rotation: 330
        source: "../resources/svg/WhiteArrow.svg"
    }

    Rectangle {
        id: centerButton
        x: 1748
        y: 900
        width: 600
        height: 600
        visible: false
        radius: width * 0.5
        BaseWidget {
            anchors.fill: parent;
            onMtqContactDown: {
                if(warmUp.visible && cornerChecked && !getReadyTimer.running){
                    if(training){
                        if(redArrow.visible){
                            redArrow.visible = false;
                            blueArrow.visible = true;
                            centerButton.color = "blue";
                            currentCorner = 1;
                            cornerChecked = false;
                        } else {
                            blueArrow.visible = false;
                            training = false;
                            hudImage.visible = false;
                            hudText.text = "Now try to repeat this\nas often as you can...";
                            hudText.visible = true;
                            getReadyTimer.start();
                        }
                    } else {
                        warmUp.pickRandomChild();
                    }
                }
            }
        }

    }


    Item {
        id: corners
        visible: false
        
        Rectangle {
            id: topLeft
            x: -800
            y: -800
            width: 1600
            height: 1600
            color: "red"
            radius: width * 0.5
            BaseWidget {
                anchors.fill: parent;
                onMtqContactDown: {
                    if(warmUp.visible && currentCorner == 0 ){
                        if(training){
                            redArrow.rotation += 180;
                        }
                        correctCornerTapped()
                    }
                }
            }
        }

        Rectangle {
            id: topRight
            x: 3296
            y: -800
            width: 1600
            height: 1600
            color: "blue"
            radius: width * 0.5
            BaseWidget {
                anchors.fill: parent;
                onMtqContactDown: {
                    if(warmUp.visible && currentCorner==1) {
                        if(training){
                            blueArrow.rotation += 180;
                        }
                        correctCornerTapped()
                    }
                }
            }
        }

        Rectangle {
            id: bottomLeft
            x: -800
            y: 1600
            width: 1600
            height: 1600
            color: "green"
            radius: width * 0.5
            BaseWidget {
                anchors.fill: parent;
                onMtqContactDown: {
                    if(warmUp.visible && currentCorner == 2) {
                        correctCornerTapped()
                    }
                }
            }
        }

        Rectangle {
            id: bottomRight
            x: 3296
            y: 1600
            width: 1600
            height: 1600
            color: "yellow"
            radius: width * 0.5
            BaseWidget {
                anchors.fill: parent;
                onMtqContactDown: {
                    if(warmUp.visible && currentCorner == 3) {
                        correctCornerTapped()
                    }
                }
            }
        }
     }

    Timer {
        id: startInstructionsTimer
        interval: 1000
        onTriggered: {
            console.log('startInstructionsTimer triggered');
            hudText.visible = false;
            centerFeet.visible = false;
            centerButton.visible = true;
            corners.visible = true;
            redArrow.visible = true;
            centerButton.color = "red";
            currentCorner = 0;
            cornerChecked = false;
        }
    }

    Timer {
        id: getReadyTimer
        interval: 2000
        onTriggered: {
            console.log('startInstructionsTimer triggered');
            hudText.text = "Get ready!"
            startSpeedCourtTimer.start()
        }
    }

    Timer {
        id: startSpeedCourtTimer
        interval: 2000
        onTriggered: {
            console.log('startSpeedCourtTimer triggered');
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
            console.log('endSpeedCourtTimer triggered');
            timeExpired = true;
        }
    }

    Timer {
        id: startSelectionMenu
        interval: 2000
        onTriggered: {
            console.log('startSelectionMenu triggered');
            warmUp.visible = false;
            selectionMenu.startMenu();
        }
    }

    
}

