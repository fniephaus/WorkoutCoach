import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: warmUp
    width: 4096
    height: 2400
    color: "#ff333333"
    
    property int step: 0
    property int clickCount: 0
    property int currentCorner: 0
    property bool cornerChecked: true
    property bool timeExpired: false
    property int warmUpTime: 20000
    property bool hasStarted: false
    property bool running: false
    property bool training: true


    function pickRandomChild() {
        clickCount++;
        if(timeExpired){
            warmUpDone();
        }else{
            cornerChecked = false;
            currentCorner = Math.floor(Math.random() * 4);
            centerButton.state = corners.children[currentCorner].targetState;
        }
    }

    function correctCornerTapped() {
        cornerChecked = true;
        centerButton.state = "white"
    }

    FeetButton {
        id: centerFeet
        x: 1848
        y: 1000
        width: 400
        height: 400
        onMtqContactDown: startWarmUp()
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
                if(warmUp.visible && cornerChecked && (warmUp.running || !warmUpTimer.running)){
                    if(training){
                        if(redArrow.visible){
                            redArrow.visible = false;
                            blueArrow.visible = true;
                            centerButton.state = "blue";
                            currentCorner = 1;
                            cornerChecked = false;
                        } else {
                            endTraining();
                        }
                    } else {
                        warmUp.pickRandomChild();
                    }
                }
            }
        }

        states: [
            State {
                name: "white"
                PropertyChanges { target: centerButton; color: "white" }
            },
            State {
                name: "red"
                PropertyChanges { target: centerButton; color: "red" }
            },
            State {
                name: "green"
                PropertyChanges { target: centerButton; color: "green" }
            },
            State {
                name: "blue"
                PropertyChanges { target: centerButton; color: "blue" }
            },
            State {
                name: "yellow"
                PropertyChanges { target: centerButton; color: "yellow" }
            }
        ]

        transitions: Transition {
            ColorAnimation { duration: 100 }
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
            property var targetState: "red"

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
            property var targetState: "blue"

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
            property var targetState: "green"
            
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
            property var targetState: "yellow"

            
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
        id: warmUpTimer
        property var callback: function(){console.log("emtpy callback")}
        interval: 1000
        onTriggered: {
            callback();
        }
    }

    function startWarmUp(){
        if(warmUp.visible && hasStarted == false){
            hudText.text = "Let's start with\nyour warm-up!";
            hudText.visible = true;
            hasStarted = true;
            callDelayed(function(){startTraining()});
            centerFeet.visible = false;
        }
    }

    function startTraining(){
        console.log('startInstructions called');
        hudText.visible = false;
        centerFeet.visible = false;
        centerButton.visible = true;
        corners.visible = true;
        redArrow.visible = true;
        centerButton.state = "red";
        currentCorner = 0;
        cornerChecked = false;
    }

    function endTraining(){
        blueArrow.visible = false;
        training = false;
        hudImage.visible = false;
        hudText.text = "Now try to repeat this\nas often as you can...";
        hudText.visible = true;
        callDelayed(function(){getReady()});
    }

    function getReady(){
        console.log('getReady called');
        hudText.text = "Get ready!";
        callDelayed(function(){startSpeedCourt()});
    }

    function startSpeedCourt(){
        console.log('startSpeedCourt called');
        hudText.visible = false;

        centerFeet.visible = false;
        centerButton.visible = true;
        corners.visible = true;
        warmUp.pickRandomChild();
        //reset clickCount
        clickCount = 0;
        warmUp.running = true;
        callDelayed(function(){endSpeedCourt()}, warmUpTime);
    }

    function endSpeedCourt(){
        warmUp.running = false;
        console.log('endSpeedCourt called');
        timeExpired = true;
    }

    function warmUpDone() {
        console.log("warmUpDone called");
        corners.visible = false;
        centerButton.visible = false;
        
        hudImage.visible = false;
        hudText.text = "Warm up done!\nYour score: " + clickCount;
        hudText.visible = true;
        callDelayed(function(){startSelectionMenu()}, 2000);
    }

    function startSelectionMenu(){
        console.log('startSelectionMenu called');
        warmUp.visible = false;
        selectionMenu.startMenu();
    }

    function callDelayed(callback, interval){
        if(!warmUpTimer.running){
            // default interval: 1000
            interval = typeof interval !== 'undefined' ? interval : 1000;
            warmUpTimer.callback = callback;
            warmUpTimer.interval = interval;
            warmUpTimer.start();
            console.log("Timer started (interval: " + interval + ")");
        }
    }
    
}

