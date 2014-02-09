import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: exerciseJumpingJacks
    width: 4096
    height: 2400
    color: "#ff333333"

    property int exerciseCounter: 0
    property int exerciseDuration: 20
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

        exerciseJumpingJacks.visible = true;
        textJumpingJacks.text = "It's Jumping Jacks time!\nYou know what to do, right?!";

        leftFootJumpingJacks.state = "wide";
        rightFootJumpingJacks.state = "wide";
    }

    Text {
        id: textJumpingJacks
        x: parent.width/2 - width/2
        y: parent.height/8
        width: 200
        height: 200
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 100
        color: "white"
    }
    

    FootButton {
        id: leftFootJumpingJacks
        type: 'left'
        x: floor.width/2 - leftFootJumpingJacks.width - 300
        y: floor.height/2

        states: [
            State {
                name: "wide"
                PropertyChanges { target: leftFootJumpingJacks; x: floor.width/2 - leftFootJumpingJacks.width - 300;}
            },
            State {
                name: "close"
                PropertyChanges { target: leftFootJumpingJacks; x: floor.width/2 - leftFootJumpingJacks.width - 80;}
            }
        ]

        transitions: Transition {
            NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 50; }
        }
        
        Text {
            x: 75
            y: 120
            text: "L"
            font.pointSize: 100
            color: "gray"
        }
    }

    FootButton {
        id: rightFootJumpingJacks
        type: 'right'
        x: floor.width/2 + 300
        y: floor.height/2
        onMtqContactDown: {
            if(exerciseJumpingJacks.visible){

                if(!hasStarted){
                    exerciseTimerJumpingJacks.start();
                    hasStarted = true;
                }
                if(rightFootJumpingJacks.state == "close"){
                    leftFootJumpingJacks.state = "wide";
                    rightFootJumpingJacks.state = "wide";
                }else{
                    leftFootJumpingJacks.state = "close";
                    rightFootJumpingJacks.state = "close";
                }
                if(exerciseTimerJumpingJacks.running){
                    exerciseCounter++;
                }
            }
        }
        
        states: [
            State {
                name: "wide"
                PropertyChanges { target: rightFootJumpingJacks; x: floor.width/2 + 300;}
            },
            State {
                name: "close"
                PropertyChanges { target: rightFootJumpingJacks; x: floor.width/2 + 80;}
            }
        ]

        transitions: Transition {
            NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 50; }
        }

        Text {
            x: 35
            y: 120
            text: "R"
            font.pointSize: 100
            color: "gray"
        }
    }

    Timer {
        id: exerciseTimerJumpingJacks
        interval: 1000
        repeat: true
        onTriggered: {
            if(exerciseCounter > trainingReps && !exerciseJumpingJacks.exerciseDone){
                if(seconds < exerciseDuration){
                    textJumpingJacks.text = (exerciseDuration-seconds) + "s to go!\n\n" + getRepsPerSecond(exerciseDuration-seconds);
                    seconds++;
                }else{
                    exerciseJumpingJacks.exerciseDone = true;
                    textJumpingJacks.text = getRating();
                    returnToMenuJumpingJacks.start();
                }
            }
        }
    }

    Timer {
        id: returnToMenuJumpingJacks
        interval: 6000
        onTriggered: {
            // console.log('returnToMenuJumpingJacks triggered');
            hudText.visible = false;
            exerciseJumpingJacks.visible = false;
            selectionMenu.startMenu();
        }
    }

    function getRepsPerSecond(secondsLeft){
        if(secondsLeft < 13 && secondsLeft > 10){
            return "Keep it going!";
        }else{
            return Math.floor((exerciseCounter-trainingReps)/(seconds+1)*100)/100 + " reps per second";
        }
    }

    function getRating(){
        var ratio = (exerciseCounter-trainingReps)/(seconds+1);
        var output = Math.floor(ratio*100)/100 + " reps per second\nare ";
        if(ratio < 0.5){
            output += "pretty bad!\n\nYour can do better than this!";
        }else if(ratio < 0.75){
            output += "not too good!\n\nTry to be better next time!";
        }else if(ratio < 1){
            output += "ok!\n\nBut you can still be better!";
        }else if(ratio < 1.4){
            output += "pretty good!\n\nCan you still beat this?!";
        }else{
            output += "very good!\n\nAwesome!!!";
        }
        return output;
    }
}