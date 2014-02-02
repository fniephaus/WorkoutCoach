import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: selectionMenu
    width: 4096
    height: 2400
    color: "#ff333333"
    property var targetVariables: ["","","",""]


    property var exercisesToDo: []
    property var mainCategories: [["Make me sweat!", "makemesweat"], ["Workouts", workoutCategories], ["Single Exercises", singleExercises], ["Warm Up", "warmup"]]
    property var workoutCategories: [["Stretching", "stretching"], ["Cardio", "cardio"], ["BodyAttack", "bodyattack"], ["Random", "random"]]
    property var singleExercises: [["Lunges", "lunges"], ["High Knees", "highknees"], ["Jumping Jacks", "jumpingjacks"], ["Lateral Jumps", "lateraljumps"]]

    function startMenu() {
        if(selectionMenu.exercisesToDo.length > 0){
            hudText.visible = false;
            startNextExercise();
        }else{
            console.log('startMenu called');
            selectionMenu.visible = true;
            hudText.text = "Well done!\nNow make your selection!";
            setFields(mainCategories, false);
            selectionIntro.start();
        }
    }

    function setFields(list, showBackButton){
        if (typeof list === "string"){
            selectionMenu.visible = false;
            startExercise(list);
        }else{
            centerButtonSelectionMenu.visible = showBackButton;

            topLeftText.text = list[0][0];
            topRightText.text = list[1][0];
            bottomLeftText.text = list[2][0];
            bottomRightText.text = list[3][0];

            for (var i = 0; i < 4; i++) {
                targetVariables[i] = list[i][1];
            }
        }
    }

    function startNextExercise(){
        var nextExercise = selectionMenu.exercisesToDo.pop();
        startExercise(nextExercise);
    }

    function startExercise(name){
        switch(name){
            case "makemesweat":
                selectionMenu.exercisesToDo = ["warmup", "lunges", "lateraljumps", "jumpingjacks", "highknees"];
                startNextExercise();
                break;
            case "stretching":
                selectionMenu.exercisesToDo = ["lateraljumps", "lunges"];
                startNextExercise();
                break;
            case "cardio":
                selectionMenu.exercisesToDo = ["warmup", "jumpingjacks", "highknees"];
                startNextExercise();
                break;
            case "bodyattack":
                selectionMenu.exercisesToDo = ["lunges", "highknees", "lateraljumps"];
                startNextExercise();
                break;
            case "random":
                selectionMenu.exercisesToDo = suffle(["warmup", "lunges", "lateraljumps", "jumpingjacks", "highknees"]);
                startNextExercise();
                break;
            case "lunges":
                exerciseLunges.start();
                break;
            case "highknees":
                exerciseHighKnees.start();
                break;
            case "jumpingjacks":
                exerciseJumpingJacks.start();
                break;
            case "lateraljumps":
                exerciseLateralJumps.start();
                break;
            case "warmup":
                warmUp.restart();
                break;
            default:
                notImplemented.visible = true;
                notImplementedTimer.start();
        }
    }


    Rectangle {
        id: centerButtonSelectionMenu
        x: 1748
        y: 900
        width: 600
        height: 600
        visible: false
        radius: width * 0.5
        color: "grey"
        Text {
            text: "back"
            id: textSelectionMenuBack
            x: parent.width/2 - width/2
            y: 200
            width: 200
            height: 200
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 100
            color: "white"
        }
        BaseWidget {
            anchors.fill: parent;
            onMtqContactDown: {
                if(selectionMenu.visible){
                    setFields(mainCategories, false);
                }
            }
        }
    }

    Item {
        id: corners
        visible: true

        Rectangle {
            id: topLeft
            x: -800
            y: -800
            width: 1600
            height: 1600
            color: "#ff888888"
            radius: width * 0.5
            BaseWidget {
                anchors.fill: parent;
                onMtqContactDown: {
                    if(selectionMenu.visible){
                        setFields(targetVariables[0], true);
                    }
                }
            }
            Text {
                id: topLeftText
                width: parent.width
                height: parent.height
                x: parent.width/4
                y: parent.height/4
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 70
                color: "white"
                rotation: -45
            }
        }

        Rectangle {
            id: topRight
            x: 3296
            y: -800
            width: 1600
            height: 1600
            color: "#ff888888"
            radius: width * 0.5
            BaseWidget {
                anchors.fill: parent;
                onMtqContactDown: {
                    if(selectionMenu.visible){
                        setFields(targetVariables[1], true);
                    }
                }
            }
            Text {
                id: topRightText
                width: parent.width
                height: parent.height
                x: -parent.width/4
                y: parent.height/4
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 70
                color: "white"
                rotation: 45
            }
        }

        Rectangle {
            id: bottomLeft
            x: -800
            y: 1600
            width: 1600
            height: 1600
            color: "#ff888888"
            radius: width * 0.5
            BaseWidget {
                anchors.fill: parent;
                onMtqContactDown: {
                    if(selectionMenu.visible){
                        setFields(targetVariables[2], true);
                    }
                }
            }
            Text {
                id: bottomLeftText
                width: parent.width
                height: parent.height
                x: parent.width/4
                y: -parent.height/4
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 70
                color: "white"
                rotation: 225
            }
        }

        Rectangle {
            id: bottomRight
            x: 3296
            y: 1600
            width: 1600
            height: 1600
            color: "#ff888888"
            radius: width * 0.5
            BaseWidget {
                anchors.fill: parent;
                onMtqContactDown: {
                    if(selectionMenu.visible){
                        setFields(targetVariables[3], true);
                    }
                }
            }
            Text {
                id: bottomRightText
                width: parent.width
                height: parent.height
                x: -parent.width/4
                y: -parent.height/4
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 70
                color: "white"
                rotation: 135
            }
        }
    }

    Timer {
        id: selectionIntro
        interval: 2000
        onTriggered: {
            console.log('selectionIntro triggered');
            hudText.visible = false;
        }
    }

    Timer {
        id: notImplementedTimer
        interval: 4000
        onTriggered: {
            console.log('notImplementedTimer triggered');
            notImplemented.visible = false;
            selectionMenu.startMenu();
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

