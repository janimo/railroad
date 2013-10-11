import QtQuick 2.0
import QtMultimedia 5.0

// A train is an Image that makes a sound when clicked
// I wish it could be done in the same file as the script by just extending the Image type

Rectangle {
	id: train
	height:80; width:160

	property url image: "loco5.png"
	property url sound: "train.wav"

	property bool clickable : true

	Image {
		anchors.fill:parent
		source: train.image
	}

	Audio {
		id: audio
		source: train.sound
	}

	MouseArea {
		anchors.fill:parent
		onClicked: if (parent.clickable) audio.play()
	}
}
