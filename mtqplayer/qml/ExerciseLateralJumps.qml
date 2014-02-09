import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: exerciseLiteralJumps
    width: 4096
    height: 2400
    color: "#ff333333"

    property int exerciseCounter: 0
    property int exerciseDuration: 30
    property int seconds: 0
    property int trainingReps: 4
    property bool exerciseDone: false
    property bool leftDown: false
    property bool rightDown: false
    property bool hasStarted: false
    property bool leftTurn: false

    function start(){
        exerciseCounter = 0;
        exerciseDuration = 20;
        seconds = 0;
        hasStarted = false;
        exerciseDone = false;
        leftTurn = false;

        exerciseLiteralJumps.visible = true;
        textLiteralJumps.text = "The feet show you what to do.\nRepeat this!";

        rightFootLiteralJumps.state = "normal";
        leftFootLiteralJumps.state = "normal";
    }

    Text {
        id: textLiteralJumps
        x: parent.width/2 - width/2
        y: parent.height/8
        width: 200
        height: 200
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 100
        color: "white"
    }
    

    FootButton {
        id: leftFootLiteralJumps
        type: 'left'
        x: floor.width/2 - leftFootLiteralJumps.width - 600
        y: floor.height/2
        visible: false
        onMtqContactDown: {
            if(exerciseLiteralJumps.visible){

                if(leftTurn){
                    if(rightFootLiteralJumps.state == "normal" && leftFootLiteralJumps.state == "normal"){
                        leftFootLiteralJumps.state = "crossed";
                    }else{
                        leftFootLiteralJumps.state = "normal";
                        leftTurn = false;
                        if(exerciseTimerLiteralJumps.running){
                            exerciseCounter++;
                        }
                    }
                }else{
                    if(rightFootLiteralJumps.state == "normal" && leftFootLiteralJumps.state == "normal"){
                        rightFootLiteralJumps.state = "crossed";
                    }
                }
            }
        }

        state: "normal"

        states: [
            State {
                name: "normal"
                PropertyChanges { target: leftFootLiteralJumps; x: floor.width/2 - leftFootLiteralJumps.width - 600; y: floor.height/2;}
            },
            State {
                name: "crossed"
                PropertyChanges { target: leftFootLiteralJumps; x: floor.width/2 + 600 + leftFootLiteralJumps.width; y: floor.height/2 + leftFootLiteralJumps.height + 100;}
            }
        ]

        transitions: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.InOutQuad; duration: 100; }
        }
    }

    FootButton {
        id: rightFootLiteralJumps
        type: 'right'
        x: floor.width/2 + 600
        y: floor.height/2
        onMtqContactDown: {
            if(exerciseLiteralJumps.visible){

                if(!hasStarted){
                    exerciseTimerLiteralJumps.start();
                    hasStarted = true;
                    leftFootLiteralJumps.visible = true;
                }
                if(!leftTurn){
                    if(rightFootLiteralJumps.state == "normal" && leftFootLiteralJumps.state == "normal"){
                        rightFootLiteralJumps.state = "crossed";
                    }else{
                        rightFootLiteralJumps.state = "normal";
                        leftTurn = true;
                        if(exerciseTimerLiteralJumps.running){
                            exerciseCounter++;
                        }
                    }
                }else{
                    if(rightFootLiteralJumps.state == "normal" && leftFootLiteralJumps.state == "normal"){
                        leftFootLiteralJumps.state = "crossed";
                    }
                }
            }
        }

        state: "normal"
        
        states: [
            State {
                name: "normal"
                PropertyChanges { target: rightFootLiteralJumps; x: floor.width/2 + 600; y: floor.height/2;}
            },
            State {
                name: "crossed"
                PropertyChanges { target: rightFootLiteralJumps; x: floor.width/2 - leftFootLiteralJumps.width - 600 - rightFootLiteralJumps.width; y: floor.height/2 + rightFootLiteralJumps.height + 100;}
            }
        ]

        transitions: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.InOutQuad; duration: 100; }
        }
    }

    Timer {
        id: exerciseTimerLiteralJumps
        interval: 1000
        repeat: true
        onTriggered: {
            if(exerciseCounter > trainingReps && !exerciseLiteralJumps.exerciseDone){
                if(seconds < exerciseDuration){
                    textLiteralJumps.text = (exerciseDuration-seconds) + "s to go!\n\n" + getRepsPerSecond(exerciseDuration-seconds);
                    seconds++;
                }else{
                    exerciseLiteralJumps.exerciseDone = true;
                    textLiteralJumps.text = getRating();
                    returnToMenuLiteralJumps.start();
                }
            }
        }
    }

    Timer {
        id: returnToMenuLiteralJumps
        interval: 6000
        onTriggered: {
            console.log('returnToMenuLiteralJumps triggered');
            hudText.visible = false;
            exerciseLiteralJumps.visible = false;
            selectionMenu.startMenu();
        }
    }

    function getRepsPerSecond(secondsLeft){
        if(secondsLeft < 13 && secondsLeft > 10){
            return "Keep going!";
        }else{
            return Math.floor((exerciseCounter-trainingReps)/(seconds+1)*100)/100 + " reps per second";
        }
    }

    function getRating(){
        var ratio = (exerciseCounter-trainingReps)/(seconds+1);
        var output = Math.floor(ratio*100)/100 + " reps per second\nare ";
        if(ratio < 0.5){
            output += "pretty bad!\n\nYour can do better than this!";
        }else if(ratio < 0.8){
            output += "not too good!\n\nTry to be better next time!";
        }else if(ratio < 1){
            output += "ok!\n\nBut you can still be better!";
        }else if(ratio < 1.2){
            output += "pretty good!\n\nCan you still beat this?!";
        }else{
            output += "very good!\n\nAwesome!!!";
        }
        return output;
    }
}