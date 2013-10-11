import QtQuick 2.0
import QtMultimedia 5.0

Rectangle {
	height: 400
	width:800
	property int mx
	property int my
	Image {
		x:mx
		y:my
		source:"loco1.png"
	}

	MouseArea {
		anchors.fill:parent
		onPositionChanged: {mx = mouse.x; my = mouse.y}
		onPressed: train.play()
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
