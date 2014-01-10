import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: exerciseLunges
    width: 4096
    height: 2400
    color: "#ff333333"

    function start(){
        exerciseLunges.visible = true;
        hudImage.source = "../resources/svg/InstructionsLunges.svg";
        hudImage.visible = true;
        hudImage.width = 900;
        hudImage.height = 454;
        hudImage.rotation = 30;
        hudImage.x = leftFoot.x + hudImage.height/2;
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
        }
        FootButton {
            id: rightFoot
            type: 'right'
            x: exerciseWrapper.width/2 + rightFoot.width/2 + 20
            y: 1600
            onMtqTapDown: {
                exerciseLunges.start();
            }
        }


    }
}