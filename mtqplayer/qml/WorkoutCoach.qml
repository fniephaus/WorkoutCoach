import QtQuick 2.0
import mtq.widgets 1.0

Rectangle {
    id: floor
    width: 4096
    height: 2400
    color: "#ff333333"
	
    WarmUp {
        id: warmUp
        visible: false
    }
    
    SelectionMenu {
        id: selectionMenu
    }

    Text {
        id: lText
        x: 1848
        y: 400
        width: 400
        height: 200
        horizontalAlignment: Text.AlignHCenter
        text: "Let's start with\nyour warm-up!"
        visible: false
        font.pointSize: 100
        color: "white"
    }
}
