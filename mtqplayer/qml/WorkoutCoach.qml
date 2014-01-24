import QtQuick 2.0
import mtq.widgets 1.0

BaseWidget {
    id: floor
    width: 4096
    height: 2400

    property int rotation: 0

    WarmUp {
        id: warmUp
        // visible: false
    }
        
    SelectionMenu {
        id: selectionMenu
        visible: false
    }

    ExerciseLunges {
        id: exerciseLunges
        visible: false
    }

    NotImplemented {
        id: notImplemented
        visible: false
    }

    Rectangle {
        id: hudArea
        x: 1148
        y: 200
        width: 1800
        height: 600
        // color: "#88ffffff"
        color: "#00000000"
        Text {
            id: hudText
            x: 700
            y: 200
            width: 400
            height: 200
            horizontalAlignment: Text.AlignHCenter
            visible: false
            font.pointSize: 100
            color: "white"
        }

        Image {
            id: hudImage
            width: 2000;
            height: 1500;
            x: parent.width/2-width/2;
            y: parent.height/2-height/3;
            sourceSize.width: 800;
            sourceSize.height: 600;
            visible: false;
        }
        
    }
    
    onMtqContactMove: {
        // rotation += 2;
        if(event.foot == 'right'){
            hudArea.x = event.mappedCenter.x - hudArea.width/2 + hudArea.width/3 * Math.sin(event.rotation);
            hudArea.y = event.mappedCenter.y - hudArea.height/2 - hudArea.width/3 * Math.cos(event.rotation);
            hudArea.rotation = event.rotation;
        }
        moveRect.x = event.mappedCenter.x;
        moveRect.y = event.mappedCenter.y;
    }

    Rectangle {
        visible: true
        id: moveRect
        color: "#ffffff"
        width: 1
        height: 1
        Rectangle {
            color: "#ffffff"
            x: -50
            y: -2.5
            width: 100
            height: 5
        }
        Rectangle {
            color: "#ffffff"
            x: -2.5
            y: -50
            width: 5
            height: 100
        }

    }
}
