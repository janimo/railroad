import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
	height: 600
	width: 1200

	//Background image
	Image {
		width: parent.width
		height: parent.height
		source: "railroad-bg.svg"
	}

	//Show all locomotives
	Grid {
		id: locos
		spacing:5
		columns: 5
		rows:2
		Repeater {
			model: 9
			Train { image:"loco%1.png".arg(index+1); sound: "train.wav" }
		}
	}

	//Show all wagons
	Grid {
		id: wagons
		anchors.top: locos.bottom
		spacing:5
		columns: 5
		rows:3
		Repeater {
			model: 14
			Train { image:"wagon%1.png".arg(index+1) }
		}
	}
}
