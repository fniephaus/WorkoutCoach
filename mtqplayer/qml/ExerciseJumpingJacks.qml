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
        x: floor.width/2 - leftFootJumpingJacks.width - 500
        y: floor.height/2
        property bool down: false
        onMtqContactDown: {
            if(exerciseJumpingJacks.visible){
                down = true;
            }
        }
        onMtqContactUp: {
            if(exerciseJumpingJacks.visible){
                down = false;
            }
        }

        states: [
            State {
                name: "wide"
                PropertyChanges { target: leftFootJumpingJacks; x: floor.width/2 - leftFootJumpingJacks.width - 500;}
            },
            State {
                name: "close"
                PropertyChanges { target: leftFootJumpingJacks; x: floor.width/2 - leftFootJumpingJacks.width - 100;}
            }
        ]

        transitions: Transition {
            NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 50; }
        }
    }

    FootButton {
        id: rightFootJumpingJacks
        type: 'right'
        x: floor.width/2 + 500
        y: floor.height/2
        property bool down: false
        onMtqContactDown: {
            if(exerciseJumpingJacks.visible){
                down = true;

                if(leftFootJumpingJacks.down || floor.debug){
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
        }
        onMtqContactUp: {
            if(exerciseJumpingJacks.visible){
                down = false;
            }
        }
        
        states: [
            State {
                name: "wide"
                PropertyChanges { target: rightFootJumpingJacks; x: floor.width/2 + 500;}
            },
            State {
                name: "close"
                PropertyChanges { target: rightFootJumpingJacks; x: floor.width/2 + 100;}
            }
        ]

        transitions: Transition {
            NumberAnimation { properties: "x"; easing.type: Easing.InOutQuad; duration: 50; }
        }
    }

    Timer {
        id: exerciseTimerJumpingJacks
        interval: 1000
        repeat: true
        onTriggered: {
            if(exerciseCounter > 4 && !exerciseJumpingJacks.exerciseDone){
                if(seconds < exerciseDuration){
                    textJumpingJacks.text = (exerciseDuration-seconds) + "s to go!\n\n" + Math.floor(exerciseCounter/(seconds+1)*100)/100 + " taps per second";
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
            console.log('returnToMenuJumpingJacks triggered');
            hudText.visible = false;
            exerciseJumpingJacks.visible = false;
            selectionMenu.startMenu();
        }
    }

    function getRating(){
        var ratio = exerciseCounter/(seconds+1);
        var output = Math.floor(ratio*100)/100 + " taps per second\nare ";
        if(ratio < 1){
            output += "pretty bad!\n\nYour can do better than this!";
        }else if(ratio < 1.5){
            output += "not too good!\n\nTry to be better next time!";
        }else if(ratio < 2){
            output += "ok!\n\nBut you can still be better!";
        }else if(ratio < 2.5){
            output += "pretty good!\n\nCan you still beat this?!";
        }else{
            output += "very good!\n\nAwesome!!!";
        }
        return output;
    }
}