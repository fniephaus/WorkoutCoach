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
    property int warmUpTime: 30000
    property bool hasStarted: false
    property bool running: false
    property bool training: true
    property var colors: shuffle(["red", "blue", "darkgreen", "yellow", "deeppink", "lime", "orange", "purple"])


    function pickRandomChild() {
        clickCount++;
        if(timeExpired){
            warmUpDone();
        }else{
            cornerChecked = false;
            currentCorner = Math.floor(Math.random() * 4);
            centerButton.state = warmUp.colors[currentCorner];
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
        Text {
            x: 65
            y: 120
            text: "L"
            font.pointSize: 100
            color: "gray"
        }
        Text {
            x: 50 + parent.width/2
            y: 120
            text: "R"
            font.pointSize: 100
            color: "gray"
        }
    }

    Image {
        id: topLeftArrow
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
        id: bottomRightArrow
        width: 800
        height: 400
        x: 2550
        y: 1920 - height
        sourceSize.width: 800
        sourceSize.height: 600
        visible: false
        rotation: 390
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
                        if(topLeftArrow.visible){
                            topLeftArrow.visible = false;
                            bottomRightArrow.visible = true;
                            centerButton.state = warmUp.colors[3];
                            currentCorner = 3;
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
                name: "darkgreen"
                PropertyChanges { target: centerButton; color: "darkgreen" }
            },
            State {
                name: "blue"
                PropertyChanges { target: centerButton; color: "blue" }
            },
            State {
                name: "yellow"
                PropertyChanges { target: centerButton; color: "yellow" }
            },
            State {
                name: "deeppink"
                PropertyChanges { target: centerButton; color: "deeppink" }
            },
            State {
                name: "lime"
                PropertyChanges { target: centerButton; color: "lime" }
            },
            State {
                name: "orange"
                PropertyChanges { target: centerButton; color: "orange" }
            },
            State {
                name: "purple"
                PropertyChanges { target: centerButton; color: "purple" }
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
            property int cornerID: 0
            x: -800
            y: -800
            width: 1600
            height: 1600
            color: warmUp.colors[cornerID]
            radius: width * 0.5

            BaseWidget {
                anchors.fill: parent;
                onMtqContactDown: {
                    if(warmUp.visible && currentCorner == topLeft.cornerID ){
                        if(training && !cornerChecked){
                            topLeftArrow.rotation += 180;
                        }
                        correctCornerTapped()
                    }
                }
            }
        }

        Rectangle {
            id: topRight
            property int cornerID: 1
            x: 3296
            y: -800
            width: 1600
            height: 1600
            color: warmUp.colors[cornerID]
            radius: width * 0.5

            BaseWidget {
                anchors.fill: parent;
                onMtqContactDown: {
                    if(warmUp.visible && currentCorner == topRight.cornerID) {
                        correctCornerTapped()
                    }
                }
            }
        }

        Rectangle {
            id: bottomLeft
            property int cornerID: 2
            x: -800
            y: 1600
            width: 1600
            height: 1600
            color: warmUp.colors[cornerID]
            radius: width * 0.5
            
            BaseWidget {
                anchors.fill: parent;
                onMtqContactDown: {
                    if(warmUp.visible && currentCorner == bottomLeft.cornerID) {
                        correctCornerTapped()
                    }
                }
            }
        }

        Rectangle {
            id: bottomRight
            property int cornerID: 3
            x: 3296
            y: 1600
            width: 1600
            height: 1600
            color: warmUp.colors[cornerID]
            radius: width * 0.5
            
            BaseWidget {
                anchors.fill: parent;
                onMtqContactDown: {
                    if(warmUp.visible && currentCorner == bottomRight.cornerID) {
                        if(training && !cornerChecked){
                            bottomRightArrow.rotation += 180;
                        }
                        correctCornerTapped()
                    }
                }
            }
        }
     }

    Timer {
        id: warmUpTimer
        property var callback: function(){}
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
            centerFeet.visible = false;
            callDelayed(function(){startTraining()});
        }
    }

    function startTraining(){
        // console.log('startInstructions called');
        hudText.visible = false;
        centerFeet.visible = false;
        centerButton.visible = true;
        corners.visible = true;
        topLeftArrow.visible = true;
        centerButton.state = warmUp.colors[0];
        currentCorner = 0;
        cornerChecked = false;
    }

    function endTraining(){
        bottomRightArrow.visible = false;
        training = false;
        hudText.text = "Now try to repeat this\nas often as you can...";
        hudText.visible = true;
        callDelayed(function(){getReady()});
    }

    function getReady(){
        // console.log('getReady called');
        hudText.visible = true;
        hudText.text = "Get ready!";
        callDelayed(function(){startSpeedCourt()}, 2000);
    }

    function startSpeedCourt(){
        timeExpired = false;
        // console.log('startSpeedCourt called');
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
        // console.log('endSpeedCourt called');
        timeExpired = true;
    }

    function warmUpDone() {
        // console.log("warmUpDone called");
        corners.visible = false;
        centerButton.visible = false;
        
        hudText.text = "Warm up done!\nYour score: " + clickCount;
        hudText.visible = true;
        callDelayed(function(){startSelectionMenu()}, 2000);
    }

    function startSelectionMenu(){
        // console.log('startSelectionMenu called');
        warmUp.visible = false;
        selectionMenu.startMenu();
    }

    function restart(){
        warmUp.visible = true;
        getReady();
        centerButton.state = "white";
        centerButton.visible = true;
        corners.visible = true;
    }

    function callDelayed(callback, interval){
        if(!warmUpTimer.running){
            // default interval: 1000
            interval = typeof interval !== 'undefined' ? interval : 1000;
            warmUpTimer.callback = callback;
            warmUpTimer.interval = interval;
            warmUpTimer.start();
            // console.log("Timer started (interval: " + interval + ")");
        }
    }

    //helpers
    function shuffle(array) {
        var currentIndex = array.length
        , temporaryValue
        , randomIndex
        ;

        // While there remain elements to shuffle...
        while (0 !== currentIndex) {

            // Pick a remaining element...
            randomIndex = Math.floor(Math.random() * currentIndex);
            currentIndex -= 1;

            // And swap it with the current element.
            temporaryValue = array[currentIndex];
            array[currentIndex] = array[randomIndex];
            array[randomIndex] = temporaryValue;
        }

        return array;
    }
    
}

