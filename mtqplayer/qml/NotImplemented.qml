import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: notImplemented
    width: 4096
    height: 2400
    color: "#ff333333"

    Text {
        id: notImplementedText
        text: "This will be available soon!"
        width: 800
        height: 300
        x: floor.width/2 - notImplementedText.width/2
        y: 400
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 200
        color: "white"
    } 
}

