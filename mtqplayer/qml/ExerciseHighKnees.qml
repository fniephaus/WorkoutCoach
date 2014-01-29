import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: exerciseHighKnees
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

        exerciseHighKnees.visible = true;
        textHighKnees.text = "Lift your knees and\nalternately tap on the feet!";
    }

    Text {
        id: textHighKnees
        x: parent.width/2 - width/2
        y: parent.height/8
        width: 200
        height: 200
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 100
        color: "white"
    }
    

    FootButton {
        id: leftFoot
        type: 'left'
        x: floor.width/2 - leftFoot.width - 300
        y: floor.height/2
        property bool tapped: false
        onMtqContactDown: {
            if(exerciseHighKnees.visible){
                if(!exerciseHighKnees.hasStarted){
                    exerciseTimerHighKnees.start();
                    exerciseHighKnees.hasStarted = true;
                }

                tapped = true;
                if(!rightFoot.tapped && leftTurn){
                    exerciseCounter++;
                    leftTurn = false;
                }
            }
        }
        onMtqContactUp: {
            if(exerciseHighKnees.visible){
                tapped = false;
            }
        }
    }

    FootButton {
        id: rightFoot
        type: 'right'
        x: floor.width/2 + 300
        y: floor.height/2
        property bool tapped: false
        onMtqContactDown: {
            if(exerciseHighKnees.visible){
                if(!exerciseHighKnees.hasStarted){
                    exerciseTimerHighKnees.start();
                    exerciseHighKnees.hasStarted = true;
                }

                tapped = true;
                if(!leftFoot.tapped && !leftTurn){
                    exerciseCounter++;
                    leftTurn = true;
                }
            }
        }
        onMtqContactUp: {
            if(exerciseHighKnees.visible){
                tapped = false;
            }
        }
    }

    Timer {
        id: exerciseTimerHighKnees
        interval: 1000
        repeat: true
        onTriggered: {
            if(exerciseCounter > 4 && !exerciseHighKnees.exerciseDone){
                if(seconds < exerciseDuration){
                    textHighKnees.text = (exerciseDuration-seconds) + "s to go!\n\n" + Math.floor(exerciseCounter/(seconds+1)*100)/100 + " taps per second";
                    seconds++;
                }else{
                    exerciseHighKnees.exerciseDone = true;
                    textHighKnees.text = getRating();
                    returnToMenuHighKnees.start();
                }
            }
        }
    }

    Timer {
        id: returnToMenuHighKnees
        interval: 6000
        onTriggered: {
            console.log('returnToMenuHighKnees triggered');
            hudText.visible = false;
            exerciseHighKnees.visible = false;
            selectionMenu.startMenu();
        }
    }

    function getRating(){
        var ratio = exerciseCounter/(seconds+1);
        var output = Math.floor(ratio*100)/100 + " taps per second\nare ";
        if(ratio < 2){
            output += "pretty bad!\n\nYour can do better than this!";
        }else if(ratio < 3){
            output += "not too good!\n\nTry to be better next time!";
        }else if(ratio < 4){
            output += "ok!\n\nBut you can still be better!";
        }else if(ratio < 5){
            output += "pretty good!\n\nCan you still beat this?!";
        }else{
            output += "very good!\n\nAwesome!!!";
        }
        return output;
    }
}