import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: exerciseLunges
    width: 4096
    height: 2400
    color: "#ff333333"

    property int exerciseCounter: 8
    property int exerciseDuration: 8
    property bool leftFootTurn: true
    property bool leftDown: false
    property bool rightDown: false
    property bool hasStarted: false
    property bool debug: true


    function startLunges(){
        exerciseLunges.visible = true;

        rightTextLunges.text = exerciseDuration + "s";
        rightTextLunges.visible = true;

    }

    function exerciseInProgess(){
        return exerciseCounter>0;
    }


    function switchFoot(){
        exerciseCounter--;

        instructionsLunges.visible = false;

        if(exerciseInProgess()){
            leftFootTurn = !leftFootTurn;
            if (leftFootTurn){
                rightFoot.state = "back";
                leftFoot.state = "front";
            }else{
                rightFoot.state = "front";
                leftFoot.state = "back";
            }

            rightTextLunges.visible = !rightTextLunges.visible;
            leftTextLunges.visible = !leftTextLunges.visible;
        }else{
            exerciseTimer.stop();


            rightTextLunges.visible = leftTextLunges.visible = false;

            hudText.text = "Well done!";
            hudText.visible = true;
            leftFoot.visible = false;
            rightFoot.visible = false;
            returnToMenu.start();
        }
    }

    Image {
        id: instructionsLunges
        source: "../resources/svg/InstructionsLunges.svg"
        width: 900
        height: 454
        y: parent.height/4
        x: parent.width/2 + width/2 + 50
        rotation: 30
    }

    Text {
        id: rightTextLunges
        x: parent.width/2 + width/2 + 200
        y: parent.height/4 - 150
        width: 200
        height: 200
        horizontalAlignment: Text.AlignHCenter
        visible: false
        font.pointSize: 100
        color: "white"
        text: "4s"
        rotation: 30
    }

    Text {
        id: leftTextLunges
        x: parent.width/2 - width/2 - 200
        y: parent.height/4 - 150
        width: 200
        height: 200
        horizontalAlignment: Text.AlignHCenter
        visible: false
        font.pointSize: 100
        color: "white"
        text: "3s"
        rotation: -30
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
            onMtqContactDown: {
                if(exerciseLunges.visible){
                    leftDown = true;
                    if(!hasStarted && (debug || rightDown)){
                        exerciseLunges.startLunges();
                        hasStarted = true;
                    }
                    if((debug || rightDown)){
                        exerciseTimer.start();
                    }

                }
            }
            onMtqContactUp: {
                if(exerciseLunges.visible){
                    leftDown = false;
                    exerciseTimer.stop();
                }
            }

            states: [State {
                name: "front"
                PropertyChanges { target: leftFoot; y: 400; duration: 2000; }
            },State {
                name: "back"
                PropertyChanges { target: leftFoot; y: 1600; duration: 2000; }
            }]

            transitions: Transition {
                NumberAnimation { properties: "y"; easing.type: Easing.InOutQuad }
            }
        }
        FootButton {
            id: rightFoot
            type: 'right'
            x: exerciseWrapper.width/2 + rightFoot.width/2 + 20
            y: 1600
            onMtqContactDown: {
                if(exerciseLunges.visible){
                    rightDown = true;
                    if(!hasStarted && (debug || leftDown)){
                        exerciseLunges.startLunges();
                        hasStarted = true;
                    }
                    if((debug || leftDown)){
                        exerciseTimer.start();
                    }

                }
            }

            onMtqContactUp: {
                if(exerciseLunges.visible){
                    rightDown = false;
                    exerciseTimer.stop();
                }
            }

            states: [State {
                name: "front"
                PropertyChanges { target: rightFoot; y: 400; duration: 2000; }
            },State {
                name: "back"
                PropertyChanges { target: rightFoot; y: 1600; duration: 2000; }
            }]

            transitions: Transition {
                NumberAnimation { properties: "y"; easing.type: Easing.InOutQuad }
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
            if(exerciseInProgess()){
                console.log('exerciseTimer triggered');
                value--;
                if(value>0){
                    rightTextLunges.text = value + "s";
                    leftTextLunges.text = value + "s";
                }else{
                    rightTextLunges.text = "Switch!";
                    leftTextLunges.text = "Switch!";
                    value = exerciseDuration + 1;
                    exerciseLunges.switchFoot();
                }
                exerciseTimer.start();
            }
        }
    }

    Timer {
        id: returnToMenu
        interval: 2000
        onTriggered: {
            console.log('returnToMenu triggered');
            hudText.visible = false;
            exerciseLunges.visible = false;
            selectionMenu.startMenu();
        }
    }
}