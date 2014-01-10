import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: exerciseLunges
    width: 4096
    height: 2400
    color: "#ff333333"

    property int exerciseCounter: 4
    property int exerciseDuration: 4
    property bool leftFootTurn: true
    property bool leftDown: false
    property bool rightDown: false
    property bool hasStarted: false


    function start(){
        exerciseLunges.visible = true;
        timerText.text = "4s";
        hudImage.source = "../resources/svg/InstructionsLunges.svg";
        hudImage.visible = true;
        hudImage.width = 900;
        hudImage.height = 454;
        hudImage.rotation = 30;
        hudImage.x = leftFoot.x + hudImage.height/2;
    }


    function switchFoot(){
        exerciseCounter--;

        hudImage.visible = false;

        if(exerciseCounter>0){
            leftFootTurn = !leftFootTurn;
            if (leftFootTurn){
                leftFoot.y = 400;
                rightFoot.y = 1600;
            }else{
                leftFoot.y = 1600;
                rightFoot.y = 400;
            }
        }else{
            exerciseTimer.stop();
            timerText.visible = false;

            hudText.text = "Well done!";
            hudText.visible = true;
            leftFoot.visible = false;
            rightFoot.visible = false;
            returnToMenu.start();
        }
    }

    Text {
        id: debug
        x: 700
        y: 200
        width: 400
        height: 200
        horizontalAlignment: Text.AlignHCenter
        text: "debug"
        font.pointSize: 50
        color: "white"
        visible: false
    }

    Text {
        id: timerText
        x: floor.width * 1/4
        y: 500
        width: 400
        height: 200
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 100
        color: "white"
    }
    
    Rectangle {
        id: exerciseWrapper
        color: "#00000000"
        width: 2400
        height: 2400
        x: 848
        // rotation: 90

        FootButton {
            id: leftFoot
            type: 'left'
            x: exerciseWrapper.width/2 - leftFoot.width/2
            y: 400
            onMtqTapDown: {
                leftDown = true;
                if(!hasStarted && (true || rightDown)){
                    exerciseLunges.start();
                    hasStarted = true;
                }
                if(true || rightDown){
                    exerciseTimer.start();
                }

                debug.text = "rightDown: " + rightDown + " - leftDown: " + leftDown;
            }
            onMtqTapUp: {
                leftDown = false;
                exerciseTimer.stop();

                debug.text = "rightDown: " + rightDown + " - leftDown: " + leftDown;
            }
        }
        FootButton {
            id: rightFoot
            type: 'right'
            x: exerciseWrapper.width/2 + rightFoot.width/2 + 20
            y: 1600
            onMtqTapDown: {
                rightDown = true;
                if(!hasStarted && (true || leftDown)){
                    exerciseLunges.start();
                    hasStarted = true;
                }
                if(true || leftDown){
                    exerciseTimer.start();
                }

                debug.text = "rightDown: " + rightDown + " - leftDown: " + leftDown;
            }
            onMtqTapUp: {
                rightDown = false;
                exerciseTimer.stop();

                debug.text = "rightDown: " + rightDown + " - leftDown: " + leftDown;
            }
        }
    }

    Timer {
        id: exerciseTimer
        interval: 1000
        property int value: exerciseDuration + 1
        repeat: true
        triggeredOnStart: true;
        onTriggered: {
            value--;
            if(value>0){
                timerText.text = value + "s";
            }else{
                exerciseLunges.switchFoot();
                timerText.text = "Switch feet";
                value = exerciseDuration + 1;
            }
            exerciseTimer.start();
        }
    }

    Timer {
        id: returnToMenu
        interval: 2000
        onTriggered: {
            hudText.visible = false;
            exerciseLunges.visible = false;
            selectionMenu.startSelectionMenu();
        }
    }
}