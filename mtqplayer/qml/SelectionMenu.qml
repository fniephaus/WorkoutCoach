import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: selectionMenu
    width: 4096
    height: 2400
    color: "#ff333333"
    property var targetVariables: ["","","",""]

    property var mainCategories: [["Make me sweat!", ""], ["Workouts", workoutCategories], ["Single Exercises", exerciseCategories], ["?", ""]]
    property var workoutCategories: [["Stretching", stretchingExercises], ["Cardio", cardioExercises], ["BodyAttack", ""], ["Random", ""]]
    property var exerciseCategories: [["Flexibility", ""], ["Stamina", ""], ["C", ""], ["D", ""]]
    property var stretchingExercises: [["Lunges", ""], ["B", ""], ["C", ""], ["D", ""]]
    property var cardioExercises: [["Sequence", ""], ["B", ""], ["C", ""], ["D", ""]]

    function startSelectionMenu() {
        selectionMenu.visible = true;
        lText.text = "Well done!\nNow make your selection!";
    }

    function setFields(list, showBackButton){
        topLeftText.text = list[0][0];
        topRightText.text = list[1][0];
        bottomLeftText.text = list[2][0];
        bottomRightText.text = list[3][0];

        for (var i = 0; i < 4; i++) {
            targetVariables[i] = list[i][1];
        }
    }

    FeetButton {
        id: centerFeet
        x: 1848
        y: 1000
        width: 400
        height: 400
        onPressed: {
            lText.visible = false;
            setFields(mainCategories, false);
        }
    }

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
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if(targetVariables[0] != ""){
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
                font.pointSize: 80
                color: "white"
            }
        }

        Rectangle {
            id: topRight
            x: 3296
            y: 0
            width: 800
            height: 600
            color: "#ff888888"
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    console.log(targetVariables);

                    if(targetVariables[1]!=""){
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
                font.pointSize: 80
                color: "white"
            }
        }

        Rectangle {
            id: bottomLeft
            x: 0
            y: 1800
            width: 800
            height: 600
            color: "#ff888888"
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if(targetVariables[2]!=""){
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
                font.pointSize: 80
                color: "white"
            }
        }

        Rectangle {
            id: bottomRight
            x: 3296
            y: 1800
            width: 800
            height: 600
            color: "#ff888888"
            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    if(targetVariables[3]!=""){
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
                font.pointSize: 80
                color: "white"
            }
        }
    }
}

