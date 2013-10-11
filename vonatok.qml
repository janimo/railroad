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
		Train { image:"loco2.png" }
		Train { image:"loco3.png" }
		Train { image:"loco4.png" }
		Train { image:"loco5.png" }
		Train { image:"loco6.png"; clickable:false}
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
