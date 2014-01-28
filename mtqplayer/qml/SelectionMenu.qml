import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: selectionMenu
    width: 4096
    height: 2400
    color: "#ff333333"
    property var targetVariables: ["","","",""]

    property var mainCategories: [["Make me sweat!", ""], ["Workouts", workoutCategories], ["Single Exercises", stretchingExercises], ["Warm Up", "warmup"]]
    property var workoutCategories: [["Stretching", ""], ["Cardio", ""], ["BodyAttack", ""], ["Random", ""]]
    property var exerciseCategories: [["Stretching", stretchingExercises], ["Cardio", cardioExercises], ["Flexibility", ""], ["Stamina", ""]]
    property var stretchingExercises: [["Lunges", "lunges"], ["B", ""], ["C", ""], ["D", ""]]
    property var cardioExercises: [["Sequence", ""], ["B", ""], ["C", ""], ["D", ""]]

    function startMenu() {
        console.log('startMenu called');
        selectionMenu.visible = true;
        hudText.text = "Well done!\nNow make your selection!";
        setFields(mainCategories, false);
        selectionIntro.start();
    }

    function setFields(list, showBackButton){
        if (typeof list === "string"){
            selectionMenu.visible = false;
            switch(list){
                case "lunges":
                    exerciseLunges.startLunges();
                    break;
                case "warmup":
                    warmUp.visible = true;
                    warmUp.getReady();
                    break;
                default:
                    notImplemented.visible = true;
                    notImplementedTimer.start();
            }
        }else{
            topLeftText.text = list[0][0];
            topRightText.text = list[1][0];
            bottomLeftText.text = list[2][0];
            bottomRightText.text = list[3][0];

            for (var i = 0; i < 4; i++) {
                targetVariables[i] = list[i][1];
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
                        setFields(targetVariables[0]);
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
                        setFields(targetVariables[1]);
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
                        setFields(targetVariables[2]);
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
                        setFields(targetVariables[3]);
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
}

