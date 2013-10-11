import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
	height: 600
	width: 1200

	Row {
		spacing:5
		Repeater {
			model: 9
			Train { image:"loco%1.png".arg(index+1) }
		}
	}
}
