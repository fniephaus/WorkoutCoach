import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: selectionMenu
    width: 4096
    height: 2400
    color: "#ff333333"
    property var targetVariables: ["","","",""]

    property var mainCategories: [["Make me sweat!", ""], ["Workouts", workoutCategories], ["Single Exercises", stretchingExercises], ["?", ""]]
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
            if(list == "lunges"){
                selectionMenu.visible = false;
                exerciseLunges.visible = true;
            }else{
                selectionMenu.visible = false;
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

    // FeetButton {
    //     id: centerFeet
    //     x: 1848
    //     y: 1000
    //     width: 400
    //     height: 400
    //     onMtqTapDown: {
    //         // if(selectionMenu.visible){
    //         //     startMenu();
    //         // }
    //     }
    // }

    Item {
        id: corners
        visible: true

        Rectangle {
            id: topLeft
            x: 0
            y: 0
            width: 800
            height: 600
            color: "#ff888888"
            BaseWidget {
                anchors.fill: parent;
                onMtqTapDown: {
                    if(selectionMenu.visible){
                        setFields(targetVariables[0]);
                    }
                }
            }
            Text {
                id: topLeftText
                width: parent.width
                height: parent.height
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
            y: 0
            width: 800
            height: 600
            color: "#ff888888"
            BaseWidget {
                anchors.fill: parent;
                onMtqTapDown: {
                    if(selectionMenu.visible){
                        setFields(targetVariables[1]);
                    }
                }
            }
            Text {
                id: topRightText
                width: parent.width
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 70
                color: "white"
                rotation: 45
            }
        }

        Rectangle {
            id: bottomLeft
            x: 0
            y: 1800
            width: 800
            height: 600
            color: "#ff888888"
            BaseWidget {
                anchors.fill: parent;
                onMtqTapDown: {
                    if(selectionMenu.visible){
                        setFields(targetVariables[2]);
                    }
                }
            }
            Text {
                id: bottomLeftText
                width: parent.width
                height: parent.height
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
            y: 1800
            width: 800
            height: 600
            color: "#ff888888"
            BaseWidget {
                anchors.fill: parent;
                onMtqTapDown: {
                    if(selectionMenu.visible){
                        setFields(targetVariables[3]);
                    }
                }
            }
            Text {
                id: bottomRightText
                width: parent.width
                height: parent.height
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

