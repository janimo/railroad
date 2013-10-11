import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
	height: 400
	width:800
	property int mx
	property int my

	Image {
		id:img
		x:mx
		y:my
		source:"loco1.png"
	}

	Row {
		spacing:5
		Repeater {
			model: 9
			Train { image:"loco%1.png".arg(index+1) }
		}
	}

	MouseArea {
		anchors.fill:img
		onPositionChanged: {mx = mouse.x; my = mouse.y}
		onClicked: train.play()
	}

	Audio {
		id: train
		source:"train.wav"
	}

	Audio {
		id: bonus
		source:"bonus.wav"
	}
}
