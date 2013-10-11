import QtQuick 2.0
import QtMultimedia 5.0

// A train is an Image that makes a sound when clicked
// I wish it could be done in the same file as the script by just extending the Image type

Rectangle {
	id: train
	height:imageID.sourceSize.height
	width:imageID.sourceSize.width

	property url image
	property url sound

	Image {
		id: imageID
		anchors.fill:parent
		source: train.image
	}

	Audio {
		id: audio
		source: train.sound
	}

	MouseArea {
		anchors.fill:parent
		onClicked: if (parent.sound) audio.play()
	}
}
