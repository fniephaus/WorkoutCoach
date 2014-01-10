import QtQuick 2.0
import mtq.widgets 1.0

BaseWidget {
    id: floor
    width: 4096
    height: 2400
    // color: "#ff333333"

    WarmUp {
        id: warmUp
    }
    
    SelectionMenu {
        id: selectionMenu
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
        hudArea.x = event.mappedCenter.x - hudArea.width/2 + hudArea.width/3 * Math.sin(event.rotation/360*2*Math.PI);
        hudArea.y = event.mappedCenter.y - hudArea.height/2 - hudArea.width/3 * Math.cos(event.rotation/360*2*Math.PI);
        hudArea.rotation = event.rotation;
    }
}
